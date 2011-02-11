//
//  ExplossionEffectDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "ExplosionEffectDemo.h"

// --- Static variables ----------------------------------------------------------------------------

const float horizontalOffset1 = 70;

const float verticalHeight1 = 40;
const float horizontalHeight1 = 10;

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface ExplosionEffectDemo ()

- (void)initializeChipmunkObjects;
- (void)createBlock:(cpVect)position width:(float)width height:(float)height;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation ExplosionEffectDemo

- (BOOL)disableAccelerometer {
	return YES;
}

- (void) initializeChipmunkObjects {
	int y = 480;
	
	for (int index = 0; index < 4; index++) {
		for (int count = 0; count < 5; count++) {
			[self createBlock:cpv(horizontalOffset1 + 5 + (count * 40),y - verticalHeight1 / 2.0f) width:10 height:verticalHeight1];
		}	
	
		y = y - verticalHeight1;
		for (int count = 0; count < 4; count++) {
			[self createBlock:cpv(horizontalOffset1 + 5 + 20 + (count * 40),y - horizontalHeight1 / 2.0f) width:40 height:horizontalHeight1];
		}
		
		y = y - horizontalHeight1;
	}
	
	[self addEventListener:@selector(removeBlock:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
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
		[CMExplosionEffect perform:mSpace position:[spPoint toCpVect] radius:150 force:800];
	}
}
@end
