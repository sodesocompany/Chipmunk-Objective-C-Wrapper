//
//  OptionSelector.h
//  ChipmunkWrapper
//
//  Created by Ronald Mathies on 2/18/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Option.h"

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

@interface OptionSelector : SPSprite {

@private
	int mPage;
	NSArray *mOptions;
	
	SPJuggler *mJuggler;
	
	SPImage *mLeftArrow;
	SPImage *mRightArrow;
	
	id mDelegate;
	NSString *mSelectedOption;
	
	BOOL mSwitchPageDirection;
}

@property (nonatomic, retain) id delegate;

- (id)initWithOptions:(NSArray*)options;

@end

@protocol SelectedOptionProtocol

- (void)selectedOption:(NSString*)identifier;

@end