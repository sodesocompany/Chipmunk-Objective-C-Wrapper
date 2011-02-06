//
//  CMSegmentShape.h
//  Chipmunk
//
//  Created by Ronald Mathies on 1/8/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMBody;
@class CMShape;

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

/**
 * A segment shape consists of two points and a radius for the rounded corners.
 */
@interface CMSegmentShape : CMShape {

}

///---------------------------------------------------------------------------------------
/// @name Initialization
///---------------------------------------------------------------------------------------

/**
 * Constructs a new segment shape.
 *
 * @param cmBody the body to wich this shape is associated.
 * @param from the starting point of the segment.
 * @param to the ending point of the segment.
 * @param radius the radius of the segment.
 */
- (id) initWithBody:(CMBody*)cmBody from:(cpVect)from to:(cpVect)to radius:(float)radius;

@end
