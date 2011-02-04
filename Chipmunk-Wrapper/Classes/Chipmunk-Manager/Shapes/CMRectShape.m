//
//  CMRect.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/2/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMRectShape.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMRectShape ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMRectShape

- (id) initWithBody:(CMBody*)cmBody  width:(float)width height:(float)height {
	if (self = [self initWithBody:cmBody width:width height:height offset:cpvzero]) {
	}
	return self;
}

- (id) initWithBody:(CMBody*)cmBody  width:(float)width height:(float)height offset:(cpVect)offset {
	if (self = [super init]) {
		float halfWidth = width / 2.0f;
		float halfHeight = height / 2.0f;
		
		cpVect vertices[4];
		vertices[0] = cpv(-halfWidth, halfHeight);
		vertices[1] = cpv( halfWidth, halfHeight);
		vertices[2] = cpv( halfWidth,-halfHeight);
		vertices[3] = cpv(-halfWidth,-halfHeight);
		
		cpBody *body = [cmBody cpBody];
		if (body->m != INFINITY) {
			
				// Calculate the moment.
			cpFloat moment = cpMomentForPoly(body->m, 4, vertices, offset);
			cpBodySetMoment(body, moment);
		}
		
		
		mCpShape = cpPolyShapeNew(body, 4, vertices, offset);
		mCpShape->data = [[CMData createWithObject:self] retain];
	}
	return self;
}

@end
