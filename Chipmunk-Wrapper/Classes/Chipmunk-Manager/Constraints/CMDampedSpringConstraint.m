//
//  CMPinJointConstraint.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/9/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMDampedSpringConstraint.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMDampedSpringConstraint ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMDampedSpringConstraint

- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody anchor1:(cpVect)anchor1 anchor2:(cpVect)anchor2 restLength:(float)restLength stiffness:(float)stiffness damping:(float)damping {
	if (self = [super init]) {
		cpBody *body1 = [cmBody cpBody];
		cpBody *body2 = [andCmBody cpBody];
		
		mCpConstraint = cpDampedSpringNew(body1, body2, anchor1, anchor2, restLength, stiffness, damping);
		mCpConstraint->data =[[CMData createWithObject:self] retain];
	}
	return self;
}

- (void)setAnchor1:(cpVect)anchor1 {
	cpDampedSpringSetAnchr1(mCpConstraint, anchor1);
}

- (cpVect)anchor1 {
	return cpDampedSpringGetAnchr1(mCpConstraint);
}

- (void)setAnchor2:(cpVect)anchor2 {
	cpDampedSpringSetAnchr2(mCpConstraint, anchor2);
}

- (cpVect)anchor2 {
	return cpDampedSpringGetAnchr2(mCpConstraint);
}

- (void)setRestLength:(float)restLength {
	cpDampedSpringSetRestLength(mCpConstraint, restLength);
}

- (float)restLength {
	return cpDampedSpringGetRestLength(mCpConstraint);
}

- (void)setStiffness:(float)stiffness {
	cpDampedSpringSetStiffness(mCpConstraint, stiffness);
}

- (float)stiffness {
	return cpDampedRotarySpringGetStiffness(mCpConstraint);
}

- (void)setDamping:(float)damping {
	cpDampedSpringSetDamping(mCpConstraint, damping);
}

- (float)damping {
	return cpDampedSpringGetDamping(mCpConstraint);
}

@end
