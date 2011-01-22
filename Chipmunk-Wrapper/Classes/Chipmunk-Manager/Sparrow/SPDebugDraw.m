//
//  SPDebugDraw.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/4/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "SPDebugDraw.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface SPDebugDraw ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation SPDebugDraw

- (id) initWithManager:(CMSpace*)space {
	self = [super init];
	if (self != nil) {
		[self setTouchable:YES];
		mSpace = [space retain];
	}
	return self;
}

- (void)render:(SPRenderSupport*)support {
	[support bindTexture:nil];
	glEnableClientState(GL_VERTEX_ARRAY);
	drawSpace([mSpace cpSpace]);
	glDisableClientState(GL_VERTEX_ARRAY);
}

- (SPRectangle*)boundsInSpace:(SPDisplayObject*)targetCoordinateSpace {
	return [SPRectangle rectangleWithX:0 y:0 width:320 height:480];
}

- (void) dealloc {
	[mSpace release];
	
	[super dealloc];
}


@end
