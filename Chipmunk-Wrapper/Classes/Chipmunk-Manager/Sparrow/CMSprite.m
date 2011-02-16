//
//  CMSprite.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/4/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMSprite.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

// --- Class implementation ------------------------------------------------------------------------

@implementation CMSprite

@synthesize cmBody = mCmBody;

- (id)initAndAttachToExistingBody:(CMSpace *)cmSpace name:(NSString*)name {
	if (self = [super init]) {
		mCmBody = [cmSpace findBody:name];
		if (mCmBody == nil) {
			[NSException raise:@"Body not found." format:@"Body with name '%@' not found in the space.", name];
		}
		
		[mCmBody setData:self];
	}
	
	return self;
}

- (id)initWithConfiguration:(CMSpace *)cmSpace configuration:(NSString*)configuration {
	if (self = [super init]) {
		[CMDefaultLoader loadFromConfiguration:self cmSpace:cmSpace configuration:configuration];
	}
	
	return self;
}

- (void)bodyBeforeAddToSpace:(CMBody*)cmBody {
	if (mCmBody != nil) {
		[NSException raise:@"A CMSprite can only be attached to a single body." format:@"CMSprite currently attached to '%@'", [mCmBody name]];
	}
	
	mCmBody = cmBody;
	[mCmBody setData:self];
}

@end
