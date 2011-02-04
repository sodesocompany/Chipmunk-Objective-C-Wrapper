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

#pragma mark Properties

- (void)setElasticity:(float)elasticity {
	mShape->e = elasticity;
}

- (void)setFriction:(float)friction {
	mShape->u = friction;
}

- (void)setCollisionType:(cpCollisionType)type {
	mShape->collision_type = type;
}

- (cpCollisionType)collisionType {
	return mShape->collision_type;
}

- (void)setGroup:(cpGroup)group {
	mShape->group = group;
}

#pragma mark -

#pragma mark Data

- (void)setData:(id)data {
	CMData *cmData = (CMData*)mShape->data;
	[cmData setData:data];
}

- (id)getData {
	CMData *cmData = (CMData*)mShape->data;
	return [cmData data];
}

#pragma mark -

#pragma mark Operations

- (CMBody*) getBody {
	CMData *cmData = (CMData*)mShape->body->data;
	return [cmData object];
}

- (void) addToSpace {
	mStatic = NO;
	cpSpaceAddShape([mSpace cpSpace], mShape);
}

- (void) addToSpaceAsStatic {
	mStatic = YES;
	cpSpaceAddStaticShape([mSpace cpSpace], mShape);
}

- (void) removeFromSpace {
	if (mStatic == YES) {
		cpSpaceRemoveStaticShape([mSpace cpSpace], mShape);
	} else {
		cpSpaceRemoveShape([mSpace cpSpace], mShape);
	}
}

- (cpShape*) construct {
	return mShape;
}

#pragma mark -

- (void) dealloc {
	CMData *cmData = mShape->data;
	mShape->data = NULL;
	[cmData release];

	[super dealloc];
}


@end
