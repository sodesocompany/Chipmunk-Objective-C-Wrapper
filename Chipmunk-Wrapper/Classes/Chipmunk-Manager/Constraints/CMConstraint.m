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

#pragma mark Properties

- (void)setMaxForce:(float)maxForce {
	mConstraint->maxForce = maxForce;
}

- (void)setMaxBias:(float)maxBias {
	mConstraint->maxBias = maxBias;
}

- (void)setBiasCoef:(float)biasCoef {
	mConstraint->biasCoef = biasCoef;
}

- (CMBody*)firstBody {
	CMData *cmData = mConstraint->a->data;
	return [cmData object];
}

- (CMBody*)secondBody {
	CMData *cmData = mConstraint->b->data;
	return [cmData object];
}

#pragma mark -

#pragma mark Data

- (void)setData:(id)data {
	CMData *cmData = (CMData*)mConstraint->data;
	[cmData setData:data];
}

- (id)getData {
	CMData *cmData = (CMData*)mConstraint->data;
	return [cmData data];
}
#pragma mark -

#pragma mark Operations

- (void) addToSpace {
	cpSpaceAddConstraint([mSpace cpSpace], mConstraint);
}

- (void) removeFromSpace {
	cpSpaceRemoveConstraint([mSpace cpSpace], mConstraint);
}

- (void) free {
	cpConstraintFree(mConstraint);
}

- (cpConstraint*) construct {
	return mConstraint;
}

#pragma mark -

- (void) dealloc {
	CMData *cmData = mConstraint->data;
	mConstraint->data = NULL;
	[cmData release];
	
	[super dealloc];
}


@end
