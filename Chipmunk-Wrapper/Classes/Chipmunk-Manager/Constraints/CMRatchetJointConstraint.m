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

@interface CMRatchetJointConstraint ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMRatchetJointConstraint

- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody phase:(float)phase ratchet:(float)ratchet {
	if (self = [super init]) {
		cpBody *body1 = [cmBody cpBody];
		cpBody *body2 = [andCmBody cpBody];
		
		mCpConstraint = cpRatchetJointNew(body1, body2, phase, ratchet);
		mCpConstraint->data =[[CMData createWithObject:self] retain];
	}
	return self;
}

- (void)setPhase:(float)phase {
	cpRatchetJointSetPhase(mCpConstraint, phase);
}

- (float)phase {
	return cpRatchetJointGetPhase(mCpConstraint);
}

- (void)setRatchet:(float)ratchet {
	cpRatchetJointSetRatchet(mCpConstraint, ratchet);
}

- (float)ratchet {
	return cpRatchetJointGetRatchet(mCpConstraint);
}

@end
