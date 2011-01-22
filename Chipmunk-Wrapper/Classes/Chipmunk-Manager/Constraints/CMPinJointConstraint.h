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
 * Pin joints hold a set distance between points on two bodies.
 */
@interface CMPinJointConstraint : CMConstraint {

}

/**
 * Constructs a new pin joint constraint.
 *
 * @param cmBody The first body.
 * @param andCmBody The second body.
 * @param anchor1  The anchor point on the first body. 
 * @param anchor2 The anchor point on the second body. 
 */
- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody anchor1:(cpVect)anchor1 anchor2:(cpVect)anchor2;


@end
