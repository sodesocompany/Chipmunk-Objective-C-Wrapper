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
 * Like a CMDampedSpringConstraint, but operates in a rotational fashion.
 */
@interface CMDampedRotarySpringConstraint : CMConstraint {

}

///---------------------------------------------------------------------------------------
/// @name Initialization
///---------------------------------------------------------------------------------------

/**
 * Constructs a new damped rotary constraint.
 *
 * @param cmBody The first body.
 * @param andCmBody The second body.
 * @param restAngle The angular offset the spring attempts to keep between the two bodies. 
 * @param stiffness The young's modulus of the spring.  (http://en.wikipedia.org/wiki/Young%27s_modulus)
 * @param damping The amount of viscous damping to apply. 
  */
- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody restAngle:(float)restAngle stiffness:(float)stiffness damping:(float)damping;


/**
 * The angular offset the spring attempts to keep between the two bodies.
 *
 * @param restAngle the angular offset the spring attempts to keep between the two bodies.
 */
- (void)setRestAngle:(float)restAngle;

/**
 * Returns the angular offset the spring attempts to keep between the two bodies.
 *
 * @return the angular offset the spring attempts to keep between the two bodies.
 */
- (float)restAngle;

/**
 * The young's modulus of the spring.
 *
 * (http://en.wikipedia.org/wiki/Young%27s_modulus)
 *
 * @param stiffness the young's modulus of the spring.
 */
- (void)setStiffness:(float)stiffness;

/**
 * Returns the the young's modulus of the spring.
 *
 * @return the young's modulus of the spring.
 */
- (float)stiffness;

/**
 * The amount of viscous damping to apply.
 *
 * @param damping the amount of viscous damping to apply.
 */
- (void)setDamping:(float)damping;

/**
 * Returns the amount of viscous damping to apply.
 *
 * @return the amount of viscous damping to apply.
 */
- (float)damping;

@end
