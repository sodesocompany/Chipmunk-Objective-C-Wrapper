//
//  CMPinJointConstraint.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/9/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMPivotJointConstraint.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMPivotJointConstraint ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMPivotJointConstraint

- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody anchor1:(cpVect)anchor1 anchor2:(cpVect)anchor2 {
	if (self = [super init]) {
		cpBody *body1 = [cmBody cpBody];
		cpBody *body2 = [andCmBody cpBody];
		
		mCpConstraint = cpPivotJointNew2(body1, body2, anchor1, anchor2);
		mCpConstraint->data =[[CMData createWithObject:self] retain];
	}
	return self;
}

- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody pivot:(cpVect)pivot {
	if (self = [super init]) {
		cpBody *body1 = [cmBody cpBody];
		cpBody *body2 = [andCmBody cpBody];
		
		mCpConstraint = cpPivotJointNew(body1, body2, pivot);
		mCpConstraint->data =[[CMData createWithObject:self] retain];
	}
	return self;
}

@end
