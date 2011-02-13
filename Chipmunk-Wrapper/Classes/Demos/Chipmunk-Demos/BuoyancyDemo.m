//
//  BuoyancyDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "BuoyancyDemo.h"

// --- Static variables ----------------------------------------------------------------------------

#define WIDTH 200
#define HEIGHT 40

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface BuoyancyDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation BuoyancyDemo

- (BOOL)disableAccelerometer {
	return YES;
}

- (void) initializeChipmunkObjects {
	[mSpace setGravity:cpv(0, -100)];

	CMBody *body = [mSpace addBodyWithMass:1.0 moment:0];
	[body setVelocityFunction:self selector:@selector(velocityFunction:gravity:damping:dt:)];
	[body setPositionUsingVect:cpv(160, 240)];
	[body setAngularVelocity:0.0];
	[body addToSpace];
		
	CMShape *shape = [body addRectangleWithWidth:64 height:64];
	[shape setElasticity:0.0];
	[shape setFriction:0.7];
	[shape addToSpace];
}

- (void)velocityFunction:(CMBody*)cmBody gravity:(cpVect)gravity damping:(float)damping dt:(float)dt {
	cpBody *body = [cmBody cpBody];

	[cmBody resetForces];
	
	int numx = 20;
	int numy = 4;
	
	float stepx = (float)WIDTH/(float)numx;
	float stepy = (float)HEIGHT/(float)numy;
	
	for(int x=0; x<numx; x++){
		for(int y=0; y<numy; y++){
			cpVect p_sample = cpv((x + 0.5)*stepx - WIDTH/2, (y + 0.5)*stepy - HEIGHT/2);
			cpVect p = cpBodyLocal2World(body, p_sample);
			cpVect r = cpvsub(p, body->p);
			
			if(p.y < 200){
				cpVect v = cpvadd(body->v, cpvmult(cpvperp(r), body->w));
				cpVect f_damp = cpvmult(v, -0.0003*cpvlength(v));
				cpVect f = cpvadd(cpv(0, 2.0), f_damp);
				
				[cmBody applyForce:f offset:r];
			}
		}
	}

	[cmBody updateVelocity:gravity damping:damping dt:dt];
}

@end
