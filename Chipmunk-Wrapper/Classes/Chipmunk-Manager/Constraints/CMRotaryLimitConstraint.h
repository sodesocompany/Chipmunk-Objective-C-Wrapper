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
 * Constrains the angle between two bodies.
 */
@interface CMRotaryLimitConstraint : CMConstraint {

}

///---------------------------------------------------------------------------------------
/// @name Initialization
///---------------------------------------------------------------------------------------

/**
 * Constructs a new rotary limit constraint.
 *
 * @param cmBody The first body.
 * @param andCmBody The second body.
 * @param min The minimum angular delta of the joint in radians. 
 * @param max The maximum angular delta of the joint in radians. 
  */
- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody min:(float)min max:(float)max;

/**
 * Sets the minimum angular delta of the joint in radians.
 *
 * @param min the minimum angular delta of the joint in radians.
 */
- (void)setMin:(float)min;

/**
 * Returns the minimum angular delta of the joint in radians.
 *
 * @returns the minimum angular delta of the joint in radians.
 */
-(float)min;

/**
 * Sets the maximum angular delta of the joint in radians.
 *
 * @param max the maximum angular delta of the joint in radians.
 */
- (void)setMax:(float)max;

/**
 * Returns the maximum angular delta of the joint in radians.
 *
 * @return the maximum angular delta of the joint in radians.
 */
- (float)max;

@end
