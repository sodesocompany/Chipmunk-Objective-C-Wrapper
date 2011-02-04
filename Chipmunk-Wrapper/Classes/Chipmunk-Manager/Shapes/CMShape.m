//
//  CPShape.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/29/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "CMShape.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMShape ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMShape

@synthesize cpShape = mCpShape;

#pragma mark Properties

- (void)setElasticity:(float)elasticity {
	mCpShape->e = elasticity;
}

- (void)setFriction:(float)friction {
	mCpShape->u = friction;
}

- (void)setCollisionType:(cpCollisionType)type {
	mCpShape->collision_type = type;
}

- (cpCollisionType)collisionType {
	return mCpShape->collision_type;
}

- (void)setGroup:(cpGroup)group {
	mCpShape->group = group;
}

- (void)setLayer:(cpLayers)layer {
	mCpShape->layers = layer;
}

#pragma mark -

#pragma mark Data

- (void)setData:(id)data {
	CMData *cmData = (CMData*)mCpShape->data;
	[cmData setData:data];
}

- (id)getData {
	CMData *cmData = (CMData*)mCpShape->data;
	return [cmData data];
}

#pragma mark -

#pragma mark Operations

- (CMBody*) getBody {
	CMData *cmData = (CMData*)mCpShape->body->data;
	return [cmData object];
}

- (void) addToSpace {
	mStatic = NO;
	cpSpaceAddShape([mSpace cpSpace], mCpShape);
}

- (void) addToSpaceAsStatic {
	mStatic = YES;
	cpSpaceAddStaticShape([mSpace cpSpace], mCpShape);
}

- (void) removeFromSpace {
	[[self getBody] removeShape:self];
}

#pragma mark -

- (void) dealloc {
	CMData *cmData = mCpShape->data;
	mCpShape->data = NULL;
	[cmData release];
	
	cpSpaceRemoveShape([mSpace cpSpace], mCpShape);
	mCpShape->body = NULL;
	
	cpShapeFree(mCpShape);
	mCpShape = NULL;
	
	[super dealloc];
}


@end
