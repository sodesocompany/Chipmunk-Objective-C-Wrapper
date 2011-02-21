//
//  GearJointConstraintDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "GearJointConstraintDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface GearJointConstraintDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation GearJointConstraintDemo

- (void) initializeChipmunkObjects {
	cpVect pos1 = cpv(320 / 2, 480 * 0.25);
	cpVect pos2 = cpv(320 / 2, 480 * 0.75);
	
	// Create the first body with its shape.
	CMBody *body1 = [mSpace addBodyWithMass:2.0f moment:1];
	[body1 setPositionUsingVect:pos1];
	[body1 addToSpace];
	
	CMShape *shape1 = [body1 addSegmentFrom:cpv(30,30) to:cpv(-30, -30) radius:10.0f];
	[shape1 setElasticity:0.0];
	[shape1 setFriction:0.7];
	[shape1 addToSpace];
	
	CMBody *body2 = [mSpace addBodyWithMass:2.0f moment:1];
	[body2 setPositionUsingVect:pos2];
	[body2 addToSpace];	
	
	CMShape *shape2 = [body2 addSegmentFrom:cpv(30,30) to:cpv(-30, -30) radius:10.0f];
	[shape2 setElasticity:0.0];
	[shape2 setFriction:0.7];
	[shape2 addToSpace];
	
	CMBody * staticBody = [mSpace addStaticBody];

	CMConstraint *pivotJointConstraint1 = [body1 addPivotJointConstraintWithBody:staticBody pivot:pos1];
	[pivotJointConstraint1 addToSpace];
	
	CMConstraint *pivotJointConstraint2 = [body2 addPivotJointConstraintWithBody:staticBody pivot:pos2];
	[pivotJointConstraint2 addToSpace];
		
	// Create the gear joint constraint between them.
	CMConstraint *gearJointConstraint = [body1 addGearJointConstraintWithBody:body2 phase:0.0f ratio:2];
	[gearJointConstraint addToSpace];
}

@end
