//
//  SimpleCollisionDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "SimpleCollisionDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface SimpleCollisionDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation SimpleCollisionDemo

- (void) initializeChipmunkObjects {
	cpVect pos1 = cpv(80, 140);
	cpVect pos2 = cpv(160, 140);
	cpVect pos3 = cpv(240, 140);

	// Add a default collision handler, this handler handles all
	// collisions between all bodies / shapes in the space.
	[mSpace addDefaultCollisionHandler:self begin:@selector(defaultBegin:space:) preSolve:@selector(defaultPreSolve:space:) postSolve:@selector(defaultPostSolve:space:) separate:@selector(defaultSeparate:space:) ignoreContainmentCollisions:YES];
	
	CMBody *body1 = [mSpace addBodyWithMass:2.0f moment:1];
	[body1 setPosition:pos1];
	[body1 addToSpace];
	
	CMShape *shape1 = [body1 addCircleWithRadius:30.0f];
	[shape1 setElasticity:0.0];
	[shape1 setFriction:0.7];
	[shape1 setCollisionType:1];
	[shape1 addToSpace];
	
	CMBody *body2 = [mSpace addBodyWithMass:2.0f moment:1];
	[body2 setPosition:pos2];
	[body2 addToSpace];	
	
	CMShape *shape2 = [body2 addCircleWithRadius:30.0f];
	[shape2 setElasticity:0.0];
	[shape2 setFriction:0.7];
	[shape2 setCollisionType:2];
	[shape2 addToSpace];

	CMBody *body3 = [mSpace addBodyWithMass:2.0f moment:1];
	[body3 setPosition:pos3];
	[body3 addToSpace];	
	
	CMShape *shape3 = [body3 addRectWithWidth:40.0f height:40.0f];
	[shape3 setElasticity:0.0];
	[shape3 setFriction:0.7];
	[shape3 setCollisionType:3];
	[shape3 addToSpace];
	
}

- (BOOL) defaultBegin:(CMArbiter*)arbiter space:(CMSpace*)space {
	NSLog(@"Collision: begin (between %d and %d)", [[arbiter shapeA] collisionType], [[arbiter shapeB] collisionType]);
	[arbiter setElasticity:0.0f];
	[arbiter setFriction:0.0f];
	return YES;
}

- (BOOL) defaultPreSolve:(CMArbiter*)arbiter space:(CMSpace*)space {
	NSLog(@"Collision: preSolve (between %d and %d)", [[arbiter shapeA] collisionType], [[arbiter shapeB] collisionType]);
	return YES;
}

- (BOOL) defaultPostSolve:(CMArbiter*)arbiter space:(CMSpace*)space {
	NSLog(@"Collision: postSolve (between %d and %d)", [[arbiter shapeA] collisionType], [[arbiter shapeB] collisionType]);
	return YES;
}

- (BOOL) defaultSeparate:(CMArbiter*)arbiter space:(CMSpace*)space {
	NSLog(@"Collision: separate (between %d and %d)", [[arbiter shapeA] collisionType], [[arbiter shapeB] collisionType]);
	return YES;
}



@end
