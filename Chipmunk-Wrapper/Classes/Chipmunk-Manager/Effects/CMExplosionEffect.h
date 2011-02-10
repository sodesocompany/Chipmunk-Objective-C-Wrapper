//
//  CMExplosionEffect.h
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

/**
 * The explosion effect can be used to force a group of bodies to
 * act like an explosion event took place.
 */
@interface CMExplosionEffect : NSObject {

}

///---------------------------------------------------------------------------------------
/// @name Operators
///---------------------------------------------------------------------------------------

/**
 * Generates an explosion effect.
 *
 * @param cmSpace the space.
 * @param position the origin of the explotion
 * @param radius the area affected (all shapes that are completely present within the area are affected
 * @param force the amounth of force the explosion has.
 */
+ (void)perform:(CMSpace*)cmSpace position:(cpVect)position radius:(float)radius force:(float)force;

/**
 * Generates an explosion effect.
 *
 * @param cmSpace the space.
 * @param position the origin of the explotion
 * @param radius the area affected (all shapes that are completely present within the area are affected
 * @param force the amounth of force the explosion has.
 * @param layer the layer
 * @param group the group
 */
+ (void)perform:(CMSpace*)cmSpace position:(cpVect)position radius:(float)radius force:(float)force layer:(cpLayers)layer group:(cpGroup)group;

@end
