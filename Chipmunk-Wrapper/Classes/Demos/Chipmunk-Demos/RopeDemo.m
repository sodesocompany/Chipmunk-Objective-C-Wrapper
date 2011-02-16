//
//  RopeDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "RopeDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface RopeDemo ()

- (void)initializeChipmunkObjects;
- (void)createSquare;
- (void)createBall;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation RopeDemo

- (void) initializeChipmunkObjects {
	int numberOfBodies = 30;

	// Create a static body to which all fixed bodies will be attached
	// so they are fixed in space.
	staticBody = [mSpace addStaticBody];
	
	// Create the first body which is fixed in space to which the rope will
	// be attached.
	CMBody *previousBody = [mSpace addBodyWithMass:1.0f moment:0];
	[previousBody setPositionUsingVect:cpv(320.0f / 2.0f, 20.0f)];
	[previousBody addToSpace];
	
	CMCircleShape *circleShape = [previousBody addCircleWithRadius:5.0f];
	[circleShape addToSpace];
	
	// Attach the first body of the rope to the static. 
	CMPivotJointConstraint *pjc1 = [previousBody addPivotJointConstraintWithBody:staticBody pivot:cpv(320.0f / 2.0f, 20.0f)];
	[pjc1 addToSpace];
	
	// Create all the parts of the rope.
	for (int index = 1; index < numberOfBodies; index++) {
		CMBody *newBody = [mSpace addBodyWithMass:1.0f moment:0];
		[newBody setPositionUsingVect:cpv(320.0f / 2.0f, 20.0f + (index * 10.0f))];
		[newBody addToSpace];

		CMCircleShape *circleShape = [newBody addCircleWithRadius:5.0f];
		[circleShape addToSpace];
		
		if (previousBody != nil) {
			CMPinJointConstraint *pjc3 = [newBody addPinJointConstraintWithBody:previousBody anchor1:cpvzero anchor2:cpvzero];
			[pjc3 setDistance:10.0f];
			[pjc3 addToSpace];
		}
		
		previousBody = newBody;
	}
		
	[self createSquare];
	[self createBall];
	
}

- (BOOL)disableAccelerometer {
	return YES;
}

/**
 * Create a square on a fixed point on which the rope can collide by holding the device
 * in an angle.
 */
- (void)createSquare {
	CMBody *squareBody = [mSpace addBodyWithMass:100 moment:0.5];
	[squareBody setPositionUsingVect:cpv(230, 80)];
	[squareBody addToSpace];
	
	CMShape *squareShape = [squareBody addRectangleWithWidth:64 height:64];
	[squareShape setElasticity:0.5];
	[squareShape setFriction:0.5];
	[squareShape addToSpace];
	
	CMPivotJointConstraint *pivotJointConstraint1 = [squareBody addPivotJointConstraintWithBody:staticBody pivot:cpv(230, 80)];
	[pivotJointConstraint1 addToSpace];	
}

/**
 * Create a loose ball wich can be dragged in the direction of the rope.
 */
- (void)createBall {
	CMBody *ballBody = [mSpace addBodyWithMass:2.0f moment:1];
	[ballBody setPositionUsingVect:cpv(320.0f / 2.0f, 480-30)];
	[ballBody addToSpace];	
	
	CMShape *ballShape = [ballBody addCircleWithRadius:30.0f];
	[ballShape setElasticity:0.0];
	[ballShape setFriction:0.7];
	[ballShape addToSpace];
}

@end
