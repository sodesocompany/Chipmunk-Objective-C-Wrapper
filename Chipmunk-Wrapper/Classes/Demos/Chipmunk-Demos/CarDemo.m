//
//  CarDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "CarDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CarDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CarDemo

- (void) initializeChipmunkObjects {
	// Create chassis
	CMBody *chassis = [mSpace addBodyWithMass:2 moment:0.5];
	[chassis setPositionUsingVect:cpv(80, 410)];
	[chassis addToSpace];

	CMShape *shape = [chassis addPolyWithPoints:4 vertices:
					  cpv(-40,-15),
					  cpv(-40, 15),
					  cpv( 40, 15),
					  cpv( 40,-15)];

	[shape setElasticity:0.0];
	[shape setFriction:0.7];
	[shape setGroup:CAR_GROUP_TYPE];
	[shape addToSpace];
	
	// Create the first wheel
	CMBody *wheel1 = [mSpace addBodyWithMass:1 moment:0.5];
	[wheel1 setPositionUsingVect:cpv(50,460)];
	[wheel1 addToSpace];
	
	CMShape *wheel1Shape = [wheel1 addCircleWithRadius:15.0f];
	[wheel1Shape setElasticity:0.0];
	[wheel1Shape setFriction:0.7];
	[wheel1Shape setGroup:CAR_GROUP_TYPE];
	[wheel1Shape addToSpace];
	
	// Create the second wheel
	CMBody *wheel2 = [mSpace addBodyWithMass:1 moment:0.5];
	[wheel2 setPositionUsingVect:cpv(110,460)];
	[wheel2 addToSpace];
	
	CMShape *wheel2Shape = [wheel2 addCircleWithRadius:15.0f];
	[wheel2Shape setElasticity:0.0];
	[wheel2Shape setFriction:0.7];
	[wheel2Shape setGroup:CAR_GROUP_TYPE];
	[wheel2Shape addToSpace];
	
	CMGrooveJointConstraint *grooveJointConstraint1 = [chassis addGrooveJointConstraintWithBody:wheel1 grooveA:cpv(-30, -10) grooveB:cpv(-30, 40) anchor1:cpvzero];
	[grooveJointConstraint1 addToSpace];
	CMGrooveJointConstraint *grooveJointConstraint2 = [chassis addGrooveJointConstraintWithBody:wheel2 grooveA:cpv( 30, -10) grooveB:cpv( 30, 40) anchor1:cpvzero];
	[grooveJointConstraint2 addToSpace];
	
	CMDampedSpringConstraint *dampedSpringConstraint1 = [chassis addDampedSpringConstraintWithBody:wheel1 anchor1:cpv(-30,0) anchor2:cpvzero restLength:50.0f stiffness:20.0f damping:1.5f];
	[dampedSpringConstraint1 addToSpace];
	CMDampedSpringConstraint *dampedSpringConstraint2 = [chassis addDampedSpringConstraintWithBody:wheel2 anchor1:cpv( 30,0) anchor2:cpvzero restLength:50.0f stiffness:20.0f damping:1.5f];
	[dampedSpringConstraint2 addToSpace];
	
}

@end
