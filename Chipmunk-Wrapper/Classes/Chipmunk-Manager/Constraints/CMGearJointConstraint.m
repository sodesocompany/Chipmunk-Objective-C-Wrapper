//
//  CMPinJointConstraint.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/9/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMGearJointConstraint.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMGearJointConstraint ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMGearJointConstraint

- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody phase:(float)phase ratio:(float)ratio {
	if (self = [super init]) {
		cpBody *body1 = [cmBody cpBody];
		cpBody *body2 = [andCmBody cpBody];
		
		mCpConstraint = cpGearJointNew(body1, body2, phase, ratio);
		mCpConstraint->data =[[CMData createWithObject:self] retain];
	}
	return self;
}

- (void)setPhase:(float)phase {
	cpGearJointSetPhase(mCpConstraint, phase);
}

- (float)phase {
	return cpGearJointGetPhase(mCpConstraint);
}

- (void)setRatio:(float)ratio {
	cpGearJointSetRatio(mCpConstraint, ratio);
}

- (float)ratio {
	return cpGearJointGetRatio(mCpConstraint);
}


@end
