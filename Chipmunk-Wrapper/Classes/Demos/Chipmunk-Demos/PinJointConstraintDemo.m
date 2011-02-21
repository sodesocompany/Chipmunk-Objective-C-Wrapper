//
//  PinJointConstraintDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "PinJointConstraintDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface PinJointConstraintDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation PinJointConstraintDemo

- (void) initializeChipmunkObjects {
	cpVect pos1 = cpv(80, 140);
	cpVect pos2 = cpv(220, 140);
	
	CMBody *body1 = [mSpace addBodyWithMass:1.0f moment:0];
	[body1 setPositionUsingVect:pos1];
	[body1 addToSpace];
	
	CMShape *shape1 = [body1 addCircleWithRadius:35.0f];
	[shape1 setElasticity:0.0];
	[shape1 setFriction:0.7];
	[shape1 addToSpace];
	
	CMBody *body2 = [mSpace addBodyWithMass:1.0f moment:1];
	[body2 setPositionUsingVect:pos2];
	[body2 addToSpace];
		
	CMShape *shape2 = [body2 addCircleWithRadius:35.0f];
	[shape2 setElasticity:0.0];
	[shape2 setFriction:0.7];
	[shape2 addToSpace];
	
	// Create the pin joint constraint between them.
	CMConstraint *pinJointConstraint = [body1 addPinJointConstraintWithBody:body2 anchor1:cpv(15,0) anchor2:cpv(-15,0)];
	[pinJointConstraint addToSpace];
}

@end
