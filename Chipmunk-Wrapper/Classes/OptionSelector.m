//
//  OptionSelector.m
//  ChipmunkWrapper
//
//  Created by Ronald Mathies on 2/18/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "OptionSelector.h"


// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface OptionSelector ()

- (void)showPage;
- (void)switchPage;
- (void)showNavigation;
- (void)createOption:(Option*)option x:(float)x y:(float)y;
- (SPSprite*)findTouchedOption:(SPTouchEvent*)event;

@end

// --- class implementation ------------------------------------------------------------------------

@implementation OptionSelector

@synthesize delegate = mDelegate;

- (id)initWithOptions:(NSArray*)options {
    if (self = [super init]) {
		mPage = 0;
		mOptions = [options retain];
		mJuggler = [[SPJuggler alloc] init];
		
		mSwitchPageDirection = YES;
		[self showNavigation];
		[self showPage];
		[self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
    }
    return self;
}

- (void)showNavigation {
	mLeftArrow = [[SPImage imageWithContentsOfFile:@"left_arrow.png"] retain];
	[mLeftArrow addEventListener:@selector(previousPage:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
	[mLeftArrow setX:17];
	[mLeftArrow setY:480 + 100];
	[self addChild:mLeftArrow];
	
	mRightArrow = [[SPImage imageWithContentsOfFile:@"right_arrow.png"] retain];
	[mRightArrow addEventListener:@selector(nextPage:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
	[mRightArrow setX:219];
	[mRightArrow setY:480 + 100];
	[self addChild:mRightArrow];
	
	SPTween *tween = [SPTween tweenWithTarget:mLeftArrow time:1.0f transition:SP_TRANSITION_EASE_OUT];
	[tween animateProperty:@"y" targetValue:410];
	[mJuggler addObject:tween];
	
	tween = [SPTween tweenWithTarget:mRightArrow time:1.0f transition:SP_TRANSITION_EASE_OUT];
	[tween animateProperty:@"y" targetValue:410];
	[mJuggler addObject:tween];
}

- (void)onEnterFrame:(SPEnterFrameEvent *)event {
	[mJuggler advanceTime:event.passedTime];	
}

- (void)showPage {
	int col = 0, row = 0;
	for (int optionIndex = mPage * 9; optionIndex < [mOptions count] && optionIndex < mPage * 9 + 9; optionIndex++) {
		Option *option = [mOptions objectAtIndex:optionIndex];
		
		float x = 17 + (col * 101);
		float y = 10 + (row * 130);
		
		[self createOption:option x:x y:y];
		
		if (++col == 3) {
			row++;
			col = 0;
		}
	}
	
}

- (void)switchPage {
	SPTween *tween = nil;
	for (int index = 2; index < [self numChildren]; index++) {
		SPSprite *sprite = (SPSprite*)[self childAtIndex:index];
		tween = [SPTween tweenWithTarget:sprite time:0.5f transition:SP_TRANSITION_EASE_IN];
		[tween animateProperty:@"x" targetValue:mSwitchPageDirection ? 360 : -100];
		[mJuggler addObject:tween];
	}
	
	[tween addEventListener:@selector(onFinishedRemovingLastOption:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
}

- (void)onFinishedRemovingLastOption:(SPEvent*)event {
	for (int index = 2; index < [self numChildren]; index++) {
		[self removeChildAtIndex:index];
	}
	
	[self showPage];
}


- (void)createOption:(Option*)option x:(float)x y:(float)y {
	SPImage *optionImage = [SPImage imageWithContentsOfFile:@"option.png"];

	SPSprite *optionSprite = [[[SPSprite alloc] init] autorelease];
	[optionSprite addEventListener:@selector(selectedOption:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
	[optionSprite setName:[option identifier]];
	
	int startPosition = !mSwitchPageDirection ? 360 : x * -1 - 101;
	
	[optionSprite setX:startPosition];
	[optionSprite setY:y];
	
	if ([option image] != nil) {
		SPImage *iconImage = [SPImage imageWithContentsOfFile:[option image]];
		[optionSprite addChild:iconImage];
	}
	
	
	[optionSprite addChild:optionImage];
	[self addChild:optionSprite];
	
	SPTween *tween = [SPTween tweenWithTarget:optionSprite time:0.5f transition:SP_TRANSITION_EASE_OUT];
	[tween animateProperty:@"x" targetValue:x];
	[mJuggler addObject:tween];
}

- (SPSprite*)findTouchedOption:(SPTouchEvent*)event {
	for (int index = 0; index < [self numChildren]; index++) {
		SPSprite *sprite = (SPSprite*)[self childAtIndex:index];
		SPTouch *touch = [[event touchesWithTarget:sprite andPhase:SPTouchPhaseBegan] anyObject];
		if (touch) {
			return sprite;
		}
	}
	
	return nil;
}

- (void)previousPage:(SPTouchEvent*)event {
	SPTouch *touch = [[event touchesWithTarget:mLeftArrow andPhase:SPTouchPhaseBegan] anyObject];
	if (touch) {
		mPage--;
	
		if (mPage < 0) {
			mPage = floor([mOptions count] / 9);
		}
	
		mSwitchPageDirection = YES;
		[self switchPage];
	}
}

- (void)nextPage:(SPTouchEvent*)event {
	SPTouch *touch = [[event touchesWithTarget:mRightArrow andPhase:SPTouchPhaseBegan] anyObject];
	if (touch) {
		mPage++;
	
		if (mPage * 9 >= [mOptions count]) {
			mPage = 0;
		}
	
		mSwitchPageDirection = NO;
		[self switchPage];
	}
}

- (void)selectedOption:(SPTouchEvent*)event {
	SPSprite *touchedSprite = [self findTouchedOption:event];
	if (touchedSprite) {
		
		mSelectedOption = [touchedSprite name];
		
		for (int index = 2; index < [self numChildren]; index++) {
			SPSprite *sprite = (SPSprite*)[self childAtIndex:index];
			if (![[touchedSprite name] isEqualToString:[sprite name]]) {
				SPTween *tween = [SPTween tweenWithTarget:sprite time:1.0f transition:SP_TRANSITION_EASE_OUT];
				[tween animateProperty:@"alpha" targetValue:0];
				[mJuggler addObject:tween];
			}
		}

		SPTween *tween = [SPTween tweenWithTarget:mLeftArrow time:1.0f transition:SP_TRANSITION_EASE_OUT];
		[tween animateProperty:@"alpha" targetValue:0];
		[mJuggler addObject:tween];

		tween = [SPTween tweenWithTarget:mRightArrow time:1.0f transition:SP_TRANSITION_EASE_OUT];
		[tween animateProperty:@"alpha" targetValue:0];
		[mJuggler addObject:tween];
		
		
		tween = [SPTween tweenWithTarget:touchedSprite time:1.0f transition:SP_TRANSITION_EASE_OUT];
		[tween addEventListener:@selector(onHideOtherOptionsComplete:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
		[tween animateProperty:@"x" targetValue:0];
		[tween animateProperty:@"y" targetValue:0];
		[tween animateProperty:@"width" targetValue:320];
		[tween animateProperty:@"height" targetValue:480];
		[tween animateProperty:@"alpha" targetValue:0];
		[tween setDelay:0.5f];
		[mJuggler addObject:tween];
		
	}
}

- (void)onHideOtherOptionsComplete:(SPEvent*)event {
	[mDelegate selectedOption:mSelectedOption];
}

- (void)dealloc {
	[mOptions release];
	[mJuggler release];
	[mLeftArrow release];
	[mRightArrow release];
	[mDelegate release];
	
    [super dealloc];
}

@end

