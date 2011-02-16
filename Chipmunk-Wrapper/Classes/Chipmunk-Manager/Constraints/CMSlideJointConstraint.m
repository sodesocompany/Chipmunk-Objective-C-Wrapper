//
//  CMPinJointConstraint.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/9/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMSlideJointConstraint.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMSlideJointConstraint ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMSlideJointConstraint

- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody anchor1:(cpVect)anchor1 anchor2:(cpVect)anchor2 min:(float)min max:(float)max {
	if (self = [super init]) {
		cpBody *body1 = [cmBody cpBody];
		cpBody *body2 = [andCmBody cpBody];
		mCpConstraint = cpSlideJointNew(body1, body2, anchor1, anchor2, min, max);
		mCpConstraint->data =[[CMData createWithObject:self] retain];
	}
	return self;
}

@end
