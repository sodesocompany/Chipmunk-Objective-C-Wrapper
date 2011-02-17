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

/**
 * The CMSpace is the entry point, here you create the bodies and setup the space.
 */
@interface CMSpace : NSObject {

@private 
	cpSpace *mCpSpace;
	
	CMCollisionHandler *mDefaultCollisionHandler;
	NSMutableArray *mCollisionHandlers;
	NSMutableArray *mBodies;
}

/**
 * The Chipmunk cpSpace.
 */
@property (nonatomic, readonly) cpSpace *cpSpace;

///---------------------------------------------------------------------------------------
/// @name Initialization
///---------------------------------------------------------------------------------------

/**
 * Standard initialization method.
 */
- (id) init;

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
 * lose 10% of itís velocity per second. Defaults to 1. Like gravity can be overridden on a per body basis.
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

/**
 * Allow you to control the accuracy of the solver. Defaults to 10.
 *
 * Chipmunk uses an iterative solver to figure out the forces between objects in the space. 
 * What this means is that it builds a big list of all of the collisions, joints, and other 
 * constraints between the bodies and makes several passes over the list considering each one 
 * individually. The number of passes it makes is the iteration count, and each 
 * iteration makes the solution more accurate. 
 *
 * If you use too many iterations, the physics should look nice and solid, but may use up too 
 * much CPU time. If you use too few iterations, the simulation may seem mushy or bouncy when
 * the objects should be solid. Setting the number of iterations lets you balance between CPU 
 * usage and the accuracy of the physics. Chipmunk’s default of 10 iterations is sufficient
 * for most simple games.
 *
 * @param iterations the iterations
 */
- (void)setIterations:(int)iterations;

///---------------------------------------------------------------------------------------
/// @name Operations
///---------------------------------------------------------------------------------------

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
 * Creates a containment area with the size and width.
 *
 * @param width the width of the containment area.
 * @param height the height of the containment area.
 * @param elasticity the elasticity of the walls.
 * @param friction the friction of the walls.
 */
-(CMBody*)addWindowContainmentWithWidth:(float)width height:(float)height elasticity:(float)elasticity friction:(float)friction;

///---------------------------------------------------------------------------------------
/// @name Query functions
///---------------------------------------------------------------------------------------

/**
 * Returns the first shape at the specified position.
 *
 * @param point the position
 */
- (CMShape*)queryFirstByPoint:(SPPoint*)point;

/**
 * Returns the first shape at the specified position.
 * 
 * @param point a point in space
 */
- (CMShape*)queryFirstByVect:(cpVect)point;

/**
 * Returns the first shape that is found at the specified point with the specified layer and
 * group information.
 *
 * About the cpLayers and cpGroup types, the cpLayers and cpGroup types are both by default 'id' (keyword), 
 * you can override this by changes the CMTypes.h file.
 * 
 * @param point a point in space
 * @param layers the layer information which is applicable for the shape to be found.
 * @param group the group information which is applicable for the shape to be found.
 */
- (CMShape*)queryFirstByPoint:(SPPoint*)point layers:(cpLayers)layers group:(cpGroup)group;

/**
 * Returns the first shape that is found at the specified point with the specified layer and
 * group information.
 *
 * About the cpLayers and cpGroup types, the cpLayers and cpGroup types are both by default 'id' (keyword), 
 * you can override this by changes the CMTypes.h file.
 * 
 * @param point a point in space
 * @param layers the layer information which is applicable for the shape to be found.
 * @param group the group information which is applicable for the shape to be found.
 */
- (CMShape*)queryFirstByVect:(cpVect)point layers:(cpLayers)layers group:(cpGroup)group;

///---------------------------------------------------------------------------------------
/// @name Bodies
///---------------------------------------------------------------------------------------

/**
 * Adds a new static body with the mass and moment set to INFINITY
 */
- (CMBody*)addStaticBody;

/**
 * Constructs a body with the mass and moment set to INFINITY.
 */
- (CMBody*)addBody;

/**
 * Constructs a body.
 *
 * @param mass Mass of the body.
 * @param moment Moment of inertia (MoI or sometimes just moment) of the body. The moment is like the rotational mass of a body.
 */
