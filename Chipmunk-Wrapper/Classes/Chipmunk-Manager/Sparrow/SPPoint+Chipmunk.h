//
//  SPPoint+Chipmunk.h
//  Chipmunk
//
//  Created by Ronald Mathies on 1/4/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "SPPoint.h"

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

/**
 * SPPoint category class, adding some convenience methods for Chipmunk
 */
@interface SPPoint (Chipmunk)

/**
 * Converts this point to a cpVect.
 *
 * @return a cpVect containing this point's x/y coordinate.
 */
- (cpVect) toCpVect;

@end
