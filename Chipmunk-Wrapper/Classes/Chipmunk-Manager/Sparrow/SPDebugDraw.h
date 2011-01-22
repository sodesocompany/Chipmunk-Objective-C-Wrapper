//
//  SPDebugDraw.h
//  Chipmunk
//
//  Created by Ronald Mathies on 1/4/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "drawSpace.h"

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

/**
 * A display object that when added to the stage allows you to see
 * the graphical represenstation of what Chipmunk knows.
 */
@interface SPDebugDraw : SPDisplayObject {

@private
	CMSpace *mSpace;
	
}

- (id)initWithManager:(CMSpace*)space;

@end
