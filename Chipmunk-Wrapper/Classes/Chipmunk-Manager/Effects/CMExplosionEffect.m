//
//  CMExplosionEffect.m
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

#import "CMExplosionEffect.h"

// --- Static variables ----------------------------------------------------------------------------

typedef struct ExplosionEffectContext {
	cpVect position;
	float radius;
	float force;
	
	cpLayers layer;
	cpGroup group;
	
} ExplosionEffectContext;

// --- Static inline methods -----------------------------------------------------------------------

static void explosionQueryFunction(cpBB *boundingBox, cpShape *shape, ExplosionEffectContext *context) {

	// Check if the bounding box of the shape falls in the bounding box of the explosion.
	BOOL isBoundingBoxOfShapeWithinBoundingBoxOfExplosion = cpBBintersects(*boundingBox, shape->bb);
	
	// Shapes only collide if they are in the same bit-planes. i.e. (a->layers & b->layers) != 0 
	// By default, a shape occupies all bit-planes. Wikipedia has a nice article on bitmasks if 
	// you are unfamiliar with how to use them. Defaults to CP_ALL_LAYERS.
	BOOL isShapeInLayerBitPlane = (context->layer & shape->layers) != 0;
	
	if (!(shape->group && context->group == shape->group) && 
		isShapeInLayerBitPlane &&
		isBoundingBoxOfShapeWithinBoundingBoxOfExplosion) {
		
		cpVect dxdy = cpvsub(shape->body->p, context->position);
		float distsq = cpvlengthsq(dxdy);
		
		// [Factor] = [Distance]/[Explosion Radius] 
		// [Force] = (1.0 - [Factor]) * [Total Force]
		// Apply -> [Direction] * [Force]
		if (distsq <= context->radius*context->radius) {
			
			//Distance
			float dist = cpfsqrt(distsq);
			
			//normalize for direction
			dxdy = cpvmult(dxdy, 1.0f/dist);
			cpBodyApplyImpulse(shape->body, cpvmult(dxdy, context->force*(1.0f - (dist/context->radius))), cpvzero);
		}
	}
}

// --- private interface ---------------------------------------------------------------------------

@interface CMExplosionEffect ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMExplosionEffect

+ (void)perform:(CMSpace*)cmSpace position:(cpVect)position radius:(float)radius force:(float)force {
	[self perform:cmSpace position:position radius:radius force:force layer:CP_ALL_LAYERS group:CP_NO_GROUP];
}

+ (void)perform:(CMSpace*)cmSpace position:(cpVect)position radius:(float)radius force:(float)force layer:(cpLayers)layer group:(cpGroup)group {
	cpBB boundingBox = {
		position.x - radius, position.y - radius, position.x + radius, position.y + radius
	};
	
	ExplosionEffectContext context = {
		position, radius, force, layer, group
	};
	
	cpSpaceHashQuery([cmSpace cpSpace]->activeShapes, &boundingBox, boundingBox, (cpSpaceHashQueryFunc)explosionQueryFunction, &context);
}

@end
