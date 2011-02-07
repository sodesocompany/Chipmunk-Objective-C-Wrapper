//
//  CMBody.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "CMBody.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMBody ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMBody

@synthesize cpBody = mCpBody;
@synthesize shapes = mShapes;
@synthesize constraints = mConstraints;

- (id) initWithMass:(float)mass moment:(float)moment {
	if (self = [super init]) {
		mCpBody = cpBodyNew(mass, moment);
		mCpBody->data =[[CMData createWithObject:self] retain];

		mShapes = [[NSMutableArray alloc] init];
		mConstraints = [[NSMutableArray alloc] init];
	}
	return self;
}

- (id) initStatic {
	if (self = [super init]) {
		mCpBody = cpBodyNewStatic();
		mCpBody->data =[[CMData createWithObject:self] retain];
		
		mShapes = [[NSMutableArray alloc] init];
		mConstraints = [[NSMutableArray alloc] init];
	}
	
	return self;
}

#pragma mark Properties

- (void)setMass:(float)mass {
	cpBodySetMass(mCpBody, mass);
}

- (void)setMoment:(float)moment {
	cpBodySetMoment(mCpBody, moment);
}

- (void) setVelocity:(cpVect)velocity {
	cpBodySetVel(mCpBody, velocity);
}

- (void) setForce:(cpVect)force {
	mCpBody->f = force;
}

- (void) setPositionUsingVect:(cpVect)coordinate {
	mCpBody->p = coordinate;
}

- (void) setPositionUsingPoint:(SPPoint*)coordinate {
	mCpBody->p = [coordinate toCpVect];
}

- (void) setAngle:(float)angle {
	cpBodySetAngle(mCpBody, angle);
}

- (float) getAngle {
	return mCpBody->a;
}

- (void) setAngularVelocity:(float)velocity {
	mCpBody->w = velocity;
}

- (void) setTorque:(float)torque {
	mCpBody->t = torque;
}

- (float) getTorque {
	return mCpBody->t;
} 

- (void)setData:(id)data {
	CMData *cmData = (CMData*)mCpBody->data;
	[cmData setData:data];
}

- (id)getData {
	CMData *cmData = (CMData*)mCpBody->data;
	return [cmData data];
}

#pragma mark -

#pragma mark Operations

- (void) applyImpulse:(cpVect)impulse offset:(cpVect)offset {
	cpBodyApplyImpulse(mCpBody, impulse, offset);
}

- (void) applyForce:(cpVect)force offset:(cpVect)offset {
	cpBodyApplyForce(mCpBody, force, offset);
}

- (void) resetForces {
	cpBodyResetForces(mCpBody);
}

- (void) sleep {
	cpBodySleep(mCpBody);
}

- (void) wakeUp {
	cpBodyActivate(mCpBody);
}

- (void) addToSpace {
	cpSpaceAddBody([mSpace cpSpace], mCpBody);
}

- (void) removeFromSpace {
	[mSpace removeBody:self];
}

#pragma mark -

#pragma mark Shapes

- (CMCircleShape*) addCircleWithRadius:(float)radius {
	return [self addCircleWithRadius:radius offset:cpvzero];
}

- (CMCircleShape*) addCircleWithRadius:(float)radius offset:(cpVect)offset {
	CMCircleShape *shape = [[[CMCircleShape alloc] initWithBody:self radius:radius offset:offset] autorelease];
	[shape setSpace:mSpace];
	[mShapes addObject:shape];
	
	return shape;
}

- (CMRectShape*) addRectangleWithWidth:(float)width height:(float)height {
	return [self addRectangleWithWidth:width height:height offset:cpvzero];
}

- (CMRectShape*) addRectangleWithWidth:(float)width height:(float)height offset:(cpVect)offset {
	CMRectShape *shape = [[[CMRectShape alloc] initWithBody:self width:width height:height offset:offset] autorelease];
	[shape setSpace:mSpace];
	[mShapes addObject:shape];
	
	return shape;
}

