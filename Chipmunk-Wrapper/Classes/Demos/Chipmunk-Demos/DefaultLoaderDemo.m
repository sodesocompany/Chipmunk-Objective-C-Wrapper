//
//  DefaultLoaderDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "DefaultLoaderDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface DefaultLoaderDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation DefaultLoaderDemo

- (void) initializeChipmunkObjects {
	[CMDefaultLoader loadFromConfiguration:self cmSpace:mSpace configuration:@"Demo"];
}

@end
