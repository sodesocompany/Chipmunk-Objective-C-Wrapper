//
//  Option.m
//  ChipmunkWrapper
//
//  Created by Ronald Mathies on 2/18/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "Option.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface Option ()

@end

// --- class implementation ------------------------------------------------------------------------

@implementation Option

@synthesize identifier = mIdentifier;
@synthesize image = mImage;

- (id)initWithImage:(NSString*)image identifier:(NSString*)identifier {
	if (self = [super init]) {
		[self setImage:image];
		[self setIdentifier:identifier];
	}
	
	return self;
}

+ (Option*)createWithImage:(NSString*)image identifier:(NSString*)identifier {
	Option *option = [[[Option alloc] initWithImage:image identifier:identifier] autorelease];
	return option;
}

@end