- (CMPolyShape*) addPolyWithPoints:(int)numberOfVertices vertices:(cpVect)vertices, ... {
	va_list args;
	va_start(args,vertices);
	
	CMPolyShape *shape = [[[CMPolyShape alloc] initWithBody:self numberOfVertices:numberOfVertices firstVertice:vertices withParameters:args] autorelease];
	[shape setSpace:mSpace];
	[mShapes addObject:shape];
	va_end(args);

	return shape;
}

- (CMPolyShape*) addPolyWithPoints:(int)numberOfVertices offset:(cpVect)offset vertices:(cpVect)vertices, ... {
	va_list args;
	va_start(args,vertices);
	
	CMPolyShape *shape = [[[CMPolyShape alloc] initWithBody:self numberOfVertices:numberOfVertices offset:offset firstVertice:vertices withParameters:args] autorelease];
	[shape setSpace:mSpace];
	[mShapes addObject:shape];
	va_end(args);
	
	return shape;
}

- (CMPolyShape*) addPolyWithPoints:(NSArray*)vertices {
	CMPolyShape *shape = [[[CMPolyShape alloc] initWithBody:self vertices:vertices] autorelease];
	[shape setSpace:mSpace];
	[mShapes addObject:shape];
	
	return shape;
	
}

- (CMSegmentShape*) addSegmentFrom:(cpVect)from to:(cpVect)to radius:(float)radius {
	CMSegmentShape *shape = [[[CMSegmentShape alloc] initWithBody:self from:from to:to radius:radius] autorelease];
	[shape setSpace:mSpace];
	[mShapes addObject:shape];
	
	return shape;
}

- (void)removeShape:(CMShape*)shape {
	[mShapes removeObject:shape];
}

#pragma mark -

#pragma mark Constraints

- (void)removeConstraint:(CMConstraint*)constraint {
	[mConstraints removeObject:constraint];
}

- (CMSimpleMotorConstraint*) addSimpleMotorConstraintWithBody:(CMBody*)cmBody rate:(float)rate {
	CMSimpleMotorConstraint *constraint = [[[CMSimpleMotorConstraint alloc] initBetweenBody:self andBody:cmBody rate:rate] autorelease];
	[constraint setSpace:mSpace];
	[mConstraints addObject:constraint];
	
	return constraint;
}

- (CMPinJointConstraint*) addPinJointConstraintWithBody:(CMBody*)cmBody anchor1:(cpVect)anchor1 anchor2:(cpVect)anchor2 {
	CMPinJointConstraint *constraint = [[[CMPinJointConstraint alloc] initBetweenBody:self andBody:cmBody anchor1:anchor1 anchor2:anchor2] autorelease];
	[constraint setSpace:mSpace];
	[mConstraints addObject:constraint];
	
	return constraint;
}

- (CMDampedRotarySpringConstraint*) addDampedRotaryConstraintWithBody:(CMBody*)cmBody restAngle:(float)restAngle stiffness:(float)stiffness damping:(float)damping {
	CMDampedRotarySpringConstraint *constraint = [[[CMDampedRotarySpringConstraint alloc] initBetweenBody:self andBody:cmBody restAngle:restAngle stiffness:stiffness damping:damping] autorelease];
	[constraint setSpace:mSpace];
	[mConstraints addObject:constraint];
	
	return constraint;
}

- (CMDampedSpringConstraint*) addDampedSpringConstraintWithBody:(CMBody*)cmBody anchor1:(cpVect)anchor1 anchor2:(cpVect)anchor2 restLength:(float)restLength stiffness:(float)stiffness damping:(float)damping {
	CMDampedSpringConstraint *constraint = [[[CMDampedSpringConstraint alloc] initBetweenBody:self andBody:cmBody anchor1:anchor1 anchor2:anchor2 restLength:restLength stiffness:stiffness damping:damping] autorelease];
	[constraint setSpace:mSpace];
	[mConstraints addObject:constraint];
	
	return constraint;
}

