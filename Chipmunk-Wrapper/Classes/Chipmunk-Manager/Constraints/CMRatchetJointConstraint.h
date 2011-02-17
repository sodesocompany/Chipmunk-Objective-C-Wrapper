//
//  CMPinJointConstraint.h
//  Chipmunk
//
//  Created by Ronald Mathies on 1/9/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMBody;

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

/**
 * Ratchet joints create rotary ratches similar to a socket wrench.
 */
@interface CMRatchetJointConstraint : CMConstraint {

}

///---------------------------------------------------------------------------------------
/// @name Initialization
///---------------------------------------------------------------------------------------

/**
 * Constructs a new ratchet joint constraint.
 *
 * @param cmBody The first body.
 * @param andCmBody The second body.
 * @param phase The angular offset of the ratchet positions in radians. 
 * @param ratchet The angle in radians of each ratchet position. Negative values cause the ratchet to operate in the opposite direction. 
  */
- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody phase:(float)phase ratchet:(float)ratchet;

/**
 * The angular offset of the ratchet positions in radians.
 *
 * @param phase the angular offset of the ratchet positions in radians.
 */
- (void)setPhase:(float)phase;

/**
 * Returns the angular offset of the ratchet positions in radians.
 *
 * @return the angular offset of the ratchet positions in radians.
 */
- (float)phase;

/**
 * Sets the angle in radians of each ratchet position. 
 * Negative values cause the ratchet to operate in the opposite direction.
 *
 * @param ratchet the angle
 */
- (void)setRatchet:(float)ratchet;

/**
 * Returns the angle in radians of each ratchet position.
 *
 * @return the angle in radians of each ratchet position.
 */
- (float)ratchet;

@end
