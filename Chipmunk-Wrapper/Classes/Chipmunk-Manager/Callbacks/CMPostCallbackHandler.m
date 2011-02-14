//
//  CMPostCallbackHandler.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/7/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMPostCallbackHandler.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMPostCallbackHandler ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMPostCallbackHandler

@synthesize postCallback = mPostCallback;
@synthesize data = mData;

- (id)initWithTarget:(id)target selector:(SEL)selector {
	self = [super init];
	if (self != nil) {
		NSInvocation *invocation = [CMInvocationUtils constructInvocation:target selector:selector];
		[self setPostCallback:invocation];
	}
	return self;
}

/**
 * Default dealloc method.
 */
- (void) dealloc {
	[mPostCallback release];
	[mData release];
	
	[super dealloc];
}


@end
