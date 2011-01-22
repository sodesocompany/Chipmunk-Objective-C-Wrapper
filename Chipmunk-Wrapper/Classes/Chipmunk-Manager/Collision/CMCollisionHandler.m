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

- (NSInvocation*)constructInvocation:(id)target selector:(SEL)selector;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMCollisionHandler

@synthesize typeA = mTypeA;
@synthesize typeB = mTypeB;
@synthesize invocationBegin = mInvocationBegin;
@synthesize invocationPreSolve = mInvocationPreSolve;
@synthesize invocationPostSolve = mInvocationPostSolve;
@synthesize invocationSeparate = mInvocationSeparate;

- (id) init {
	self = [super init];
	if (self != nil) {
	}
	return self;
}


- (id)initWithTypeA:(unsigned int)typeA andTypeB:(unsigned int)typeB {
	self = [super init];
	if (self != nil) {
		mTypeA = typeA;
		mTypeB = typeB;
	}
	return self;
}

- (void)setInvocationBegin:(id)target selector:(SEL)selector {
	[self setInvocationBegin:[self constructInvocation:target selector:selector]];
}

- (void)setInvocationPreSolve:(id)target selector:(SEL)selector {
	[self setInvocationPreSolve:[self constructInvocation:target selector:selector]];
}

- (void)setInvocationPostSolve:(id)target selector:(SEL)selector {
	[self setInvocationPostSolve:[self constructInvocation:target selector:selector]];
}

- (void)setInvocationSeparate:(id)target selector:(SEL)selector {
	[self setInvocationSeparate:[self constructInvocation:target selector:selector]];
}

- (NSInvocation*)constructInvocation:(id)target selector:(SEL)selector {
	if (target != nil && selector != nil) {
		NSMethodSignature * sig = [[target class] instanceMethodSignatureForSelector:selector];
		NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
	
		[invocation setTarget:target];
		[invocation setSelector:selector];
	
		return invocation;
	} else {
		return nil;
	}
}

@end
