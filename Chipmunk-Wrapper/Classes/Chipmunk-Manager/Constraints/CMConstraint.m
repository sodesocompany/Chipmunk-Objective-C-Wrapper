//
//  CMConstraint.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/9/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMConstraint.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMConstraint ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMConstraint

@synthesize cpConstraint = mCpConstraint;

#pragma mark Properties

- (void)setMaxForce:(float)maxForce {
	mCpConstraint->maxForce = maxForce;
}

- (void)setMaxBias:(float)maxBias {
	mCpConstraint->maxBias = maxBias;
}

- (void)setBiasCoef:(float)biasCoef {
	mCpConstraint->biasCoef = biasCoef;
}

- (CMBody*)firstBody {
	CMData *cmData = mCpConstraint->a->data;
	return [cmData object];
}

- (CMBody*)secondBody {
	CMData *cmData = mCpConstraint->b->data;
	return [cmData object];
}

#pragma mark -

#pragma mark Data

- (void)setData:(id)data {
	CMData *cmData = (CMData*)mCpConstraint->data;
	[cmData setData:data];
}

- (id)getData {
	CMData *cmData = (CMData*)mCpConstraint->data;
	return [cmData data];
}
#pragma mark -

#pragma mark Operations

- (void) addToSpace {
	cpSpaceAddConstraint([mSpace cpSpace], mCpConstraint);
}

- (void) removeFromSpace {
	[[self firstBody] removeConstraint:self];
}

#pragma mark -

/**
 * Default dealloc method.
 */
- (void) dealloc {
	CMData *cmData = mCpConstraint->data;
	mCpConstraint->data = NULL;
	[cmData release];
	
	cpSpaceRemoveConstraint([mSpace cpSpace], mCpConstraint);
	mCpConstraint->a = NULL;
	mCpConstraint->b = NULL;
	
	cpConstraintFree(mCpConstraint);
	mCpConstraint = NULL;
	
	[super dealloc];
}


@end
