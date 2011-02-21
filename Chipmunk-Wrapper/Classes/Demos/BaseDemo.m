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

- (BOOL)disableAccelerometer;
- (BOOL)disableWindowContainment;
- (BOOL)disableDefaultTouchHandler;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation BaseDemo

@synthesize delegate = mDelegate;

- (id) init {
	if (self = [super init]) {
		inverseGravity = NO;
		
		[self setupSpace];
		[self initializeChipmunkObjects];
		
		debugDraw = [[SPDebugDraw alloc] initWithManager:mSpace];
		[self addChild:debugDraw];
		
		
		mTouchBody = [[mSpace addBody] retain];
		[mTouchBody addToSpace];
		
		if (![self disableDefaultTouchHandler]) {
			[self addEventListener:@selector(force:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
		}
		
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
		
		backButton = [SPImage imageWithContentsOfFile:@"optionSelector.png"];
		[backButton setX:10];
		[backButton setY:480 - [backButton height] - 10];
		[backButton addEventListener:@selector(backToOptionSelector:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
		[self addChild:backButton];
		
		leftButton = [SPImage imageWithContentsOfFile:@"left_arrow_small.png"];
		[leftButton setX:50];
		[leftButton setY:480 - [leftButton height] - 10];
		[leftButton addEventListener:@selector(previous:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
		[self addChild:leftButton];

		
		rightButton = [SPImage imageWithContentsOfFile:@"right_arrow_small.png"];
		[rightButton setX:90];
		[rightButton setY:480 - [rightButton height] - 10];
		[rightButton addEventListener:@selector(next:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
		[self addChild:rightButton];
		
		
	}
	return self;
}

- (void)backToOptionSelector:(SPTouchEvent*)event {
	SPTouch *touch = [[event touchesWithTarget:backButton andPhase:SPTouchPhaseBegan] anyObject];
	if (touch) {
		[mDelegate back];
	}
}

- (void)previous:(SPTouchEvent*)event {
	SPTouch *touch = [[event touchesWithTarget:leftButton andPhase:SPTouchPhaseBegan] anyObject];
	if (touch) {
		[mDelegate previous];
	}
}

- (void)next:(SPTouchEvent*)event {
	SPTouch *touch = [[event touchesWithTarget:rightButton andPhase:SPTouchPhaseBegan] anyObject];
	if (touch) {
		[mDelegate next];
	}
}


- (void)setupSpace {
	// Setup the chipmunk space.
	mSpace = [[CMSpace alloc] init];
	[mSpace setSleepTimeThreshhold:5.0f];
	[mSpace setIterations:25];
	
	// When applicable add the window containment.
	if (![self disableWindowContainment]) {
		[mSpace addWindowContainmentWithWidth:320 height:480 elasticity:0.0 friction:1.0];
	}
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

- (BOOL)disableWindowContainment {
	return NO;
}

- (BOOL)disableDefaultTouchHandler {
	return NO;
}

- (void)startDemo {
	[self addEventListener:@selector(step:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}


- (void)stopDemo {
	[self removeEventListener:@selector(step:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	[mSpace setGravity:cpv(acceleration.x * 9.8 * 10, acceleration.y * 9.8 * 10 * (inverseGravity ? 1 : -1))];
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
		
		mTouchShape = [mSpace queryFirstByPoint:spPoint];
		if (mTouchShape) {
			mTouchPoint = [spPoint toCpVect];
			mTouchLast = mTouchPoint;
			[mTouchBody setPositionUsingPoint:spPoint];
			
			CMBody *body = [mTouchShape body];
			
			mTouchJoint = [mTouchBody addPivotJointConstraintWithBody:body anchor1:cpvzero anchor2:cpBodyWorld2Local([body cpBody], mTouchPoint)];
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
		[mTouchBody setPositionUsingVect:newPoint];
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
	[mDelegate release];
	[backButton release];
	[leftButton release];
	[rightButton release];
	
	[super dealloc];
}

@end
