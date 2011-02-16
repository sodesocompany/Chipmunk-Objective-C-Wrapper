//
//  LayerCollisionDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "LayerCollisionDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface LayerCollisionDemo ()

- (void)initializeChipmunkObjects;
- (void)createCircleBody;
- (void)createRectangleBody;
- (void)createSquareBody;
@end

// --- Class implementation ------------------------------------------------------------------------

@implementation LayerCollisionDemo

- (void) initializeChipmunkObjects {
	// Add a default collision handler, this handler handles all
	// collisions between all bodies / shapes in the space.
	[mSpace addDefaultCollisionHandler:self begin:@selector(defaultBegin:space:) preSolve:@selector(defaultPreSolve:space:) postSolve:@selector(defaultPostSolve:space:) separate:@selector(defaultSeparate:space:) ignoreContainmentCollisions:YES];
	
	
	// General rules for collision:
	// Circle can hit rectangle.
	// Square can hit rectangle.
	// Square cannot hit circle.
	[self createCircleBody];
	[self createRectangleBody];
	[self createSquareBody];
}

- (void)createCircleBody {
	CMBody *circleBody = [mSpace addBodyWithMass:2.0f moment:1];
	[circleBody setPositionUsingVect:cpv(80, 140)];
	[circleBody addToSpace];
	
	CMShape *shape = [circleBody addCircleWithRadius:30.0f];
	[shape setElasticity:0.0];
	[shape setFriction:0.7];
	[shape setCollisionType:CIRCLE_COLLISION_TYPE];
	[shape setLayer:10];
	[shape addToSpace];
}

- (void)createRectangleBody {
	CMBody *rectangleBody = [mSpace addBodyWithMass:2.0f moment:1];
	[rectangleBody setPositionUsingVect:cpv(160, 140)];
	[rectangleBody addToSpace];	
	
	CMShape *shape = [rectangleBody addRectangleWithWidth:60.0f height:30.0f];
	[shape setElasticity:0.0];
	[shape setFriction:0.7];
	[shape setCollisionType:RECTANGLE_COLLISION_TYPE];
	[shape setLayer:11];
	[shape addToSpace];
}

- (void)createSquareBody {
	CMBody *squareBody = [mSpace addBodyWithMass:2.0f moment:1];
	[squareBody setPositionUsingVect:cpv(240, 140)];
	[squareBody addToSpace];	
	
	CMShape *shape = [squareBody addRectangleWithWidth:30.0f height:30.0f];
	[shape setElasticity:0.0];
	[shape setFriction:0.7];
	[shape setCollisionType:SQUARE_COLLISION_TYPE];
	[shape setLayer:1];
	[shape addToSpace];
}

- (BOOL) defaultBegin:(CMArbiter*)arbiter space:(CMSpace*)space {
	NSLog(@"Collision: begin (between %@ and %@)", [[arbiter shapeA] collisionType], [[arbiter shapeB] collisionType]);
	[arbiter setElasticity:0.0f];
	[arbiter setFriction:0.0f];

	return YES;
}

- (BOOL) defaultPreSolve:(CMArbiter*)arbiter space:(CMSpace*)space {
	NSLog(@"Collision: preSolve (between %@ and %@)", [[arbiter shapeA] collisionType], [[arbiter shapeB] collisionType]);
	return YES;
}

- (BOOL) defaultPostSolve:(CMArbiter*)arbiter space:(CMSpace*)space {
	NSLog(@"Collision: postSolve (between %@ and %@)", [[arbiter shapeA] collisionType], [[arbiter shapeB] collisionType]);
	return YES;
}

- (BOOL) defaultSeparate:(CMArbiter*)arbiter space:(CMSpace*)space {
	NSLog(@"Collision: separate (between %@ and %@)", [[arbiter shapeA] collisionType], [[arbiter shapeB] collisionType]);
	return YES;
}

@end
