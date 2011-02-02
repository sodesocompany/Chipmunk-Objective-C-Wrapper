//
//  BaseDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "BaseDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface BaseDemo ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation BaseDemo

- (id) init {
	if (self = [super init]) {
		inverseGravity = NO;
		
		mSpace = [[CMSpace alloc] init];
		[mSpace setSleepTimeThreshhold:5.0f];
		[mSpace setIterations:30];
		
		
		[mSpace addWindowContainmentWithWidth:320 height:480 elasticity:0.0 friction:1.0];
		[self initializeChipmunkObjects];
		
		debugDraw = [[SPDebugDraw alloc] initWithManager:mSpace];
		[self addChild:debugDraw];
		
		
		mTouchBody = [[mSpace addBody] retain];
		[mTouchBody addToSpace];
		[self addEventListener:@selector(force:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
		
		UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
		accelerometer.updateInterval = 1.0f/30.0f;
		accelerometer.delegate = self;
	}
	return self;
}

- (void)switchBetweenSparrowAndChipmunk {
	[debugDraw setVisible:![debugDraw visible]];
}

- (void)initializeChipmunkObjects {
	[NSException raise:NSInternalInconsistencyException 
			format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];

}

- (void)startDemo {
	[self addEventListener:@selector(step:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}


- (void)stopDemo {
	[self removeEventListener:@selector(step:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	[mSpace setGravity:cpv(acceleration.x*500, acceleration.y*500 * (inverseGravity ? 1 : -1))];
}

- (void)force:(SPTouchEvent*)event {
	SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
	if (touch) {
		SPPoint *spPoint = [touch locationInSpace:self];
		
		mTouchShape = [mSpace findShapeAtPoint:spPoint];
		if (mTouchShape) {
			mTouchPoint = [spPoint toCpVect];
			mTouchLast = mTouchPoint;
			[mTouchBody setPosition:mTouchPoint];
			
			CMBody *body = [mTouchShape getBody];
			
			mTouchJoint = [mTouchBody addPivotJointConstraintWithBody:body anchor1:cpvzero anchor2:cpBodyWorld2Local([body construct], mTouchPoint)];
			[mTouchJoint setMaxForce:50000.00f];
			[mTouchJoint setBiasCoef:0.15f];
			[mTouchJoint addToSpace];
		}
	}
	
	touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] anyObject];
	if (touch && mTouchJoint != nil) {
		SPPoint *spPoint = [touch locationInSpace:self];
		cpVect point = [spPoint toCpVect];
		mTouchPoint = point;
	}
	
	touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] anyObject];
	if (touch && mTouchJoint != nil) {
		[[mTouchJoint firstBody] removeConstraint:mTouchJoint];
		mTouchJoint = nil;
	}
}

- (void)step:(SPEnterFrameEvent *)event {
	if (mTouchJoint != nil) {
		cpVect newPoint = cpvlerp(mTouchLast, mTouchPoint, 0.25f);
		[mTouchBody setPosition:newPoint];
		[mTouchBody setVelocity:cpvmult(cpvsub(newPoint, mTouchLast), 30.0f)];
	
		mTouchLast = newPoint;
	}
	
	[mSpace step:CHIPMUNK_FRAMERATE];
	[mSpace updateShapes];
}

- (void) dealloc {
	[debugDraw release];
	[mTouchBody release];
	[mSpace release];
	 
	[super dealloc];
}

@end
