//
//  Game.h
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright Sodeso 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "BaseDemo.h"

#include "OptionSelector.h"
#include "Option.h"

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

@interface Game : SPStage <SelectedOptionProtocol, DemoProtocol> {

@private 
	NSArray *mOptions;
	OptionSelector *mOptionSelector;

	NSString *mSelectedOption;
	BaseDemo *mDemo;
}

@end
