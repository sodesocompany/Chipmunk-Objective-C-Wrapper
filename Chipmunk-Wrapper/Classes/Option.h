//
//  Option.h
//  ChipmunkWrapper
//
//  Created by Ronald Mathies on 2/18/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

@interface Option : NSObject {

@private
	NSString *mIdentifier;
	NSString *mImage;
	
}

@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSString *image;

- (id)initWithImage:(NSString*)image identifier:(NSString*)identifier;

+ (Option*)createWithImage:(NSString*)image identifier:(NSString*)identifier;

@end
