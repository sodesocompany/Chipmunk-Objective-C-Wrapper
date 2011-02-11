//
//  CMInvocationUtils.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "CMInvocationUtils.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMInvocationUtils ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMInvocationUtils

+ (NSInvocation*)constructInvocation:(id)target selector:(SEL)selector {
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
