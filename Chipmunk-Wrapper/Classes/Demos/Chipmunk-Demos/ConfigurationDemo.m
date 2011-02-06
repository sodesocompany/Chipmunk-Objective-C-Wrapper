//
//  DampedRotaryConstraintDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "ConfigurationDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface ConfigurationDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation ConfigurationDemo

- (void) initializeChipmunkObjects {
	[CMLoader loadFromConfiguration:mSpace configuration:@"Demo"];
}

@end
