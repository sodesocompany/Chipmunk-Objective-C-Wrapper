//
//  CMCircle.h
//  Chipmunk
//
//  Created by Ronald Mathies on 12/31/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMBody;
@class CMShape;

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

/**
 * A circle shape.
 */
@interface CMCircleShape : CMShape {
}

///---------------------------------------------------------------------------------------
/// @name Initialization
///---------------------------------------------------------------------------------------

/**
 * Constructs a new CMCircle object with the radius
 *
 * @param cmBody the body to wich this shape is associated.
 * @param radius the radius of the circle
 */
- (id) initWithBody:(CMBody*)cmBody radius:(float)radius;

/**
 * Constructs a new CMCircle object with the radius
 *
 * @param cmBody the body to wich this shape is associated.
 * @param radius the radius of the circle
 * @param offset the offset of the shape in relation to the body.
 */
- (id) initWithBody:(CMBody*)cmBody radius:(float)radius offset:(cpVect)offset;

@end
