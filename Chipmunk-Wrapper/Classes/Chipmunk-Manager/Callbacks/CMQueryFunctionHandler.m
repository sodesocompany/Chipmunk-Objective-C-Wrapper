//
//  CMQueryFunctionHandler.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/7/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMQueryFunctionHandler.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMQueryFunctionHandler ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMQueryFunctionHandler

@synthesize queryFunction = mQueryFunction;
@synthesize data = mData;

- (id)initWithTarget:(id)target selector:(SEL)selector {
	self = [super init];
	if (self != nil) {
		NSInvocation *invocation = [CMInvocationUtils constructInvocation:target selector:selector];
		[self setQueryFunction:invocation];
	}
	return self;
}

/**
 * Default dealloc method.
 */
- (void) dealloc {
	[mQueryFunction release];
	[mData release];
	
	[super dealloc];
}


@end