- (CMGearJointConstraint*) addGearJointConstraintWithBody:(CMBody*)cmBody phase:(float)phase ratio:(float)ratio {
	CMGearJointConstraint *constraint = [[[CMGearJointConstraint alloc] initBetweenBody:self andBody:cmBody phase:phase ratio:ratio] autorelease];
	[constraint setSpace:mSpace];
	[mConstraints addObject:constraint];
	
	return constraint;
}

- (CMGrooveJointConstraint*) addGrooveJointConstraintWithBody:(CMBody*)cmBody grooveA:(cpVect)grooveA grooveB:(cpVect)grooveB anchor1:(cpVect)anchor1 {
	CMGrooveJointConstraint *constraint = [[[CMGrooveJointConstraint alloc] initBetweenBody:self andBody:cmBody grooveA:grooveA grooveB:grooveB anchor1:anchor1] autorelease];
	[constraint setSpace:mSpace];
	[mConstraints addObject:constraint];
	
	return constraint;
}

- (CMPivotJointConstraint*) addPivotJointConstraintWithBody:(CMBody*)cmBody anchor1:(cpVect)anchor1 anchor2:(cpVect)anchor2 {
	CMPivotJointConstraint *constraint = [[[CMPivotJointConstraint alloc] initBetweenBody:self andBody:cmBody anchor1:anchor1 anchor2:anchor2] autorelease];
	[constraint setSpace:mSpace];
	[mConstraints addObject:constraint];
	
	return constraint;
}

- (CMPivotJointConstraint*) addPivotJointConstraintWithBody:(CMBody*)cmBody pivot:(cpVect)pivot {
	CMPivotJointConstraint *constraint = [[[CMPivotJointConstraint alloc] initBetweenBody:self andBody:cmBody pivot:pivot] autorelease];
	[constraint setSpace:mSpace];
	[mConstraints addObject:constraint];
	
	return constraint;
}

- (CMRatchetJointConstraint*) addRatchetJointConstraintWithBody:(CMBody*)cmBody phase:(float)phase ratchet:(float)ratchet {
	CMRatchetJointConstraint *constraint = [[[CMRatchetJointConstraint alloc] initBetweenBody:self andBody:cmBody phase:phase ratchet:ratchet] autorelease];
	[constraint setSpace:mSpace];
	[mConstraints addObject:constraint];
	
	return constraint;
}

- (CMRotaryLimitConstraint*) addRotaryLimitConstraintWithBody:(CMBody*)cmBody min:(float)min max:(float)max {
	CMRotaryLimitConstraint *constraint = [[[CMRotaryLimitConstraint alloc] initBetweenBody:self andBody:cmBody min:min max:max] autorelease];
	[constraint setSpace:mSpace];
	[mConstraints addObject:constraint];
	
	return constraint;
}

- (CMSlideJointConstraint*) addSlideJointConstraintWithBody:(CMBody*)cmBody anchor1:(cpVect)anchor1 anchor2:(cpVect)anchor2 min:(float)min max:(float)max {
	CMSlideJointConstraint *constraint = [[[CMSlideJointConstraint alloc] initBetweenBody:self andBody:cmBody anchor1:anchor1 anchor2:anchor2 min:min max:max] autorelease];
	[constraint setSpace:mSpace];
	[mConstraints addObject:constraint];

	return constraint;
}

#pragma mark -

/**
 * Default dealloc method.
 */
- (void) dealloc {
	[mConstraints release];
	[mShapes release];
	
	CMData *cmData = mCpBody->data;
	[cmData release];

	mCpBody->data = NULL;
	
	if (!cpBodyIsStatic(mCpBody)) {
		cpSpaceRemoveBody([mSpace cpSpace], mCpBody);
	}
	
	cpBodyFree(mCpBody);
	mCpBody = NULL;
	
	[super dealloc];
}

@end
