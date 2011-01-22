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

@end
