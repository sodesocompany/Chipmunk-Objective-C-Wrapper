//
//  CMInvocationUtils.h
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

/**
 * Utility class for creating NSINvocation objects.
 */
@interface CMInvocationUtils : NSObject {

}

///---------------------------------------------------------------------------------------
/// @name Construction
///---------------------------------------------------------------------------------------

/**
 * Constructs a new NSInvocation with the specified target and selector.
 *
 * @param target the target to invoke.
 * @param selector the selector to invoke.
 *
 * @return the NSInvocation or nil when one of the parameters is not correct.
 */
+ (NSInvocation*)constructInvocation:(id)target selector:(SEL)selector;

@end
