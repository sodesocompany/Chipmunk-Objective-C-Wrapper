//
//  CMBlastEffect.h
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
@interface CMBlastEffect : NSObject {

}

///---------------------------------------------------------------------------------------
/// @name Operators
///---------------------------------------------------------------------------------------

/**
 * Generates an implosion effect.
 *
 * @param cmSpace the space.
 * @param position the origin of the explotion
 * @param radius the area affected (all shapes that are completely present within the area are affected
 * @param force the amounth of force the implotion has.
 */
- (void)implosion:(CMSpace*)cmSpace position:(cpVect)position radius:(float)radius force:(float)force;

/**
 * Generates an implosion effect.
 *
 * @param cmSpace the space.
 * @param position the origin of the explotion
 * @param radius the area affected (all shapes that are completely present within the area are affected
 * @param force the amounth of force the implotion has.
 * @param layer the layer
 * @param group the group
 */
- (void)implosion:(CMSpace*)cmSpace position:(cpVect)position radius:(float)radius force:(float)force layer:(cpLayers)layer group:(cpGroup)group;

/**
 * Generates an explosion effect.
 *
 * @param cmSpace the space.
 * @param position the origin of the explotion
 * @param radius the area affected (all shapes that are completely present within the area are affected
 * @param force the amounth of force the explosion has.
 */
- (void)explosion:(CMSpace*)cmSpace position:(cpVect)position radius:(float)radius force:(float)force;

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
- (void)explosion:(CMSpace*)cmSpace position:(cpVect)position radius:(float)radius force:(float)force layer:(cpLayers)layer group:(cpGroup)group;

@end

@interface CMBlastEffectData : NSObject {
	
@private
	BOOL mExplosion;
	
	float mRadius;
	float mForce;
	
	cpVect mPosition;
	cpLayers mLayer;
	cpGroup mGroup;
	
}

@property (nonatomic, readwrite) BOOL explosion;
@property (nonatomic, readwrite) float radius;
@property (nonatomic, readwrite) float force;
@property (nonatomic, readwrite) cpVect position;
@property (nonatomic, readwrite) cpLayers layer;
@property (nonatomic, readwrite) cpGroup group;

@end
