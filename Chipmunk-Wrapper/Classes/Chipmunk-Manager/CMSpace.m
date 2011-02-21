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

static void forEachShapeQueryFuncion(cpBB *boundingBox, cpShape *shape, CMQueryFunctionHandler *context) {
	NSInvocation *invocation = [context queryFunction];
	
	CMData *cmData = shape->data;
	CMShape *cmShape = (CMShape*)[cmData object];
	
	id data = [context data];
	@try {
		[invocation setArgument:&boundingBox atIndex:2];
		[invocation setArgument:&cmShape atIndex:3];
		[invocation setArgument:&data atIndex:4];
	}
	@catch (NSException *e) {
		//No biggie, continue!
	}
	
	[invocation invoke];
}

static void postStepCallback(cpSpace *space, cpShape *shape, void *data) {
	CMPostCallbackHandler *handler = (CMPostCallbackHandler*)data;
	NSInvocation *invocation = [handler postCallback];
	id handlerData = [handler data];
	@try {
		[invocation setArgument:&handlerData atIndex:2];
	}
	@catch (NSException *e) {
		//No biggie, continue!
	}
	
	[invocation invoke];
	
	// CMPostCallbackHandlers are only used once
	// so we need to release them after being used.
	[handler release];
}

static int handleInvocations(CollisionMoment moment, cpArbiter *arbiter, struct cpSpace *space, void *data) {
	CMCollisionHandler *handler = (CMCollisionHandler*)data;
	if ([handler ignoreContainmentCollision]) {
		if (arbiter->a->collision_type == CM_WINDOW_CONTAINMENT_COLLISION_TYPE || 
			arbiter->b->collision_type == CM_WINDOW_CONTAINMENT_COLLISION_TYPE) {
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
		[spObject setY:shape->body->p.y];
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

- (void)setGravity:(cpVect)gravity {
	mCpSpace->gravity = gravity;
}

- (void)setDamping:(float)damping {
	mCpSpace->damping = damping;
}

- (void)setSleepTimeThreshhold:(float)threshold {
	mCpSpace->sleepTimeThreshold = threshold;
}

- (void)setIterations:(int)iterations {
	mCpSpace->iterations = iterations;
	mCpSpace->elasticIterations = iterations;
}

- (void)step:(float)framerate {
	cpSpaceStep(mCpSpace, framerate);
}

- (void)updateShapes {
	cpSpaceHashEach(mCpSpace->activeShapes, &updateShape, nil);
}

-(CMBody*)addWindowContainmentWithWidth:(float)width height:(float)height elasticity:(float)elasticity friction:(float)friction {
	CM_CREATE_POOL(pool);
	
	CMBody *body = [self addStaticBody];
	// TODO: Maybe not the best place..
	[mBodies addObject:body];
	CMSegmentShape *topWall =  [body addSegmentFrom:cpv(0, height + 1) to:cpv(width, height + 1) radius:1];
	[topWall setCollisionType:CM_WINDOW_CONTAINMENT_COLLISION_TYPE];
	[topWall setElasticity:elasticity];
	[topWall setFriction:friction];
	
	CMSegmentShape *rightWall = [body addSegmentFrom:cpv(width + 1, height) to:cpv(width + 1, 0) radius:1];
	[rightWall setCollisionType:CM_WINDOW_CONTAINMENT_COLLISION_TYPE];
	[rightWall setElasticity:elasticity];
	[rightWall setFriction:friction];
	
	CMSegmentShape *bottomWall = [body addSegmentFrom:cpv(0, 0) to:cpv(width, 0) radius:1];
	[bottomWall setCollisionType:CM_WINDOW_CONTAINMENT_COLLISION_TYPE];
	[bottomWall setElasticity:elasticity];
	[bottomWall setFriction:friction];
	
	CMSegmentShape *leftWall = [body addSegmentFrom:cpv(-1, 0) to:cpv(-1, height) radius:1];
	[leftWall setCollisionType:CM_WINDOW_CONTAINMENT_COLLISION_TYPE];
	[leftWall setElasticity:elasticity];
	[leftWall setFriction:friction];
	
	[topWall addToSpace];
	[rightWall addToSpace];
	[bottomWall addToSpace];
	[leftWall addToSpace];
	
	CM_RELEASE_POOL(pool);
	
	return body;
}

- (CMShape*)queryFirstByPoint:(SPPoint*)point {
	return [self queryFirstByVect:[point toCpVect]];
}

- (CMShape*)queryFirstByVect:(cpVect)point {
	return [self queryFirstByVect:point layers:CP_ALL_LAYERS group:CP_NO_GROUP];
}

- (CMShape*)queryFirstByPoint:(SPPoint*)point layers:(cpLayers)layers group:(cpGroup)group {
	return [self queryFirstByVect:[point toCpVect] layers:layers group:group];
}

- (CMShape*)queryFirstByVect:(cpVect)vect layers:(cpLayers)layers group:(cpGroup)group {
	cpShape *shape = cpSpacePointQueryFirst(mCpSpace, vect, layers, group);
	if (shape != NULL) {
		CMData *cmData = (CMData*)shape->data;
		return [cmData object];
	}
	
	return nil;
}

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

- (CMBody*)findBody:(NSString*)name {
	for (CMBody *body in mBodies) {
		if ([[body name] isEqualToString:name]) {
			return body;
		}
	}
	
	return nil;
}

- (void)removeBody:(CMBody*)body {
	[mBodies removeObject:body];
}

- (void)addPostStepCallback:(id)target selector:(SEL)selector data:(id)data {
	CMPostCallbackHandler *postCallbackHandler = [[CMPostCallbackHandler alloc] initWithTarget:target selector:selector];
	[postCallbackHandler setData:data];
	
	cpSpaceAddPostStepCallback(mCpSpace, (cpPostStepFunc)postStepCallback, postCallbackHandler, postCallbackHandler);
}

- (void)forEachShape:(id)target selector:(SEL)selector boundingBox:(cpBB)boundingBox data:(id)data {
	CMQueryFunctionHandler *queryFunctionHandler = [[CMQueryFunctionHandler alloc] initWithTarget:target selector:selector];
	[queryFunctionHandler setData:data];
	cpSpaceHashQuery(mCpSpace->activeShapes, &boundingBox, boundingBox, (cpSpaceHashQueryFunc)forEachShapeQueryFuncion, queryFunctionHandler);
	[queryFunctionHandler release];
}


-(void)addDefaultCollisionHandler:(id)target begin:(SEL)begin preSolve:(SEL)preSolve postSolve:(SEL)postSolve separate:(SEL)separate ignoreContainmentCollisions:(BOOL)ignoreContainmentCollisions {
	CM_CREATE_POOL(pool);
	
	if (mDefaultCollisionHandler != nil) {
		// Cannot remove old default handler?
		[mDefaultCollisionHandler release];
	}
	
	mDefaultCollisionHandler = [[CMCollisionHandler alloc] init];
	[mDefaultCollisionHandler setInvocationBegin:target selector:begin];
	[mDefaultCollisionHandler setInvocationPreSolve:target selector:preSolve];
	[mDefaultCollisionHandler setInvocationPostSolve:target selector:postSolve];
	[mDefaultCollisionHandler setInvocationSeparate:target selector:separate];
	
	[mDefaultCollisionHandler setIgnoreContainmentCollision:ignoreContainmentCollisions];
	
	cpSpaceSetDefaultCollisionHandler(mCpSpace, collisionBegin, collisionPreSolve, collisionPostSolve, collisionSeparate, mDefaultCollisionHandler);
	
	CM_RELEASE_POOL(pool);
}

-(void) addCollisionHandlerBetween:(cpCollisionType)typeA andTypeB:(cpCollisionType)typeB target:(id)target selector:(SEL)selector {
	[self addCollisionHandlerBetween:typeA andTypeB:typeB target:target begin:selector preSolve:selector postSolve:selector separate:selector];
}

-(void) addCollisionHandlerBetween:(cpCollisionType)typeA andTypeB:(cpCollisionType)typeB target:(id)target begin:(SEL)begin preSolve:(SEL)preSolve postSolve:(SEL)postSolve separate:(SEL)separate {
	CM_CREATE_POOL(pool);
	
	CMCollisionHandler *handler = [[[CMCollisionHandler alloc] initWithTypeA:typeA andTypeB:typeB] autorelease];
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
	
	CM_RELEASE_POOL(pool);
}

-(void) removeCollisionHandlerFor:(cpCollisionType)typeA andTypeB:(cpCollisionType)typeB {
	for (CMCollisionHandler *handler in mCollisionHandlers) {
		if (handler.typeA == typeA && handler.typeB == typeB) {
			[mCollisionHandlers removeObject:handler];
			break;
		}
	}
	
	cpSpaceRemoveCollisionHandler(mCpSpace, typeA, typeB);
}

/**
 * Dealocates the CMSpace object.
 */
- (void) dealloc {
	[mBodies release];

	cpSpaceFree(mCpSpace);
	
	if (mDefaultCollisionHandler != nil) {
		[mDefaultCollisionHandler release];
	}
	
	[mCollisionHandlers release];
	
	[super dealloc];
}

@end
