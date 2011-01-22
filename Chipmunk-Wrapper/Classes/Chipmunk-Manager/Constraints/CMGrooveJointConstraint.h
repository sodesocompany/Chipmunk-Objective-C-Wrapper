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
 * Groove joints hold a pivot point on one body to line along a line segment on another like a pin in a groove. 
 */
@interface CMGrooveJointConstraint : CMConstraint {

}

/**
 * Constructs a new groove joint constraint.
 *
 * @param cmBody The first body.
 * @param andCmBody The second body.
 * @param grooveA The start of the line segment on the first body. 
 * @param grooveB The end of the line segment on the first body. 
 * @param anchor1 The anchor point on the second body that is held to the line segment on the first. 
  */
- (id) initBetweenBody:(CMBody*)cmBody andBody:(CMBody*)andCmBody grooveA:(cpVect)grooveA grooveB:(cpVect)grooveB anchor1:(cpVect)anchor1;

@end
