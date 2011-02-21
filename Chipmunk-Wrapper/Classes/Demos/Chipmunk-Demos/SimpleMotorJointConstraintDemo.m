//
//  SimpleMotorJointConstraintDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "SimpleMotorJointConstraintDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface SimpleMotorJointConstraintDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation SimpleMotorJointConstraintDemo

- (void) initializeChipmunkObjects {
	cpVect position1 = cpv(320 / 2.0f, 480 * 0.25);
	cpVect position2 = cpv(320 / 2.0f, 480 * 0.75);
	
	// Create the first body with its shape.
	CMBody *body1 = [mSpace addBodyWithMass:1 moment:0.5];
	[body1 setPositionUsingVect:position1];
	[body1 addToSpace];
	
	CMShape *shape1 = [body1 addRectangleWithWidth:100 height:100];
	[shape1 setElasticity:0.5];
	[shape1 setFriction:0.5];
	[shape1 addToSpace];
	
	// Create the second body with its shape.
	CMBody *body2 = [mSpace addBodyWithMass:1 moment:0.5];
	[body2 setPositionUsingVect:position2];
	[body2 addToSpace];
	
	CMShape *shape2 = [body2 addRectangleWithWidth:100 height:100];
	[shape2 setElasticity:0.5];
	[shape2 setFriction:0.5];
	[shape2 addToSpace];
	
	CMBody *staticBody = [mSpace addStaticBody];

	// Add some pivot joints to make sure the bodies stay in one place.
	CMPivotJointConstraint *pivotJointConstraint1 = [body1 addPivotJointConstraintWithBody:staticBody pivot:position1];
	[pivotJointConstraint1 addToSpace];
	CMPivotJointConstraint *pivotJointConstraint2 = [body2 addPivotJointConstraintWithBody:staticBody pivot:position2];
	[pivotJointConstraint2 addToSpace];
	
	// Create the simple motor constraint between them.
	CMSimpleMotorConstraint *simpleMotorConstraint = [body1 addSimpleMotorConstraintWithBody:body2 rate:2];
	[simpleMotorConstraint addToSpace];
}

@end
