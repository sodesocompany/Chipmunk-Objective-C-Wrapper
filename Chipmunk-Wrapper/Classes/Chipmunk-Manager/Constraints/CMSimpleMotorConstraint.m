//
//  CMSimpleMotorConstraint.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/9/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMSimpleMotorConstraint.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMSimpleMotorConstraint ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMSimpleMotorConstraint

- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody rate:(float)rate {
	if (self = [super init]) {
		cpBody *body1 = [cmBody construct];
		cpBody *body2 = [andCmBody construct];
		
		mConstraint = cpSimpleMotorNew(body1, body2, rate);
		mConstraint->data =[[CMData createWithObject:self] retain];
	}
	return self;
}

@end
