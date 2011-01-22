//
//  CMPinJointConstraint.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/9/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMDampedRotarySpringConstraint.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMDampedRotarySpringConstraint ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMDampedRotarySpringConstraint

- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody restAngle:(float)restAngle stiffness:(float)stiffness damping:(float)damping {
	if (self = [super init]) {
		cpBody *body1 = [cmBody construct];
		cpBody *body2 = [andCmBody construct];
		
		mConstraint = cpDampedRotarySpringNew(body1, body2, restAngle, stiffness, damping);
		mConstraint->data =[[CMData createWithObject:self] retain];
	}
	return self;
}

@end
