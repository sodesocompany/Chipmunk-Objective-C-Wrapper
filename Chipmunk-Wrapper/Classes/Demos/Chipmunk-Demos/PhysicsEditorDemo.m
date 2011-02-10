//
//  PhysicsEditorDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "PhysicsEditorDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface PhysicsEditorDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation PhysicsEditorDemo

- (void) initializeChipmunkObjects {
	[CMPhysicsEditorLoader loadFromConfiguration:self cmSpace:mSpace configuration:@"PhysicsEditor"];
}

- (void)bodyBeforeAddToSpace:(CMBody*)cmBody {
	[cmBody setPositionUsingVect:cpv(160,240)];
}

@end
