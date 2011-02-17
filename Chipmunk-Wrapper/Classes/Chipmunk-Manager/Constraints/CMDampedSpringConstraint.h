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
 * A spring with a damper.
 * While a spring is not technically a constraint, the damper is. The spring forces are simply a convenience. 
 */
@interface CMDampedSpringConstraint : CMConstraint {

}

///---------------------------------------------------------------------------------------
/// @name Initialization
///---------------------------------------------------------------------------------------

/**
 * Constructs a new damped spring.
 *
 * @param cmBody The first body.
 * @param andCmBody The second body.
 * @param anchor1 The anchor point on the first body. 
 * @param anchor2 The anchor point on the second body. 
 * @param restLength The length the spring wants to contract or expand to. 
 * @param stiffness The young's modulus of the spring.  (http://en.wikipedia.org/wiki/Young%27s_modulus)
 * @param damping The amount of viscous damping to apply. 
  */
- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody anchor1:(cpVect)anchor1 anchor2:(cpVect)anchor2 restLength:(float)restLength stiffness:(float)stiffness damping:(float)damping;

/**
 * Changes the first anchor point.
 *
 * @param anchor1 the new anchor point.
 */
- (void)setAnchor1:(cpVect)anchor1;

/**
 * Returns the first anchor point.
 *
 * @return the first anchor point.
 */
- (cpVect)anchor1;

/**
 * Changes the second anchor point.
 *
 * @param anchor2 the new anchor point.
 */
- (void)setAnchor2:(cpVect)anchor2;

/**
 * Returns the second anchor point.
 *
 * @return the second anchor point.
 */
- (cpVect)anchor2;

/**
 * The length the spring wants to contract or expand to. 
 *
 * @param restLength the length the spring wants to contract or expand to. 
 */
- (void)setRestLength:(float)restLength;

/**
 * Returns the length the spring wants to contract or expand to. 
 *
 * @return the length the spring wants to contract or expand to. 
 */
- (float)restLength;

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
