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

+ (void)loadFromConfiguration:(CMSpace*)cmSpace configuration:(NSString *)configuration;

@end
