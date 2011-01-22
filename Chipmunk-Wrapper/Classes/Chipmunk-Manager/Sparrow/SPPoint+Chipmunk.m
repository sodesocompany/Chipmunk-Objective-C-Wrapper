//
//  SPPoint+Chipmunk.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/4/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "SPPoint.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

// --- Class implementation ------------------------------------------------------------------------

@implementation SPPoint (Chipmunk)

- (cpVect) toCpVect {
	return cpv([self x], [self y]);
}

@end
