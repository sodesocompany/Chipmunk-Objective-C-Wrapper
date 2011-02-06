//
//  CMSegmentShape.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/8/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMSegmentShape.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMSegmentShape ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMSegmentShape

- (id) initWithBody:(CMBody*)cmBody from:(cpVect)from to:(cpVect)to radius:(float)radius {
	if (self = [super init]) {
		cpBody *body = [cmBody cpBody];
		if (body->m != INFINITY) {
			
			// Calculate the moment.
			cpFloat moment = cpMomentForSegment(body->m, from, to);
			cpBodySetMoment(body, moment);
		}
		
		mCpShape = cpSegmentShapeNew(body, from, to, radius);
		mCpShape->data =[[CMData createWithObject:self] retain];
	}
	return self;
}

@end
