//
//  CMPoly.h
//  Chipmunk
//
//  Created by Ronald Mathies on 1/3/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMBody;
@class CMShape;

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

/**
 * A poly shape is a shape that consists of a number of vertices that make up the object.
 * Please note to specify the vertices in a clock-wise maner.
 */
@interface CMPolyShape : CMShape {
}

///---------------------------------------------------------------------------------------
/// @name Initialization
///---------------------------------------------------------------------------------------

/**
 * Constructs a new poly shape with the specified vertices. The
 * NSArray must be filled with string with the following formatting:
 * {x,y} (including the brackets)
 *
 * @param cmBody the body to wich this shape is associated.
 * @param vertices an array containing the vertices.
 */
- (id) initWithBody:(CMBody *)cmBody vertices:(NSArray*)vertices;

/**
 * Constructs a new poly shape with the specified vertices.
 *
 * @param cmBody the body to wich this shape is associated.
 * @param numberOfVertices the number of points this poly consists of.
 * @param offset the offset of the shape in relation to the body.
 * @param vertices the coordinates of the vertices
 * @param ... the rest of the vertices
 */
- (id) initWithBody:(CMBody*)cmBody numberOfVertices:(int)numberOfVertices offset:(cpVect)offset vertices:(cpVect)vertices,...;

/**
 * Constructs a new poly shape with the specified vertices.
 *
 * @param cmBody the body to wich this shape is associated.
 * @param numberOfVertices the number of points this poly consists of.
 * @param vertices the coordinates of the vertices
 * @param ... the rest of the vertices.
 */
- (id) initWithBody:(CMBody*)cmBody numberOfVertices:(int)numberOfVertices vertices:(cpVect)vertices,...;

/**
 * Constructs a new poly shape with the specified vertices.
 *
 * @param cmBody the body to wich this shape is associated.
 * @param numberOfVertices the number of points this poly consists of.
 * @param firstVertice the first coordinate of the vertice
 * @param vaVerticesList a va_list containing the rest of the coordinates of the vertices
 */
- (id) initWithBody:(CMBody *)cmBody numberOfVertices:(int)numberOfVertices firstVertice:(cpVect)firstVertice withParameters:(va_list)vaVerticesList;

/**
 * Constructs a new poly shape with the specified vertices.
 *
 * @param cmBody the body to wich this shape is associated.
 * @param numberOfVertices the number of points this poly consists of.
 * @paran offset the offset of the shapoe in relation to the body.
 * @param firstVertice the first coordinate of the vertice
 * @param vaVerticesList a va_list containing the rest of the coordinates of the vertices
 */
- (id) initWithBody:(CMBody *)cmBody numberOfVertices:(int)numberOfVertices offset:(cpVect)offset firstVertice:(cpVect)firstVertice withParameters:(va_list)vaVerticesList;


@end
