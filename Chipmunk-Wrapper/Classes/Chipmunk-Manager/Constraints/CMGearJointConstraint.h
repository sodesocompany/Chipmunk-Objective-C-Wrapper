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
 * Gear joints constrain the rotational speed of one body to another.
 */
@interface CMGearJointConstraint : CMConstraint {

}

///---------------------------------------------------------------------------------------
/// @name Initialization
///---------------------------------------------------------------------------------------

/**
 * Constructs a new gear joint constraint.
 *
 * @param cmBody The first body.
 * @param andCmBody The second body.
 * @param phase The angular offset of the ratchet positions in radians. 
 * @param ratio The angle in radians of each ratchet position. Negative values cause the ratchet to operate in the opposite direction. 
  */
- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody phase:(float)phase ratio:(float)ratio;

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
 * The angle in radians of each ratchet position. Negative values cause the ratchet to operate in the opposite direction. 
 *
 * @param ratio the angle.
 */
- (void)setRatio:(float)ratio;

/**
 * Returns the angle in radians of each ratchet position. Negative values cause the ratchet to operate in the opposite direction. 
 *
 * @return the angle.
 */
- (float)ratio;

@end
