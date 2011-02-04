//
//  CMCircle.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/31/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "CMCircleShape.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMCircleShape ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMCircleShape

- (id) initWithBody:(CMBody*)cmBody radius:(float)radius {
	if (self = [self initWithBody:cmBody radius:radius offset:cpvzero]) {
	}
	return self;
}

- (id) initWithBody:(CMBody*)cmBody radius:(float)radius offset:(cpVect)offset {
	if (self = [super init]) {
		cpBody *body = [cmBody cpBody];
		
		if (body->m != INFINITY) {
			// Calculate the moment.
			cpFloat moment = cpMomentForCircle(body->m, 0.0f, radius, offset);
			cpBodySetMoment(body, moment);
		}
		
		mCpShape = cpCircleShapeNew(body, radius, offset);
		mCpShape->data =[[CMData createWithObject:self] retain];
	}
	return self;
}

@end
