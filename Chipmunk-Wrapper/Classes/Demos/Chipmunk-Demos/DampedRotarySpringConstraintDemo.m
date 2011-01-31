//
//  DampedRotaryConstraintDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "DampedRotarySpringConstraintDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface DampedRotarySpringConstraintDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation DampedRotarySpringConstraintDemo

- (void) initializeChipmunkObjects {
	cpVect pos1 = cpv(80, 140);
	cpVect pos2 = cpv(220, 140);
	
	// Create the first body with its shape.
	CMBody *body1 = [mSpace addBodyWithMass:2.0f moment:1];
	[body1 setPosition:pos1];
	[body1 addToSpace];
	
	CMShape *shape1 = [body1 addSegmentFrom:cpv(30,30) to:cpv(-30, -30) radius:5.0f];
	[shape1 setElasticity:0.0];
	[shape1 setFriction:0.7];
	[shape1 addToSpace];
	
	CMBody *body2 = [mSpace addBodyWithMass:2.0f moment:1];
	[body2 setPosition:pos2];
	[body2 addToSpace];	
	
	CMShape *shape2 = [body2 addSegmentFrom:cpv(30,30) to:cpv(-30, -30) radius:5.0f];
	[shape2 setElasticity:0.0];
	[shape2 setFriction:0.7];
	[shape2 addToSpace];
	
	CMBody * staticBody = [mSpace addStaticBody];
		//[staticBody addToSpace];
	
	CMConstraint *pivotJointConstraint1 = [body1 addPivotJointConstraintWithBody:staticBody pivot:pos1];
	[pivotJointConstraint1 addToSpace];
	
	CMConstraint *pivotJointConstraint2 = [body2 addPivotJointConstraintWithBody:staticBody pivot:pos2];
	[pivotJointConstraint2 addToSpace];
		
	// Create the damped rotary constraint between them.
	CMConstraint *dampedRotaryConstraint = [body1 addDampedRotaryConstraintWithBody:body2 restAngle:0.0f stiffness:3000.0f damping:100.0f];
	[dampedRotaryConstraint addToSpace];
	
}

@end
