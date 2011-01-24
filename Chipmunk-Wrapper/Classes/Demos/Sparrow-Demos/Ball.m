//
//  Ball.m
//  ChipmunkWrapper
//
//  Created by Ronald Mathies on 1/23/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "Ball.h"


// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface Ball ()

- (void)setupSprite;

@end

// --- class implementation ------------------------------------------------------------------------

@implementation Ball

- (id)init {
    if (self = [super init]) {
        [self setupSprite];        
    }
    return self;
}

- (void)setupSprite {
	SPImage *ballImage = [SPImage imageWithContentsOfFile:@"football.png"];
	[ballImage setX:-[ballImage width] / 2.0f];
	[ballImage setY:-[ballImage height] / 2.0f];
	[self addChild:ballImage];
}

- (void)dealloc {
    [super dealloc];
}

@end

