//
//  CMDefaultLoader.h
//  ChipmunkWrapper
//
//  Created by Ronald Mathies on 2/6/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMSpace;

/**
 * The CMLoader class can be used to load complete definitions of bodies and shapes with
 * their constraints into the space. It can be done individual (single body at a time) or
 * multimple at the same time.
 */
@interface CMDefaultLoader : NSObject {
	
}

///---------------------------------------------------------------------------------------
/// @name Operations
///---------------------------------------------------------------------------------------

/**
 * Loads the configuration from the specified .plist and add's it to the
 * space.
 *
 * @param listerer listener that recieves events about bodies and shapes.
 * @param cmSpace the space.
 * @param configuration the name of the .plist wile (without the extension)
 */
+ (void)loadFromConfiguration:(id)listener cmSpace:(CMSpace*)cmSpace configuration:(NSString *)configuration;

@end
