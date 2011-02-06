//
//  PhysicsEditorLoader.h
//  ChipmunkWrapper
//
//  Created by Ronald Mathies on 2/6/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMSpace;

@interface CMLoader : NSObject {

}

/**
 * Loads the configuration from the specified .plist and add's it to the
 * space.
 *
 * @param cmSpace the space.
 * @param configuration the name of the .plist wile (without the extension)
 */
+ (void)loadFromConfiguration:(CMSpace*)cmSpace configuration:(NSString *)configuration;

@end
