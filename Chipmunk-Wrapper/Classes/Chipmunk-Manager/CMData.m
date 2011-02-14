//
//  CMData.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "CMData.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMData ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMData

@synthesize data = mData;
@synthesize object = mObject;

- (id) initWithObject:(id)object {
	if (self = [super init]) {
		[self setObject:object];
	}
	return self;
}

+ (CMData*)createWithObject:(id)object {
	return [[[CMData alloc] initWithObject:object] autorelease];
}

@end
