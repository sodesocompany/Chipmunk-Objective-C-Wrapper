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
		cpBody *body1 = [cmBody cpBody];
		cpBody *body2 = [andCmBody cpBody];
		
		mCpConstraint = cpRotaryLimitJointNew(body1, body2, min, max);
		mCpConstraint->data =[[CMData createWithObject:self] retain];
	}
	return self;
}

- (void)setMin:(float)min {
	cpRotaryLimitJointSetMin(mCpConstraint, min);
}

-(float)min {
	return cpRotaryLimitJointGetMin(mCpConstraint);
}

- (void)setMax:(float)max {
	cpRotaryLimitJointSetMax(mCpConstraint, max);
}

- (float)max {
	return cpRotaryLimitJointGetMax(mCpConstraint);
}

@end
