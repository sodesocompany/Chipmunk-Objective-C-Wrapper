//
//  BlocksDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "BlocksDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface BlocksDemo ()

- (void)initializeChipmunkObjects;
- (void)createBlock:(cpVect)position width:(float)width height:(float)height;
- (void)createBall;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation BlocksDemo

- (void) initializeChipmunkObjects {
	[self createBlock:cpv(220,440) width:20 height:80];
	[self createBlock:cpv(260,440) width:20 height:80];

	[self createBlock:cpv(240,390) width:80 height:20];

	[self createBlock:cpv(220,340) width:20 height:80];
	[self createBlock:cpv(260,340) width:20 height:80];

	[self createBlock:cpv(240,290) width:80 height:20];

	[self createBlock:cpv(220,240) width:20 height:80];
	[self createBlock:cpv(260,240) width:20 height:80];

	[self createBlock:cpv(240,190) width:80 height:20];

	[self createBlock:cpv(220,140) width:20 height:80];
	[self createBlock:cpv(260,140) width:20 height:80];
	
	[self createBall];
}

- (BOOL)disableAccelerometer {
	return YES;
}

- (void)createBlock:(cpVect)position width:(float)width height:(float)height {
	CMBody *squareBody = [mSpace addBodyWithMass:5 moment:0];
	[squareBody setPositionUsingVect:position];
	[squareBody addToSpace];
	
	CMShape *squareShape = [squareBody addRectangleWithWidth:width height:height];
	[squareShape setElasticity:0.5];
	[squareShape setFriction:0.5];
	[squareShape addToSpace];
}

/**
 * Create a loose ball wich can be dragged in the direction of the rope.
 */
- (void)createBall {
	CMBody *ballBody = [mSpace addBodyWithMass:20 moment:0];
	[ballBody setPositionUsingVect:cpv(60, 420)];
	[ballBody addToSpace];	
	
	CMShape *ballShape = [ballBody addCircleWithRadius:30.0f];
	[ballShape setElasticity:0.0];
	[ballShape setFriction:0.7];
	[ballShape addToSpace];
}

@end
