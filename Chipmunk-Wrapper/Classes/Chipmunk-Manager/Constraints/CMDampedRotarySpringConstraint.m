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
		cpBody *body1 = [cmBody cpBody];
		cpBody *body2 = [andCmBody cpBody];
		
		mCpConstraint = cpDampedRotarySpringNew(body1, body2, restAngle, stiffness, damping);
		mCpConstraint->data =[[CMData createWithObject:self] retain];
	}
	return self;
}


- (void)setRestAngle:(float)restAngle {
	cpDampedRotarySpringSetRestAngle(mCpConstraint, restAngle);
}

- (float)restAngle {
	return cpDampedRotarySpringGetRestAngle(mCpConstraint);
}

- (void)setStiffness:(float)stiffness {
	cpDampedRotarySpringSetStiffness(mCpConstraint, stiffness);
}

- (float)stiffness {
	return cpDampedRotarySpringGetStiffness(mCpConstraint);
}

- (void)setDamping:(float)damping {
	cpDampedRotarySpringSetDamping(mCpConstraint, damping);
}

- (float)damping {
	return cpDampedRotarySpringGetDamping(mCpConstraint);
}




@end
