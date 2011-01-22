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


@end
