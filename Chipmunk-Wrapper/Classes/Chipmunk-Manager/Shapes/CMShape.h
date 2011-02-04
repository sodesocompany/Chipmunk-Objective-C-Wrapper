//
//  CPShape.h
//  Chipmunk
//
//  Created by Ronald Mathies on 12/29/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMBody;

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

/**
 * Base shape class which is used by all the shapes.
 */
@interface CMShape : CMObject {

@protected
	cpShape *mCpShape;
	BOOL mStatic;
}

@property (nonatomic, readonly) cpShape *cpShape;

#pragma mark Properties

/**
 * Elasticity of the shape. A value of 0.0 gives no bounce, while a value of 1.0 will give a “perfect” bounce. 
 * However due to inaccuracies in the simulation using 1.0 or greater is not recommended however.
 *
  * @param elasticity a value between 0.0 and (adviced) 1.0
 */
- (void)setElasticity:(float)elasticity;

/**
 * Friction coefficient. Chipmunk uses the Coulomb friction model, a value of 0.0 is frictionless.
 *
 * For a listing of various frictions see:
 * http://www.roymech.co.uk/Useful_Tables/Tribology/co_of_frict.htm
 *
  * @param friction a value 0f 0.0 is frictionless
 */
- (void)setFriction:(float)friction;

/**
 * A user defined collision type which can be used to identify a type
 * of object on screen. (is used by the collision detection)
 *
 * For example, if a have a ball and a block on the screen i could identify
 * the ball as type 1 and the block as type 2.
 *
 * @param type the type
 */
- (void)setCollisionType:(cpCollisionType)type;

/**
 * Returns the user defined collision type.
 *
 * @return the user defined collision type.
 */
- (cpCollisionType)collisionType;

/**
 * Shapes in the same non-zero group do not generate collisions. 
 * Useful when creating an object out of many shapes that you 
 * donÕt want to self collide. Defaults to CP_NO_GROUP.
 *
 * @param group the group
 */
- (void)setGroup:(cpGroup)group;

/**
 * Shapes only collide if they are in the same bit-planes. 
 * i.e. (a->layers & b->layers) != 0 By default, a shape 
 * occupies all bit-planes. 
 *
 * Wikipedia has a nice article on bitmasks if you are
 * unfamiliar with how to use them. Defaults to CP_ALL_LAYERS.
 *
 * http://en.wikipedia.org/wiki/Mask_(computing)#top
 *
 * @param layer the layer
 */
- (void)setLayer:(cpLayers)layer;

#pragma mark -

#pragma mark Data

/**
 * Associates an object with this shape, it is not used by Chipmunk but can be used
 * to create a binding between an Sparrow object and a cpShape.
 *
 * @param data an object to associate
 */
- (void)setData:(id)data;

/**
 * Returns the associated object with this body.
 *
 * @return the associated object with this body.
 */
- (id)getData;

#pragma mark -

#pragma mark Operations

/**
 * Returns the body associated with this shape.
 *
 * @return the body associated with this shape.
 */
- (CMBody*) getBody;

/**
 * Add this shape to the Chipmunk space.
 */
- (void) addToSpace;

/**
 * Add this body to the Chipmunk space as a static object.
 */
- (void) addToSpaceAsStatic;

/**
 * Remove this shape from the Chipmunk space. (it will determine by itself if the Shape is static or not)
 */
- (void) removeFromSpace;

#pragma mark -

@end
