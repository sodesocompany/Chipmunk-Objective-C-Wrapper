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
 * Pivot joints hold two points on two bodies together allowing them to rotate freely around the pivot.
 */
@interface CMPivotJointConstraint : CMConstraint {

}

///---------------------------------------------------------------------------------------
/// @name Initialization
///---------------------------------------------------------------------------------------

/**
 * Constructs a new pivot joing using two anchors.
 *
 * @param cmBody The first body.
 * @param andCmBody The second body.
 * @param anchor1 The anchor point on the first body. 
 * @param anchor2 The anchor point on the second body. 
  */
- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody anchor1:(cpVect)anchor1 anchor2:(cpVect)anchor2;

/**
 * Constructs a new pivot joint using a pivot.
 *
 * @param cmBody The first body.
 * @param andCmBody The second body.
 * @param pivot The pivot point.
  */
- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody pivot:(cpVect)pivot;

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

@end
