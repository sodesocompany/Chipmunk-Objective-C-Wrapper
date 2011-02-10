//
//  CMArbiter.m
//  ChipmunkWrapper
//
//  Created by Ronald Mathies on 1/25/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMArbiter.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMArbiter ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMArbiter

- (id)initWithCpArbiter:(cpArbiter*)arbiter {
	self = [super init];
	if (self != nil) {
		mArbiter = arbiter;
	}
	return self;
}

- (CMShape*)shapeA {
	CMData *dataShapeA = (CMData*)mArbiter->a->data;
	return (CMShape*)[dataShapeA object];
}

- (CMShape*)shapeB {
	CMData *dataShapeB = (CMData*)mArbiter->b->data;
	return (CMShape*)[dataShapeB object];
}

- (int)numberOfContacts {
	// Same as cpArbiterGetCount(mArbiter);
	return mArbiter->numContacts;
}

- (NSArray*)contactPoints {
	cpContactPointSet contactPointSet= cpArbiterGetContactPointSet(mArbiter);
	
	NSMutableArray *contactPoints = [NSMutableArray arrayWithCapacity:contactPointSet.count];
	for (int index = 0; index < contactPointSet.count; index++) {
		
		CMContactPoint *cmContactPoint = [[[CMContactPoint alloc] init] autorelease];
		[cmContactPoint setPoint:contactPointSet.points[index].point];
		[cmContactPoint setNormal:contactPointSet.points[index].normal];
		[cmContactPoint setDistance:contactPointSet.points[index].dist];

		[contactPoints addObject:cmContactPoint];
	}

	return contactPoints;
}

- (void)setElasticity:(float)elasticity {
	mArbiter->e = elasticity;
}

- (void)setFriction:(float)friction {
	mArbiter->u = friction;
}

- (BOOL)areShapesSwapped {
	return (BOOL)mArbiter->swappedColl;
}

- (BOOL)isFirstContact {
	return cpArbiterIsFirstContact(mArbiter);
}

/**
 * Default dealloc method.
 */
- (void) dealloc {
	// Nothing to dealloc, everything
	// is only assigned but not retained.
	[super dealloc];
}


@end
