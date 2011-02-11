	//
	//  CMCollisionHandler.m
	//  Chipmunk
	//
	//  Created by Ronald Mathies on 1/7/11.
	//  Copyright 2011 Sodeso. All rights reserved.
	//

#import "CMCollisionHandler.h"

	// --- Static variables ----------------------------------------------------------------------------

	// --- Static inline methods -----------------------------------------------------------------------

	// --- private interface ---------------------------------------------------------------------------

@interface CMCollisionHandler ()

@end

	// --- Class implementation ------------------------------------------------------------------------

@implementation CMCollisionHandler

@synthesize typeA = mTypeA;
@synthesize typeB = mTypeB;
@synthesize invocationBegin = mInvocationBegin;
@synthesize invocationPreSolve = mInvocationPreSolve;
@synthesize invocationPostSolve = mInvocationPostSolve;
@synthesize invocationSeparate = mInvocationSeparate;
@synthesize ignoreContainmentCollision = mIgnoreContainmentCollision;

- (id) init {
	self = [super init];
	if (self != nil) {
	}
	return self;
}


- (id)initWithTypeA:(cpCollisionType)typeA andTypeB:(cpCollisionType)typeB {
	self = [super init];
	if (self != nil) {
		mTypeA = typeA;
		mTypeB = typeB;
	}
	return self;
}

- (void)setInvocationBegin:(id)target selector:(SEL)selector {
	NSInvocation *invocation = [CMInvocationUtils constructInvocation:target selector:selector];
	[self setInvocationBegin:invocation];
}

- (void)setInvocationPreSolve:(id)target selector:(SEL)selector {
	[self setInvocationPreSolve:[CMInvocationUtils constructInvocation:target selector:selector]];
}

- (void)setInvocationPostSolve:(id)target selector:(SEL)selector {
	[self setInvocationPostSolve:[CMInvocationUtils constructInvocation:target selector:selector]];
}

- (void)setInvocationSeparate:(id)target selector:(SEL)selector {
	[self setInvocationSeparate:[CMInvocationUtils constructInvocation:target selector:selector]];
}

/**
 * Default dealloc method.
 */
- (void) dealloc {
	[mInvocationBegin release];
	[mInvocationPreSolve release];
	[mInvocationPostSolve release];
	[mInvocationSeparate release];
	
	[super dealloc];
}


@end
