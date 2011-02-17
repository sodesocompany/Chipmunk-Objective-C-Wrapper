//
//  CMQueryFunctionHandler.h
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
@interface CMQueryFunctionHandler : NSObject {

@private
	NSInvocation *mQueryFunction;
	id mData;

}

/**
 * The post callback invocation method.
 */
@property (nonatomic, retain) NSInvocation *queryFunction;

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
 * @param target the target to call the selector on
 * @param selector the selector
 */
- (id)initWithTarget:(id)target selector:(SEL)selector;

///---------------------------------------------------------------------------------------
/// @name Properties
///---------------------------------------------------------------------------------------


@end
