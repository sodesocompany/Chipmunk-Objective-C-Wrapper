//
//  BuoyancyDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "PlanetDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface PlanetDemo ()

- (void)initializeChipmunkObjects;
- (void)addPlanet:(cpVect)position;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation PlanetDemo

- (BOOL)disableAccelerometer {
	return YES;
}

- (BOOL)disableWindowContainment {
	return YES;
}

- (void) initializeChipmunkObjects {
	[mSpace setGravity:cpv(0, 0)];

	[self addPlanet:planet1_position];
	[self addPlanet:planet2_position];
	
	CMBody *block = [mSpace addBodyWithMass:1.0 moment:0];
	[block setVelocityFunction:self selector:@selector(velocityFunction:gravity:damping:dt:)];
	[block setPositionUsingVect:cpv(20, 20)];
	[block setVelocity:cpv(-20, 110)];
	[block addToSpace];
		
	CMShape *blockShape = [block addRectangleWithWidth:20 height:20];
	[blockShape setElasticity:0.0];
	[blockShape setFriction:0.7];
	[blockShape addToSpace];
}

- (void)addPlanet:(cpVect)position {
	CMBody *planet = [mSpace addBodyWithMass:INFINITY moment:INFINITY];
	[planet setPositionUsingVect:position];
	[planet setAngularVelocity:0.2f];
	[planet addToSpace];
	
	CMShape *planetShape = [planet addCircleWithRadius:30.0f];
	[planetShape setElasticity:1.0f];
	[planetShape setFriction:1.0f];
	[planetShape addToSpace];
}

- (void)velocityFunction:(CMBody*)cmBody gravity:(cpVect)gravity damping:(float)damping dt:(float)dt {
	// Do not reset the body forces.
	
	cpVect distToP1 = cpvsub([cmBody position], planet1_position);
	cpVect gravityPullToPlanet1 = cpvmult(distToP1, -30000.0f/cpvdot(distToP1, distToP1));
		
	cpVect distToP2 = cpvsub([cmBody position], planet2_position);
	cpVect gravityPullToPlanet2 = cpvmult(distToP2, -30000.0f/cpvdot(distToP2, distToP2));
	
	cpVect gravityDirection = cpvadd(gravityPullToPlanet1, gravityPullToPlanet2);
		
	[cmBody updateVelocity:gravityDirection damping:damping dt:dt];
}

@end
