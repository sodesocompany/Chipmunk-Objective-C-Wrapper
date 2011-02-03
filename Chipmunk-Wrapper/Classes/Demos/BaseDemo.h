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
}

/**
  * Init method.
  */
- (id) init;

/**
 * Method for initializing the Chipmunk bodies, shapes and constraints.
 */
- (void)initializeChipmunkObjects;

- (void)switchBetweenSparrowAndChipmunk;

- (void)startDemo;

- (void)stopDemo;


@end
