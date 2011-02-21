//
//  BaseDemo.h
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "SPDebugDraw.h"

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

@interface BaseDemo : SPSprite <UIAccelerometerDelegate> {

@protected
	SPDebugDraw *debugDraw;

	cpVect mTouchPoint;
	cpVect mTouchLast;

	CMSpace *mSpace;
	CMBody *mTouchBody;
	CMShape *mTouchShape;
	CMConstraint *mTouchJoint;

	BOOL inverseGravity;
	
	SPTextField *frameRateTextField;
	SPImage *backButton;
	SPImage *rightButton;
	SPImage *leftButton;
	
	id mDelegate;
}

@property (nonatomic, retain) id delegate;

/**
  * Init method.
  */
- (id) init;

/**
 * Method for initializing the Chipmunk bodies, shapes and constraints.
 */
- (void)initializeChipmunkObjects;

- (void)showHideDebugDraw;

- (void)startDemo;
- (void)stopDemo;

- (void)step:(SPEnterFrameEvent *)event;

@end

@protocol DemoProtocol

- (void)back;
- (void)previous;
- (void)next;

@end
