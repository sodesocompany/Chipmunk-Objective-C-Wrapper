//
//  CMSprite.h
//  Chipmunk
//
//  Created by Ronald Mathies on 1/4/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "SPSprite.h"

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

/**
 * SPPoint category class, adding some convenience methods for Chipmunk
 */
@interface CMSprite : SPSprite <CMLoaderListenerProtocol> {

@private
	CMBody *mCmBody;
	
}

/**
 * The body associated with this shape.
 */
@property (nonatomic, assign) CMBody *cmBody;

/**
 * Initialize the sprite and directly load a body from the configuration.
 *
 * @param cmSpace the space that will be used to load the body into.
 * @param name the name of the body to which this sprite will be attached.
 */
- (id)initAndAttachToExistingBody:(CMSpace *)cmSpace name:(NSString*)name;

/**
 * Initialize the sprite and directly load a body from the configuration.
 *
 * @param cmSpace the space that will be used to load the body into.
 * @param configuration the name of the plist configuration file.
 */
- (id)initWithConfiguration:(CMSpace *)cmSpace configuration:(NSString*)configuration;

@end
