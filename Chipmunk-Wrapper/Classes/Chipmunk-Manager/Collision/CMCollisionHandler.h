//
//  CMCollisionHandler.h
//  Chipmunk
//
//  Created by Ronald Mathies on 1/7/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

/**
 * Class combining all the selectors for a collision handler.
 */
@interface CMCollisionHandler : NSObject {

@private
	NSInvocation *mInvocationBegin;
	NSInvocation *mInvocationPreSolve;
	NSInvocation *mInvocationPostSolve;
	NSInvocation *mInvocationSeparate;
	
	cpCollisionType mTypeA;
	cpCollisionType mTypeB;	
	
	BOOL mIgnoreContainmentCollision;
}

/**
 * The prepared invocation begin event method.
 */
@property (nonatomic, retain) NSInvocation *invocationBegin;

/**
 * The prepared invocation pre-solve event method.
 */
@property (nonatomic, retain) NSInvocation *invocationPreSolve;

/**
 * The prepared invocation post solve method.
 */
@property (nonatomic, retain) NSInvocation *invocationPostSolve;

/**
 * The prepared invocation separate method.
 */
@property (nonatomic, retain) NSInvocation *invocationSeparate;

/**
 * The first collision type.
 */
@property (nonatomic, assign) cpCollisionType typeA;

/**
 * The second collision type.
 */
@property (nonatomic, assign) cpCollisionType typeB;

/**
 * Flag indicating if containment collisions should be ignored.
 */
@property (nonatomic, readwrite) BOOL ignoreContainmentCollision;

///---------------------------------------------------------------------------------------
/// @name Initialization
///---------------------------------------------------------------------------------------

/**
 * Default initialization method.
 */
- (id)init;

/**
 * Initialization method
 *
 * @param typeA the first collision type
 * @param typeB the second collision type
 */
- (id)initWithTypeA:(cpCollisionType)typeA andTypeB:(cpCollisionType)typeB;

///---------------------------------------------------------------------------------------
/// @name Properties
///---------------------------------------------------------------------------------------

/**
 * Method for setting the begin selector.
 *
 * @param target the target object that will recieve the event.
 * @param selector the selector method that will be invoked upon collision between the types.
 */
- (void)setInvocationBegin:(id)target selector:(SEL)selector;

/**
 * Method for setting the pre solve selector.
 *
 * @param target the target object that will recieve the event.
 * @param selector the selector method that will be invoked upon collision between the types.
 */
- (void)setInvocationPreSolve:(id)target selector:(SEL)selector;

/**
 * Method for setting the post solve selector.
 *
 * @param target the target object that will recieve the event.
 * @param selector the selector method that will be invoked upon collision between the types.
 */
- (void)setInvocationPostSolve:(id)target selector:(SEL)selector;

/**
 * Method for setting the separate selector.
 *
 * @param target the target object that will recieve the event.
 * @param selector the selector method that will be invoked upon collision between the types.
 */
- (void)setInvocationSeparate:(id)target selector:(SEL)selector;

@end
