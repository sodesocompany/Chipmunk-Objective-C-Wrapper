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
	unsigned int mTypeA;
	unsigned int mTypeB;	
	BOOL mIgnoreContainmentCollision;
}

@property (nonatomic, retain) NSInvocation *invocationBegin;
@property (nonatomic, retain) NSInvocation *invocationPreSolve;
@property (nonatomic, retain) NSInvocation *invocationPostSolve;
@property (nonatomic, retain) NSInvocation *invocationSeparate;

@property (nonatomic, readwrite) unsigned int typeA;
@property (nonatomic, readwrite) unsigned int typeB;
@property (nonatomic, readwrite) BOOL ignoreContainmentCollision;

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
- (id)initWithTypeA:(unsigned int)typeA andTypeB:(unsigned int)typeB;

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
