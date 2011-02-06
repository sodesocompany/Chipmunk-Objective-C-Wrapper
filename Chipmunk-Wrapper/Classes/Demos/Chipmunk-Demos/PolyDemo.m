//
//  PolyDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "PolyDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface PolyDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation PolyDemo

- (void) initializeChipmunkObjects {
	
	// Create the first body with its shape.
		
	[self addEventListener:@selector(addPoly:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

/**
 * Adds a new polygon at the touched location.
 */
- (void)addPoly:(SPTouchEvent*)event {
	SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
	if (touch && mTouchShape == nil) {
		SPPoint *spPoint = [touch locationInSpace:self];
		
		CMBody *body1 = [mSpace addBodyWithMass:2.0f moment:1];
		[body1 setPositionUsingVect:[spPoint toCpVect]];
		[body1 addToSpace];
		
		float offset = 10.0f;
		
		// Left Top 
		CMShape *shape = [body1 addPolyWithPoints:4 offset:cpv(-offset, offset) vertices:
			cpv(-2.8f, 3.1f), cpv(8.8f, -9.1f), cpv(-3.0f, -8.9f), cpv(-2.9f, 3.1f)];
		[shape setElasticity:0.0];
		[shape setFriction:0.7];
		[shape addToSpace];
		
		// Right Top
		shape = [body1 addPolyWithPoints:4 offset:cpv(offset, offset) vertices:
			cpv(-8.9f, -8.8f), cpv(3.1f, 3.1f), cpv(3.1f, -8.9f), cpv(-9.0f, -9.2f)];
		[shape setElasticity:0.0];
		[shape setFriction:0.7];
		[shape addToSpace];
		
		// Left Bottom
		shape = [body1 addPolyWithPoints:4 offset:cpv(-offset, -offset) vertices:
			cpv(9.1f, 9.1f), cpv(-3.0f, -3.2f), cpv(-2.9f, 9.1f), cpv(9.0f, 9.2f)];
		[shape setElasticity:0.0];
		[shape setFriction:0.7];
		[shape addToSpace];
		
		// Right Bottom
		shape = [body1 addPolyWithPoints:4 offset:cpv(offset, -offset) vertices:
			cpv(-8.9f, 9.1f), cpv(3.1f, 9.2f), cpv(3.1f, -3.1f), cpv(-9.0f, 8.9f)];
		[shape setElasticity:0.0];
		[shape setFriction:0.7];
		[shape addToSpace];
	}
}

@end
