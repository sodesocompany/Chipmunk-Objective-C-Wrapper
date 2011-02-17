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

- (void)setAnchor1:(cpVect)anchor1 {
	cpSlideJointSetAnchr1(mCpConstraint, anchor1);
}

- (cpVect)anchor1 {
	return cpSlideJointGetAnchr1(mCpConstraint);
}

- (void)setAnchor2:(cpVect)anchor2 {
	cpSlideJointSetAnchr2(mCpConstraint, anchor2);
}

- (cpVect)anchor2 {
	return cpSlideJointGetAnchr2(mCpConstraint);
}

- (void)setMin:(float)min {
	cpSlideJointSetMin(mCpConstraint, min);
}

-(float)min {
	return cpSlideJointGetMin(mCpConstraint);
}

- (void)setMax:(float)max {
	cpSlideJointSetMax(mCpConstraint, max);
}

- (float)max {
	return cpSlideJointGetMax(mCpConstraint);
}

@end
