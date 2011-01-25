//
//  CPFactory.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "CMSpace.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

static int handleInvocations(CollisionMoment moment, cpArbiter *arbiter, struct cpSpace *space, void *data) {
	CMCollisionHandler *handler = (CMCollisionHandler*)data;
	if ([handler ignoreContainmentCollision]) {
		if (arbiter->a->collision_type == 1000000 || arbiter->b->collision_type == 1000000) {
			return YES;
		}
	}
	
	NSInvocation *invocation;
	if (moment == CMCollisionBegin) {
		invocation = [handler invocationBegin];
	} else if (moment == CMCollisionPreSolve) {
		invocation = [handler invocationPreSolve];
	} else if (moment == CMCollisionPostSolve) {
		invocation = [handler invocationPostSolve];
	} else if (moment == CMCollisionSeparate) {
		invocation = [handler invocationSeparate];
	}
	
	CMArbiter *cmArbiter = [[CMArbiter alloc] initWithCpArbiter:arbiter];
	CMSpace *cmSpace = [[cmArbiter shapeA] space];
	@try {
		[invocation setArgument:&cmArbiter atIndex:2];
		[invocation setArgument:&cmSpace atIndex:3];
	}
	@catch (NSException *e) {
			//No biggie, continue!
	}
	
	[invocation invoke];
	
	//default is yes, thats what it is in chipmunk
	BOOL retVal = YES;
	
	//not sure how heavy these methods are...
	if ([[invocation methodSignature]  methodReturnLength] > 0) {
		[invocation getReturnValue:&retVal];
	}
	
	[cmArbiter release];
	
	return retVal;
}

static int collisionBegin(cpArbiter *arbiter, struct cpSpace *space, void *data) {
	return handleInvocations(CMCollisionBegin, arbiter, space, data);
}

static int collisionPreSolve(cpArbiter *arbiter, struct cpSpace *space, void *data) {
	return handleInvocations(CMCollisionPreSolve, arbiter, space, data);
}

static void collisionPostSolve(cpArbiter *arbiter, struct cpSpace *space, void *data) {
	handleInvocations(CMCollisionPostSolve, arbiter, space, data);
}

static void collisionSeparate(cpArbiter *arbiter, struct cpSpace *space, void *data) {
	handleInvocations(CMCollisionSeparate, arbiter, space, data);
}

void updateShape(void *cpShapePtr, void* unused) {
	cpShape *shape = (cpShape*)cpShapePtr;
	if(shape == nil || shape->body == nil || shape->body->data == nil) {
		return;
	}
	
	if([shape->body->data isKindOfClass:[CMData class]]) {
		CMData *data = (CMData*)shape->body->data;
		
		SPDisplayObject *spObject = (SPDisplayObject*)[data data];

		[spObject setX:shape->body->p.x];
		[spObject setY:480-(shape->body->p.y)];
		[spObject setRotation:shape->body->a];
	}
}

// --- private interface ---------------------------------------------------------------------------

@interface CMSpace ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMSpace

@synthesize cpSpace = mCpSpace;

- (id) init {
	self = [super init];
	if (self != nil) {
		cpInitChipmunk();
		
		mCpSpace = cpSpaceNew();
		mCpSpace->gravity = cpv(0, 9.8*10);
		mCpSpace->elasticIterations = mCpSpace->iterations;
		
		mCollisionHandlers = [[NSMutableArray alloc] init];
		mBodies = [[NSMutableArray alloc] init];
	}
	return self;
}

#pragma mark General properties

- (void)setGravity:(cpVect)gravity {
	mCpSpace->gravity = gravity;
}

- (void)setDamping:(float)damping {
	mCpSpace->damping = damping;
}

- (void)setSleepTimeThreshhold:(float)threshold {
	mCpSpace->sleepTimeThreshold = threshold;
}

#pragma mark -

#pragma mark Operations

- (CMShape*)findShapeAtPosition:(cpVect)position {
	cpShape *shape = cpSpacePointQueryFirst(mCpSpace, position, 1<<31, CP_NO_GROUP);
	if (shape != NULL) {
		CMData *cmData = (CMData*)shape->data;
		return [cmData object];
	}
	
	return nil;
}

- (CMShape*)findShapeAtPoint:(SPPoint*)point {
	return [self findShapeAtPosition:[point toCpVect]];
}

- (void)step:(float)framerate {
	cpSpaceStep(mCpSpace, framerate);
}

- (void)updateShapes {
	cpSpaceHashEach(mCpSpace->activeShapes, &updateShape, nil);
}

- (void)free {
	cpSpaceFreeChildren(mCpSpace);	
	cpSpaceFree(mCpSpace);
}

#pragma mark -

#pragma mark Window containment

