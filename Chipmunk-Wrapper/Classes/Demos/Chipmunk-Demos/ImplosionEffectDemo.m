//
//  ImplosionEffectDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "ImplosionEffectDemo.h"

// --- Static variables ----------------------------------------------------------------------------

const float horizontalOffset2 = 70;

const float verticalHeight2 = 40;
const float horizontalHeight2 = 10;

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface ImplosionEffectDemo ()

- (void)initializeChipmunkObjects;
- (void)createBlock:(cpVect)position width:(float)width height:(float)height;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation ImplosionEffectDemo

- (BOOL)disableAccelerometer {
	return YES;
}

- (void) initializeChipmunkObjects {
	int y = 480;
	
	for (int index = 0; index < 4; index++) {
		for (int count = 0; count < 5; count++) {
			[self createBlock:cpv(horizontalOffset2 + 5 + (count * 40),y - verticalHeight2 / 2.0f) width:10 height:verticalHeight2];
		}	
	
		y = y - verticalHeight2;
		for (int count = 0; count < 4; count++) {
			[self createBlock:cpv(horizontalOffset2 + 5 + 20 + (count * 40),y - horizontalHeight2 / 2.0f) width:40 height:horizontalHeight2];
		}
		
		y = y - horizontalHeight2;
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
		CMBlastEffect *effect = [[CMBlastEffect alloc] init];
		
		[effect implosion:mSpace position:[spPoint toCpVect] radius:150 force:800];
		[effect release];
	}
}
@end
