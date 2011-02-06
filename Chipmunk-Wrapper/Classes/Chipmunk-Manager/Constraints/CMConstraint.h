//
//  CMConstraint.h
//  Chipmunk
//
//  Created by Ronald Mathies on 1/9/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMBody;

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

/**
 * Base class for the various constraint types.
 */
@interface CMConstraint : CMObject {

@protected
	cpConstraint *mCpConstraint;
	
}

/**
 * The Chipmunk cpConstraint.
 */
@property (nonatomic, readonly) cpConstraint *cpConstraint;

///---------------------------------------------------------------------------------------
/// @name Properties
///---------------------------------------------------------------------------------------

#pragma mark Properties

/**
 * Sets the maximum force that the constraint can use to act on the two bodies. Defaults to INFINITY.
 *
 * @param maxForce the force.
 */
- (void)setMaxForce:(float)maxForce;

/**
 * Sets the maximum speed at which the constraint can apply error correction. Defaults to INFINITY.
 *
 * @param maxBias the maxBias.
 */
- (void)setMaxBias:(float)maxBias;

/**
 * Sets the percentage of error corrected each step of the space. (Can cause issues if you donít use a constant time step) Defaults to 0.1.
 *
 * @param biasCoef the percentage of error correction.
 */
- (void)setBiasCoef:(float)biasCoef;

/**
 *  Returns the first body that this constraint is attached to.
 *
 * @return returns the first body that this constraint is attached to.
 */
- (CMBody*)firstBody;

/**
 *  Returns the second body that this constraint is attached to.
 *
 * @return returns the second body that this constraint is attached to.
 */
- (CMBody*)secondBody;

/**
 * Associates an object with this constraint, it is not used by Chipmunk but can be used
 * to create a binding between an Sparrow object and a cpConstraint.
 *
 * @param data an object to associate
 */
- (void)setData:(id)data;

/**
 * Returns the associated object with this constraint.
 *
 * @return the associated object with this constraint.
 */
- (id)getData;

#pragma mark -

///---------------------------------------------------------------------------------------
/// @name Operations
///---------------------------------------------------------------------------------------

#pragma mark Operations

/**
 * Add this constraint to the Chipmunk space.
 */
- (void) addToSpace;

/**
 * Removes this constraint fro mthe Chipmunk space.
 *
 */
- (void) removeFromSpace;

#pragma mark -

@end
