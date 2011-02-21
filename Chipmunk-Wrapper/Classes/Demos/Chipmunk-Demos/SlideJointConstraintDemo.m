//
//  DampedRotaryConstraintDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "SlideJointConstraintDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface SlideJointConstraintDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation SlideJointConstraintDemo

- (void) initializeChipmunkObjects {
	cpVect pos1 = cpv(320 * 0.25, 480 * 0.25);
	cpVect pos2 = cpv(320 * 0.75, 480 * 0.75);
	
	CMBody *body1 = [mSpace addBodyWithMass:2.0f moment:1];
	[body1 setPositionUsingVect:pos1];
	[body1 addToSpace];
	
	CMShape *shape1 = [body1 addCircleWithRadius:35.0];
	[shape1 setElasticity:0.0];
	[shape1 setFriction:0.7];
	[shape1 addToSpace];
	
	CMBody *body2 = [mSpace addBodyWithMass:2.0f moment:1];
	[body2 setPositionUsingVect:pos2];
	[body2 addToSpace];	
	
	CMShape *shape2 = [body2 addCircleWithRadius:35.0];
	[shape2 setElasticity:0.0];
	[shape2 setFriction:0.7];
	[shape2 addToSpace];
	
	// Create the slide joint constraint between them.
	CMConstraint *slideJointConstraint = [body1 addSlideJointConstraintWithBody:body2 anchor1:cpv(35,0) anchor2:cpv(-35,0) min:50.0f max:80.0f];
	[slideJointConstraint addToSpace];
	
}

@end
