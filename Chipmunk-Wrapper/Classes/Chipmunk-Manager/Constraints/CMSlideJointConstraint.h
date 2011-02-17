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
 * Slide joints hold the distance between points on two bodies between a minimum and a maximum.
 */
@interface CMSlideJointConstraint : CMConstraint {

}

///---------------------------------------------------------------------------------------
/// @name Initialization
///---------------------------------------------------------------------------------------

/**
 * Constructs a new Slide joing constraint.
 *
 * @param cmBody The first body.
 * @param andCmBody The second body.
 * @param anchor1 The anchor point on the first body. 
 * @param anchor2 The anchor point on the second body. 
 * @param min The minimum allowed distance between anchor points. 
 * @param max The maximum allowed distance between anchor points. 
 */
- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody anchor1:(cpVect)anchor1 anchor2:(cpVect)anchor2 min:(float)min max:(float)max;

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
 * Sets the minimum allowed distance between anchor points.
 *
 * @param min the minimum allowed distance between anchor points.
 */
- (void)setMin:(float)min;

/**
 * Returns minimum allowed distance between anchor points.
 *
 * @returns the minimum allowed distance between anchor points.
 */
-(float)min;

/**
 * Sets the maximum allowed distance between anchor points. 
 *
 * @param max the maximum allowed distance between anchor points. 
 */
- (void)setMax:(float)max;

/**
 * Returns the maximum allowed distance between anchor points. 
 *
 * @return maximum allowed distance between anchor points. 
 */
- (float)max;

@end