- (CMBody*)addBodyWithMass:(float)mass moment:(float)moment;

/**
 * Removes a body from the space.
 *
 * @param body the body to remove.
 */
- (void)removeBody:(CMBody*)body;

/**
 * Finds a body with the specified name.
 *
 * @param name the name of the body.
 */
- (CMBody*)findBody:(NSString*)name;

/**
 * Add func to be called before cpSpaceStep() returns. obj and data will be passed to your function.
 * Only the last callback registered for any unique value of obj will be recorded. You can add 
 * post-step callbacks from outside of other callback functions, but they won’t be called until
 * cpSpaceStep() is called again.
 *
 * A selector should have the following signature:
 *
 * - (void)someCallbackAfterStep:(id)data;
 *
 * @param target the target object that will recieve the event.
 * @param selector the selector method that will recieve the event.
 * @param data the argument that will be passed along.
 */
- (void)addPostStepCallback:(id)target selector:(SEL)selector data:(id)data;

/**
 * Calls the specified selector with every shape this is present within the specified bounding box.
 *
 * @param target the target object that will be called.
 * @param selector the selector that will be invoked.
 * @param boundingBox the area to look for shapes.
 * @param data the data that needs to be passed along.
 */
- (void)forEachShape:(id)target selector:(SEL)selector boundingBox:(cpBB)boundingBox data:(id)data;

///---------------------------------------------------------------------------------------
/// @name Collision detection
///---------------------------------------------------------------------------------------

/**
 * Adds a default collision handler which will respond to all collisions.
 *
 * A selector should have the following signature:
 *
 * - (BOOL) collisionListenerBetweenBallAndSquare:(CMArbiter*)arbiter space:(CMSpace*)space;
 *
 * About the cpCollisionType type, the cpCollisionType type is by default 'id' (keyword), you can override this
 * by changes the CMTypes.h file.
 *
 * @param target the target object that will recieve the event.
 * @param begin the selector method that will recieve the begin event.
 * @param preSolve the selector method that will recieve the preSolve event.
 * @param postSolve the selector method that will recieve the postSolve event.
 * @param separate the selector method that will recieve the separate event.
 * @param ignoreContainmentCollisions set to NO if you want to recieve collision events between the shapes and the window containment.
 */
-(void)addDefaultCollisionHandler:(id)target begin:(SEL)begin preSolve:(SEL)preSolve postSolve:(SEL)postSolve separate:(SEL)separate ignoreContainmentCollisions:(BOOL)ignoreContainmentCollisions;

/**
 * Adds a default collision handler which will respond to all collisions.
 *
 * A selector should have the following signature:
 *
 * - (void) collisionListenerBetweenBallAndSquare:(CMArbiter*)arbiter space:(CMSpace*)space;
 *
 * The only selector that expects back a BOOL is the begin selector. So all the other selectors
 * can be void.
 *
 * About the cpCollisionType type, the cpCollisionType type is by default 'id' (keyword), you can override this
 * by changes the CMTypes.h file.
 *
 * @param typeA  the first collision type
 * @param typeB the second collision type
 * @param target the target object thet will recieve the event.
 * @param begin the selector method that will recieve the begin event.
 * @param preSolve the selector method that will recieve the preSolve event.
 * @param postSolve the selector method that will recieve the postSolve event.
 * @param separate the selector method that will recieve the separate event.
 */
-(void) addCollisionHandlerBetween:(cpCollisionType)typeA andTypeB:(cpCollisionType)typeB target:(id)target begin:(SEL)begin preSolve:(SEL)preSolve postSolve:(SEL)postSolve separate:(SEL)separate;

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
-(void) addCollisionHandlerBetween:(cpCollisionType)typeA andTypeB:(cpCollisionType)typeB target:(id)target selector:(SEL)selector;

/**
 * Removes the collission handler between the two collision types.
 * 
 * @param typeA the first collision type
 * @param typeB the second collision type.
 */
-(void) removeCollisionHandlerFor:(cpCollisionType)typeA andTypeB:(cpCollisionType)typeB;

@end
