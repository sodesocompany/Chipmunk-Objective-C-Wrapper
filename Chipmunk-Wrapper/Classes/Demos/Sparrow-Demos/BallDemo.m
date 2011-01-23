//
//  DampedRotaryConstraintDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "BallDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface BallDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation BallDemo

- (void) initializeChipmunkObjects {
	ball = [[Ball alloc] init];
	[ball setX:80];
	[ball setY:320];
	[self addChild:ball];
	
	// Create the first body with its shape.
	CMBody *body = [mSpace addBodyWithMass:50 moment:INFINITY];
	[body setPosition:cpv(80, 140)];
	[body addToSpace];
	[body setData:ball];
	
	CMShape *shape = [body addCircleWithRadius:70.0f];
	[shape setElasticity:0.8];
	[shape setFriction:0.8];
	[shape addToSpace];

	
}

- (void) dealloc {
	[super dealloc];

	[ball release];
}


@end
