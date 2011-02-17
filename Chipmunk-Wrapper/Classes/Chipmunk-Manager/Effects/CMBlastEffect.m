//
//  CMImplosionEffect.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

/*
 This class is partially based on the code provided by Mobile Bros.
 Some parts have been modified for readability or for more effective
 usage within this project.
 
 Copyright (c) 2009 Mobile Bros. 
 contact@mobile-bros.com

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
  
*/

#import "CMBlastEffect.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMBlastEffect ()

/**
 * Performs the blast.
 *
 * @param cmSpace the space.
 * @param position the origin of the explotion
 * @param radius the area affected (all shapes that are completely present within the area are affected
 * @param force the amounth of force the implotion has.
 * @param layer the layer
 * @param group the group
 * @param explosion YES if it is an explosion, NO when it is an implosion
 */
- (void)perform:(CMSpace*)cmSpace position:(cpVect)position radius:(float)radius force:(float)force layer:(cpLayers)layer group:(cpGroup)group explosion:(BOOL)explosion;

/**
 * Performs the implosion / explosion callback method.
 *
 * @param boundingBox the bounding box.
 * @param cmShape the shape that is being handled.
 * @param data the data that is passed along, in this case the CMBlastEffectData
 */
- (void)performImpExplosion:(cpBB*)boundingBox cmShape:(CMShape*)cmShape data:(id)data;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMBlastEffect

- (void)implosion:(CMSpace*)cmSpace position:(cpVect)position radius:(float)radius force:(float)force {
	[self perform:cmSpace position:position radius:radius force:force layer:CP_ALL_LAYERS group:CP_NO_GROUP explosion:NO];
}

- (void)implosion:(CMSpace*)cmSpace position:(cpVect)position radius:(float)radius force:(float)force layer:(cpLayers)layer group:(cpGroup)group {
	[self perform:cmSpace position:position radius:radius force:force layer:layer group:group explosion:NO];
}

- (void)explosion:(CMSpace*)cmSpace position:(cpVect)position radius:(float)radius force:(float)force {
	[self perform:cmSpace position:position radius:radius force:force layer:CP_ALL_LAYERS group:CP_NO_GROUP explosion:YES];
}

- (void)explosion:(CMSpace*)cmSpace position:(cpVect)position radius:(float)radius force:(float)force layer:(cpLayers)layer group:(cpGroup)group {
	[self perform:cmSpace position:position radius:radius force:force layer:layer group:group explosion:YES];
}

- (void)perform:(CMSpace*)cmSpace position:(cpVect)position radius:(float)radius force:(float)force layer:(cpLayers)layer group:(cpGroup)group explosion:(BOOL)explosion {
	cpBB boundingBox = {
		position.x - radius, position.y - radius, position.x + radius, position.y + radius
	};
	
	CMBlastEffectData *effectData = [[CMBlastEffectData alloc] init];
	effectData.explosion = explosion;
	effectData.position = position;
	effectData.radius = radius;
	effectData.force = force;
	effectData.layer = layer;
	effectData.group = group;

	[cmSpace forEachShape:self selector:@selector(performImpExplosion:cmShape:data:) boundingBox:boundingBox data:effectData];
}
	 
- (void)performImpExplosion:(cpBB*)boundingBox cmShape:(CMShape*)cmShape data:(id)data {
	CMBlastEffectData *effectData = (CMBlastEffectData *)data;
	
	// Check if the bounding box of the shape falls in the bounding box of the explosion.
	BOOL isBoundingBoxOfShapeWithinBoundingBoxOfExplosion = cpBBintersects(*boundingBox, [cmShape boundingBox]);
	
	// Shapes only collide if they are in the same bit-planes. i.e. (a->layers & b->layers) != 0 
	// By default, a shape occupies all bit-planes. Wikipedia has a nice article on bitmasks if 
	// you are unfamiliar with how to use them. Defaults to CP_ALL_LAYERS.
	BOOL isShapeInLayerBitPlane = ([effectData layer] & [cmShape layer]) != 0;
	
	if (!([cmShape group] && [effectData group] == [cmShape group]) && 
		isShapeInLayerBitPlane &&
		isBoundingBoxOfShapeWithinBoundingBoxOfExplosion) {
		
		cpVect dxdy = cpvsub([[cmShape body] position], [effectData position]);
		float distsq = cpvlengthsq(dxdy);
		
			// [Factor] = [Distance]/[Explosion Radius] 
			// [Force] = (1.0 - [Factor]) * [Total Force]
			// Apply -> -1 * [Direction] * [Force]
		if (distsq <= [effectData radius]*[effectData radius]) {
			
				//Distance
			float dist = cpfsqrt(distsq);
			
				//normalize for direction
			dxdy = cpvmult(dxdy, 1.0f/dist);
			
			cpBodyApplyImpulse([[cmShape body] cpBody], cpvmult(dxdy, ([effectData explosion] ? 1 : -1) * ([effectData force]*(1.0f - (dist / [effectData radius])))), cpvzero);
		}
	}	
}

@end

@implementation CMBlastEffectData

@synthesize explosion = mExplosion;
@synthesize radius = mRadius;
@synthesize force = mForce;
@synthesize position = mPosition;
@synthesize layer = mLayer;
@synthesize group = mGroup;

@end
