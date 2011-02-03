//
//  BaseDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "BaseDemo.h"

// --- Static variables ----------------------------------------------------------------------------

static int frameCount = 0;
static double timeCount = 0;

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface BaseDemo ()

- (void)setupSpace;
- (void)displayFrameRate:(double)passedTime;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation BaseDemo

- (id) init {
	if (self = [super init]) {
		inverseGravity = NO;
		
		[self setupSpace];
		[self initializeChipmunkObjects];
		
		debugDraw = [[SPDebugDraw alloc] initWithManager:mSpace];
		[self addChild:debugDraw];
		
		
		mTouchBody = [[mSpace addBody] retain];
		[mTouchBody addToSpace];
		[self addEventListener:@selector(force:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
		
		if (![self disableAccelerometer]) {
			UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
			accelerometer.updateInterval = 1.0f/30.0f;
			accelerometer.delegate = self;
		}
		
		frameRateTextField = [SPTextField textFieldWithWidth:55 height:15 text:[NSString stringWithFormat:@"FPS: %.0f", 0]];
		frameRateTextField.hAlign = SPHAlignLeft;
		frameRateTextField.vAlign = SPVAlignBottom;
		frameRateTextField.color = 0xffffff;
		frameRateTextField.x = 5;
		frameRateTextField.y = 5;
		[self addChild:frameRateTextField];
	}
	return self;
}

- (void)setupSpace {
	mSpace = [[CMSpace alloc] init];
	[mSpace setSleepTimeThreshhold:5.0f];
	[mSpace setIterations:30];
	
	[mSpace addWindowContainmentWithWidth:320 height:480 elasticity:0.0 friction:1.0];
}

- (void)initializeChipmunkObjects {
	[NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void)showHideDebugDraw {
	[debugDraw setVisible:![debugDraw visible]];
}

- (BOOL)disableAccelerometer {
	return NO;
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

- (void)displayFrameRate:(double)passedTime {
	frameCount++;
	timeCount += passedTime;
	if (timeCount >= 1.0f) {
		frameRateTextField.text = [NSString stringWithFormat:@"FPS: %i", frameCount];
		frameCount = 0;
		timeCount -= 1.0f;
	}
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
	
	[mSpace step:1.0f / 15.0f];
	[mSpace updateShapes];
	
	[self displayFrameRate:event.passedTime];
}

- (void) dealloc {
	UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
	accelerometer.delegate = nil;
	
	[debugDraw release];
	[mTouchBody release];
	[mSpace release];
	
	[super dealloc];
}

@end
