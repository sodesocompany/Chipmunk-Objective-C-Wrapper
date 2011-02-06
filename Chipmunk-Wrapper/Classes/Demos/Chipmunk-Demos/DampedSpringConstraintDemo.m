//
//  DampedSpringConstraintDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "DampedSpringConstraintDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface DampedSpringConstraintDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation DampedSpringConstraintDemo

- (void) initializeChipmunkObjects {
	// Create the first body with its shape.
	CMBody *body1 = [mSpace addBodyWithMass:100 moment:INFINITY];
	[body1 setPositionUsingVect:cpv(160, 200)];
	[body1 addToSpace];
	
	CMRectShape *shape1 = [body1 addRectangleWithWidth:64 height:64];
	[shape1 setElasticity:0.5];
	[shape1 setFriction:0.5];
	[shape1 addToSpace];
	
		// Create the second body with its shape.
	CMBody *body2 = [mSpace addBodyWithMass:100 moment:INFINITY];
	[body2 setPositionUsingVect:cpv(180, 400)];
	[body2 addToSpace];
	
	CMRectShape *shape2 = [body2 addRectangleWithWidth:64 height:64];
	[shape2 setElasticity:0.5];
	[shape2 setFriction:0.5];
	[shape2 addToSpace];
	
	CMBody * staticBody = [mSpace addStaticBody];

	CMConstraint *pivotJointConstraint1 = [body1 addPivotJointConstraintWithBody:staticBody pivot:cpv(160, 200)];
	[pivotJointConstraint1 addToSpace];
	
	// Create the damped spring constraint between them.
	CMDampedSpringConstraint *constraint = [body1 addDampedSpringConstraintWithBody:body2 anchor1:cpv(0,0) anchor2:cpv(0,0) restLength:20.0f stiffness:200.0f damping:0.2f];
	[constraint addToSpace];
}

@end
