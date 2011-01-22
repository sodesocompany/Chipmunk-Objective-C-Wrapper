//
//  CMPinJointConstraint.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/9/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMRotaryLimitConstraint.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMRotaryLimitConstraint ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMRotaryLimitConstraint

- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody min:(float)min max:(float)max {
	if (self = [super init]) {
		cpBody *body1 = [cmBody construct];
		cpBody *body2 = [andCmBody construct];
		
		mConstraint = cpRotaryLimitJointNew(body1, body2, min, max);
		mConstraint->data =[[CMData createWithObject:self] retain];
	}
	return self;
}

@end
