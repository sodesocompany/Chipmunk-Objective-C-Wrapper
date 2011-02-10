//
//  CMLoaderListenerProtocol.h
//  ChipmunkWrapper
//
//  Created by Ronald Mathies on 2/9/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMBody;
@class CMShape;
@class CMConstraint;

/**
 * This protocol can be added to an object so it will receive callbacks about when
 * a body, shape or constraint has been constructed and when it has been added
 * to the space.
 * 
 * This allows you to make modifications to the objects or attach
 * a Sparrow object to the body so it runs in the updates for the positions
 * and angles.
 */
@protocol CMLoaderListenerProtocol

@optional

/**
 * Callback when a body has been created but not yet added to the space.
 *
 * @param cmBody the body
 */
- (void)bodyBeforeAddToSpace:(CMBody*)cmBody;

/**
 * Callback when a body has been created and has been added to the space.
 *
 * @param cmBody the body
 */
- (void)bodyAfterAddToSpace:(CMBody*)cmBody;

/**
 * Callback when a shape has been created and has been attached to the body 
 * but not yet added to the space.
 *
 * @param cmShape the shape
 */
- (void)shapeBeforeAddToSpace:(CMShape*)cmShape;

/**
 * Callback when a shape has been created and has been attached to the body 
 * and has been added to the space.
 *
 * @param cmShape the shape
 */
- (void)shapeAfterAddToSpace:(CMShape*)cmShape;

/**
 * Callback when a constraint has been created and has been attached to both the bodies
 * but not yet added to the space.
 *
 * @param cmConstraint the constraint
 */
- (void)constraintBeforeAddToSpace:(CMConstraint*)cmConstraint;

/**
 * Callback when a constraint has been created and has been attached to both the bodies
 * and has been added to the space.
 *
 * @param cmConstraint the constraint
 */
- (void)constraintAfterAddToSpace:(CMConstraint*)cmConstraint;


@end
