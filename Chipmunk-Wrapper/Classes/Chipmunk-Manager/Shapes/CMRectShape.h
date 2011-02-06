//
//  CMRect.h
//  Chipmunk
//
//  Created by Ronald Mathies on 1/2/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMBody;
@class CMShape;

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

/**
 * A convenient shape, it is in basic a poly shape but the calculation of the various
 * polygons is done for you.
 */
@interface CMRectShape : CMShape {
}

///---------------------------------------------------------------------------------------
/// @name Initialization
///---------------------------------------------------------------------------------------

/**
 * Constructs a new CMRect object with the specified width and height.
 *
 * @param cmBody the body to wich this shape is associated.
 * @param width the width of the rectangle (full-width, not half-width).
 * @param height the height of the rectangle (full-height, not half-height).
 */
- (id) initWithBody:(CMBody*)cmBody width:(float)width height:(float)height;

/**
 * Constructs a new CMRect object with the specified width and height.
 *
 * @param cmBody the body to wich this shape is associated.
 * @param width the width of the rectangle (full-width, not half-width).
 * @param height the height of the rectangle (full-height, not half-height).
 * @param offset the offset of the shape in relation to the body.
 */
- (id) initWithBody:(CMBody*)cmBody width:(float)width height:(float)height offset:(cpVect)offset;

@end
