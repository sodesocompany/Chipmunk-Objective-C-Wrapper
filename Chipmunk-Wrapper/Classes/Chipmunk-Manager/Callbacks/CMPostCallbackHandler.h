//
//  CMPostCallbackHandler.h
//  Chipmunk
//
//  Created by Ronald Mathies on 1/7/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

/**
 * Class containing the method and data that needs to be invoked
 * after the postStepCallback has executed.
 */
@interface CMPostCallbackHandler : NSObject {

@private
	NSInvocation *mPostCallback;
	id mData;

}

/**
 * The post callback invocation method.
 */
@property (nonatomic, retain) NSInvocation *postCallback;

/**
 * The data that will be passed along to the selector.
 */
@property (nonatomic, retain) id data;

///---------------------------------------------------------------------------------------
/// @name Initialization
///---------------------------------------------------------------------------------------

/**
 * Default initialization method.
 *
 * @param target the target to invoke.
 * @param selector the selector to invoke.
 */
- (id)initWithTarget:(id)target selector:(SEL)selector;

///---------------------------------------------------------------------------------------
/// @name Properties
///---------------------------------------------------------------------------------------


@end
