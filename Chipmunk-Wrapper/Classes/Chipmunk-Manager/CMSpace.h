//
//  CMManager.h
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "CMTypes.h"
#include "SPPoint+Chipmunk.h"

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

@interface CMSpace : NSObject {

@private 
	cpSpace *mCpSpace;
	NSMutableArray *mCollisionHandlers;
	NSMutableArray *mBodies;
	
}

@property (nonatomic, readonly) cpSpace *cpSpace;

#pragma mark General properties

/**
 * Sets the gravity of the Chipmunk world.
 *
 * The real-world gravity is calculated as: 9.8 * 10 so it would be:
 *
 * gravity = cpv(0, -9.8 * 10)
 *
 * @param gravity the x/y gravity.
 */
- (void)setGravity:(cpVect)gravity;

/**
 * Amount of viscous damping to apply to the space. A value of 0.9 means that each body will 
 * lose 10% of it’s velocity per second. Defaults to 1. Like gravity can be overridden on a per body basis.
 *
 * @param damping the damping
 */
- (void)setDamping:(float)damping;

/**
 * Elapsed time before a group of idle bodies is put to sleep (defaults to infinity which disables sleeping). 
 *
 * @param threshold the threshold.
 */
- (void)setSleepTimeThreshhold:(float)threshold;

#pragma mark -

#pragma mark Operations

/**
 * Find a shape at the specified position.
 *
 * @param position the position
 *
 * @return the shape at the specified position or nil.
 */
- (CMShape*)findShapeAtPosition:(cpVect)position;

/**
 * Find a shape at the specified position.
 *
 * @param point the position
 *
 * @return the shape at the specified position or nil.
 */
- (CMShape*)findShapeAtPoint:(SPPoint*)point;

/**
 * Perform a step within the physics world.
 *
 * @param framerate frames pers second
 */
- (void)step:(float)framerate;

/**
 * Updates all SPDisplayObject objects that are attached to the bodies.
 */
- (void)updateShapes;

/**
 *  free all of the shapes, bodies and joints that have been added to space. 
 */
- (void)free;

#pragma mark -

#pragma mark Window containment

/**
 * Creates a containment area with the size and width.
 *
 * @param width the width of the containment area.
 * @param height the height of the containment area.
 */
-(CMBody*)addWindowContainmentWithWidth:(float)width height:(float)height;

#pragma mark -

#pragma mark Body create

/**
 * Adds a new static body with the mass and moment set to INFINITY
 */
- (CMBody*)addStaticBody;

/**
 * Constructs a body with the mass and moment set to INFINITY.
 *
 * @return the CMBody constructed.
 */
- (CMBody*)addBody;

/**
 * Constructs a body.
 *
 * @param mass Mass of the body.
 * @param moment Moment of inertia (MoI or sometimes just moment) of the body. The moment is like the rotational mass of a body.
 * @return the CMBody constructed.
 */
- (CMBody*)addBodyWithMass:(float)mass moment:(float)moment;

#pragma mark -

#pragma mark Collission detection

/**
 * Adds a default collision handler which will respond to all collisions.
 *
 * A selector should have the following arguments:
 *
 * - (BOOL) collisionListenerBetweenBallAndSquare:(CollisionMoment)moment arbiter:(cpArbiter*)arbiter space:(cpSpace*)space;
 *
 * @param target the target object thet will recieve the event.
 * @param begin the selector method that will recieve the begin event.
 * @param preSolve the selector method that will recieve the preSolve event.
 * @param postSolve the selector method that will recieve the postSolve event.
 * @param separate the selector method that will recieve the separate event.
 */
-(void)addDefaultCollisionHandler:(id)target begin:(SEL)begin preSolve:(SEL)preSolve postSolve:(SEL)postSolve separate:(SEL)separate;

/**
 * Adds a default collision handler which will respond to all collisions.
 *
 * A selector should have the following arguments:
 *
 * - (BOOL) collisionListenerBetweenBallAndSquare:(CollisionMoment)moment arbiter:(cpArbiter*)arbiter space:(cpSpace*)space;
 *
 * @param typeA  the first collision type
 * @param typeB the second collision type
 * @param target the target object thet will recieve the event.
 * @param begin the selector method that will recieve the begin event.
 * @param preSolve the selector method that will recieve the preSolve event.
 * @param postSolve the selector method that will recieve the postSolve event.
 * @param separate the selector method that will recieve the separate event.
 */
-(void) addCollisionHandlerBetween:(unsigned int)typeA andTypeB:(unsigned int)typeB target:(id)target begin:(SEL)begin preSolve:(SEL)preSolve postSolve:(SEL)postSolve separate:(SEL)separate;

/**
 * Adds a collision callback between two collisionTypes.
 *
 * A selector should have the following arguments:
 *
 * - (BOOL) collisionListenerBetweenBallAndSquare:(CollisionMoment)moment arbiter:(cpArbiter*)arbiter space:(cpSpace*)space;
 *
 * @param typeA  the first collision type
 * @param typeB the second collision type
 * @param target the target object that will recieve the event.
 * @param selector the selector method that will be invoked upon collision between the types.
 */
-(void) addCollisionHandlerBetween:(unsigned int)typeA andTypeB:(unsigned int)typeB target:(id)target selector:(SEL)selector;

/**
 * Removes the collission handler between the two collision types.
 * 
 * @param typeA the first collision type
 * @param typeB the second collision type.
 */
-(void) removeCollisionHandlerFor:(unsigned int)typeA andTypeB:(unsigned int)typeB;

#pragma mark -

@end
