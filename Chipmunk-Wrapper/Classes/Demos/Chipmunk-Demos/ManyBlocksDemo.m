//
//  BlocksDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "ManyBlocksDemo.h"

// --- Static variables ----------------------------------------------------------------------------

const float horizontalOffset = 70;

const float verticalHeight = 40;
const float horizontalHeight = 10;

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface ManyBlocksDemo ()

- (void)initializeChipmunkObjects;
- (void)createBlock:(cpVect)position width:(float)width height:(float)height;

- (void)verticalBars:(float)y;
- (void)horizontalBars:(float)y;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation ManyBlocksDemo

- (void) initializeChipmunkObjects {
	int y = 480;
	
	for (int index = 0; index < 9; index++) {
		[self verticalBars:y];
	
		y = y - verticalHeight;
		[self horizontalBars:y];
		
		y = y - horizontalHeight;
	}

	[self addEventListener:@selector(removeBlock:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

- (void)horizontalBars:(float)y {
	for (int count = 0; count < 4; count++) {
		[self createBlock:cpv(horizontalOffset + 5 + 20 + (count * 40),y - horizontalHeight / 2.0f) width:40 height:horizontalHeight];
	}	
}

- (void)verticalBars:(float)y {
	for (int count = 0; count < 5; count++) {
		[self createBlock:cpv(horizontalOffset + 5 + (count * 40),y - verticalHeight / 2.0f) width:10 height:verticalHeight];
	}	
}

- (BOOL)disableAccelerometer {
	return YES;
}

- (void)createBlock:(cpVect)position width:(float)width height:(float)height {
	CMBody *squareBody = [mSpace addBodyWithMass:1 moment:0];
	[squareBody setPositionUsingVect:position];
	[squareBody addToSpace];
	
	CMShape *squareShape = [squareBody addRectangleWithWidth:width height:height];
	[squareShape setElasticity:0.0];
	[squareShape setFriction:0.7];
	[squareShape addToSpace];
}

- (void)removeBlock:(SPTouchEvent*)event {
	SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
	if (touch) {
		SPPoint *spPoint = [touch locationInSpace:self];
		CMShape *shape = [mSpace queryFirstByPoint:spPoint];
		if (shape != nil) {
			CMBody *body = [shape body];
			[body removeFromSpace];
		}
	}
}
@end
