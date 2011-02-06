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

/**
 * Constructs a new drawspace area which will display
 * the information that the space knows to the screen
 * as a form of debugging.
 *
 * @param space the CMSpace
 */
- (id)initWithManager:(CMSpace*)space;

@end
