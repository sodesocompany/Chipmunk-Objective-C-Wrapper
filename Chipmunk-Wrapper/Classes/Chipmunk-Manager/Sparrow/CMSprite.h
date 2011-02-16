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

@property (nonatomic, assign) CMBody *cmBody;

- (id)initAndAttachToExistingBody:(CMSpace *)cmSpace name:(NSString*)name;
- (id)initWithConfiguration:(CMSpace *)cmSpace configuration:(NSString*)configuration;

@end
