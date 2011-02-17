//
//  CMSimpleMotorConstraint.h
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
 * Simple motors make two objects spin relative to each other.
 */
@interface CMSimpleMotorConstraint : CMConstraint {

}

///---------------------------------------------------------------------------------------
/// @name Initialization
///---------------------------------------------------------------------------------------

/**
 * Constructs a new simple motor constraint.
 *
 * @param cmBody The first body.
 * @param andCmBody The second body.
 * @param rate The relative rotation speed of the two bodies in radians per second. 
 */
- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody rate:(float)rate;

/**
 * The relative rotation speed of the two bodies in radians per second.
 *
 * @param rate the relative rotation speed of the two bodies in radians per second. 
 */
- (void)setRate:(float)rate;

/**
 * Returns the relative rotation speed of the two bodies in radians per second. 
 *
 * @return the relative rotation speed of the two bodies in radians per second. 
 */
- (float)rate;

@end
