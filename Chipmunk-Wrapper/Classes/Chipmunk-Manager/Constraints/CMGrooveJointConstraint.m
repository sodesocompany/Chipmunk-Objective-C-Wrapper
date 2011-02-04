//
//  CMPinJointConstraint.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/9/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMGrooveJointConstraint.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMGrooveJointConstraint ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMGrooveJointConstraint

- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody grooveA:(cpVect)grooveA grooveB:(cpVect)grooveB anchor1:(cpVect)anchor1 {
	if (self = [super init]) {
		cpBody *body1 = [cmBody cpBody];
		cpBody *body2 = [andCmBody cpBody];
		
		mCpConstraint = cpGrooveJointNew(body1, body2, grooveA, grooveB, anchor1);
		mCpConstraint->data =[[CMData createWithObject:self] retain];
	}
	return self;
}

@end