-(CMBody*)addWindowContainmentWithWidth:(float)width height:(float)height {
	CMBody *body = [self addStaticBody];
	
	CMSegmentShape *topWall =  [body addSegmentFrom:cpv(0, height) to:cpv(width, height) radius:1];
	[topWall setCollisionType:1000000];
	[topWall setElasticity:0.5];
	[topWall setFriction:0.1];
	
	CMSegmentShape *rightWall = [body addSegmentFrom:cpv(width + 1, height) to:cpv(width + 1, 0) radius:1];
	[rightWall setCollisionType:1000000];
	[rightWall setElasticity:0.5];
	[rightWall setFriction:0.1];
	
	CMSegmentShape *bottomWall = [body addSegmentFrom:cpv(0, 1) to:cpv(width, 1) radius:1];
	[bottomWall setCollisionType:1000000];
	[bottomWall setElasticity:0.5];
	[bottomWall setFriction:0.1];
	
	CMSegmentShape *leftWall = [body addSegmentFrom:cpv(0, 0) to:cpv(0, height) radius:1];
	[leftWall setCollisionType:1000000];
	[leftWall setElasticity:0.5];
	[leftWall setFriction:0.1];
	
	[topWall addToSpace];
	[rightWall addToSpace];
	[bottomWall addToSpace];
	[leftWall addToSpace];
	
	return body;
}

#pragma mark -

#pragma mark Body create

- (CMBody*)addStaticBody {
	CMBody *body = [[[CMBody alloc] initStatic] autorelease];
	[body setSpace:self];
	[mBodies addObject:body];
	return body;
}

- (CMBody*)addBody {
	CMBody *body = [self addBodyWithMass:INFINITY moment:INFINITY];
	return body;
}

- (CMBody*)addBodyWithMass:(float)mass moment:(float)moment {
	CMBody *body = [[[CMBody alloc] initWithMass:mass moment:moment] autorelease];
	[body setSpace:self];
	[mBodies addObject:body];
	
	return body; 
}

#pragma mark -

#pragma mark Collission detection

-(void)addDefaultCollisionHandler:(id)target begin:(SEL)begin preSolve:(SEL)preSolve postSolve:(SEL)postSolve separate:(SEL)separate ignoreContainmentCollisions:(BOOL)ignoreContainmentCollisions {
	CMCollisionHandler *handler = [[CMCollisionHandler alloc] init];
	[handler setInvocationBegin:target selector:begin];
	[handler setInvocationPreSolve:target selector:preSolve];
	[handler setInvocationPostSolve:target selector:postSolve];
	[handler setInvocationSeparate:target selector:separate];
	
	[handler setIgnoreContainmentCollision:ignoreContainmentCollisions];
	
	cpSpaceSetDefaultCollisionHandler(mCpSpace, collisionBegin, collisionPreSolve, collisionPostSolve, collisionSeparate, handler);
}

-(void) addCollisionHandlerBetween:(unsigned int)typeA andTypeB:(unsigned int)typeB target:(id)target selector:(SEL)selector {
	[self addCollisionHandlerBetween:typeA andTypeB:typeB target:target begin:selector preSolve:selector postSolve:selector separate:selector];
}

-(void) addCollisionHandlerBetween:(unsigned int)typeA andTypeB:(unsigned int)typeB target:(id)target begin:(SEL)begin preSolve:(SEL)preSolve postSolve:(SEL)postSolve separate:(SEL)separate {
	CMCollisionHandler *handler = [[CMCollisionHandler alloc] initWithTypeA:typeA andTypeB:typeB];
	[handler setInvocationBegin:target selector:begin];
	[handler setInvocationPreSolve:target selector:preSolve];
	[handler setInvocationPostSolve:target selector:postSolve];
	[handler setInvocationSeparate:target selector:separate];
	
	//add the callback to chipmunk
	cpSpaceAddCollisionHandler(mCpSpace, typeA, typeB, 
							   begin != nil ? collisionBegin : nil, 
							   preSolve != nil ? collisionPreSolve : nil, 
							   postSolve != nil ? collisionPostSolve : nil, 
							   separate != nil ? collisionSeparate : nil, 
							   handler);
	
	//we'll keep a ref so it won't disappear, prob could just retain and clear hash later
	[mCollisionHandlers addObject:handler];
	
}

-(void) removeCollisionHandlerFor:(unsigned int)typeA andTypeB:(unsigned int)typeB {
	for (CMCollisionHandler *handler in mCollisionHandlers) {
		if (handler.typeA == typeA && handler.typeB == typeB) {
			[mCollisionHandlers removeObject:handler];
			break;
		}
	}
	
	cpSpaceRemoveCollisionHandler(mCpSpace, typeA, typeB);
}

#pragma mark -

- (void) dealloc {
	[mBodies release];
	[mCollisionHandlers release];
	
	[super dealloc];
}


@end
