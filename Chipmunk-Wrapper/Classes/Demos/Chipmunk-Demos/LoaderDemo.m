//
//  LoaderDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "LoaderDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface LoaderDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation LoaderDemo

- (void) initializeChipmunkObjects {
	[CMLoader loadFromConfiguration:self cmSpace:mSpace configuration:@"Demo"];
}

@end
