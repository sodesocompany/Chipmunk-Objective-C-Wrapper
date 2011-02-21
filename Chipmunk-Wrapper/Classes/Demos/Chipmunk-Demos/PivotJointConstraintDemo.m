//
//  PivotJointConstraintDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "PivotJointConstraintDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface PivotJointConstraintDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation PivotJointConstraintDemo

- (void) initializeChipmunkObjects {
	cpVect pos1 = cpv(80, 140);
	cpVect pos2 = cpv(220, 140);
	
	// Create the first body with its shape.
	CMBody *body1 = [mSpace addBodyWithMass:2.0f moment:1];
	[body1 setPositionUsingVect:pos1];
	[body1 addToSpace];
	
	CMShape *shape1 = [body1 addCircleWithRadius:35.0f];
	[shape1 setElasticity:0.0];
	[shape1 setFriction:0.7];
	[shape1 addToSpace];
	
	CMBody *body2 = [mSpace addBodyWithMass:2.0f moment:1];
	[body2 setPositionUsingVect:pos2];
	[body2 addToSpace];	
	
	CMShape *shape2 = [body2 addCircleWithRadius:35.0f];
	[shape2 setElasticity:0.0];
	[shape2 setFriction:0.7];
	[shape2 addToSpace];
	
	CMConstraint *pivotJointConstraint = [body1 addPivotJointConstraintWithBody:body2 pivot:cpv(140,60)];
	[pivotJointConstraint addToSpace];
	
}

@end
