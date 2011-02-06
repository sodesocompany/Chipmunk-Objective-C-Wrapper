//
//  NewtonsCradleDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "NewtonsCradleDemo.h"

// --- Static variables ----------------------------------------------------------------------------

const float numberOfBalls = 5;
const float blockTop = 100.0f;
const float ballTop = 180.0f;

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface NewtonsCradleDemo ()

- (void)initializeChipmunkObjects;
- (void)createBall:(int)index;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation NewtonsCradleDemo

- (void) initializeChipmunkObjects {
	// Create a static body to which all fixed bodies will be attached
	// so they are fixed in space.
	staticBody = [mSpace addStaticBody];
	
	for (int index = 1; index <= numberOfBalls; index++) {
		[self createBall:index];
	}
}

- (BOOL)disableAccelerometer {
	return YES;
}

- (void)createBall:(int)index {
	float x = 40.0f + (index * 40);

	// Create the block on which the ball will be hanging. 
	CMBody *blockBody = [mSpace addBodyWithMass:1.0f moment:0];
	[blockBody setPositionUsingVect:cpv(x, blockTop)];
	[blockBody addToSpace];
	
	CMRectShape *blockShape = [blockBody addRectangleWithWidth:20.0f height:20.0f];
	[blockShape addToSpace];
	
	// Make sure the block stays fixed in a single position.
	CMPivotJointConstraint *pjc = [blockBody addPivotJointConstraintWithBody:staticBody pivot:cpv(x, blockTop)];
	[pjc addToSpace];
	
	// Create the ball
	CMBody *ballBody = [mSpace addBodyWithMass:PI * 20 * 2 moment:0.0f];
	[ballBody setPositionUsingVect:cpv(x, ballTop)];
	[ballBody addToSpace];
	
	CMCircleShape *ballShape = [ballBody addCircleWithRadius:20.0f];
	[ballShape setElasticity:0.999];
	[ballShape setFriction:0.0];
	[ballShape addToSpace];

	// Attach the ball to the block.
	CMPinJointConstraint *pjc1 = [ballBody addPinJointConstraintWithBody:blockBody anchor1:cpvzero anchor2:cpvzero];
	[pjc1 addToSpace];
}

@end
