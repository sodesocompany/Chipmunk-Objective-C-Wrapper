//
//  FollowPathDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "FollowPathDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface FollowPathDemo ()

- (void)initializeChipmunkObjects;
- (void)createFixedBlock:(cpVect)position width:(float)width height:(float)height;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation FollowPathDemo

- (void) initializeChipmunkObjects {
	mCmBody = [mSpace addBodyWithMass:1.0f moment:0];
	[mCmBody setPositionUsingVect:cpv(60, 60)];
	[mCmBody addToSpace];
	
	CMShape *cmShape = [mCmBody addCircleWithRadius:30.0f];
	[cmShape setElasticity:0.0];
	[cmShape setFriction:0.7];
	[cmShape addToSpace];
	
	mCmStaticBody = [mSpace addStaticBody];
	mCmConstraint = [mCmBody addPivotJointConstraintWithBody:mCmStaticBody anchor1:cpvzero anchor2:cpv(60,60)];
	
	// Run around 80% of the speed.
	[mCmConstraint setMaxBias:80.0];
	
	// Remember, force is normally infinite... so large number are required. 
	// Do too low and the shape will just drop.
	[mCmConstraint setMaxForce:1000];
	[mCmConstraint addToSpace];
	
	[self addEventListener:@selector(force:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
	
	// Add some objects into which the body can colide.
	[self createFixedBlock:cpv(150, 150) width:50 height:50];
	
}

- (BOOL) disableDefaultTouchHandler {
	return YES;
}

- (void)createFixedBlock:(cpVect)position width:(float)width height:(float)height {
	CMBody *squareBody = [mSpace addBodyWithMass:1 moment:0];
	[squareBody setPositionUsingVect:position];
	[squareBody addToSpace];
	
	CMShape *squareShape = [squareBody addRectangleWithWidth:width height:height];
	[squareShape setElasticity:0.5];
	[squareShape setFriction:0.5];
	[squareShape addToSpace];
	
	CMPivotJointConstraint *pivotJointConstraint1 = [squareBody addPivotJointConstraintWithBody:mCmStaticBody pivot:position];
	[pivotJointConstraint1 addToSpace];	
}

- (void)force:(SPTouchEvent*)event {
	SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] anyObject];
	if (touch) {
		SPPoint *spPoint = [touch locationInSpace:self];
		[mCmConstraint setAnchor2:[spPoint toCpVect]];
	}
}

@end
