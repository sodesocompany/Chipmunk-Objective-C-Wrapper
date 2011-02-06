//
//  PolyDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "TheoJansenDemo.h"

// --- Static variables ----------------------------------------------------------------------------

const float offset = 30.0f;

const float numberOfLegs = 2;
const float legMass = 1.0f;

const float crankRadius = 13.0f;


// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface TheoJansenDemo ()

- (void)initializeChipmunkObjects;
- (void)addLeg:(float)side offset:(float)offset chassis:(CMBody*)chassisBody crank:(CMBody*)crankBody anchor:(cpVect)anchor;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation TheoJansenDemo

- (void) initializeChipmunkObjects {
	CMBody *chassisBody = [mSpace addBodyWithMass:2.0f moment:0];
	[chassisBody setPositionUsingVect:cpv(100, 100)];
	[chassisBody addToSpace];

	CMShape *chassisShape = [chassisBody addSegmentFrom:cpv(-offset, 0.0f) to:cpv(offset, 0.0f) radius:3.0f];
	[chassisShape setGroup:TJ_GROUP];
	[chassisShape addToSpace];

	CMBody *crankBody = [mSpace addBodyWithMass:1.0f moment:0];
	[crankBody setPositionUsingVect:cpv(100, 100)];
	[crankBody addToSpace];
	CMShape *crankShape = [crankBody addCircleWithRadius:crankRadius offset:cpvzero];
	[crankShape setGroup:TJ_GROUP];
	[crankShape addToSpace];
	
	CMPivotJointConstraint *chassisCrankPivotConstraint = [chassisBody addPivotJointConstraintWithBody:crankBody anchor1:cpvzero anchor2:cpvzero];
	[chassisCrankPivotConstraint addToSpace];
	
	int numberOfLegs = 2;
	for(int i=0; i<numberOfLegs; i++){
		[self addLeg:30.0f offset:offset chassis:chassisBody crank:crankBody anchor:cpvmult(cpvforangle((cpFloat)(2*i+0)/(cpFloat)numberOfLegs*M_PI), 13.0f)];
		[self addLeg:30.0f offset:-offset chassis:chassisBody crank:crankBody anchor:cpvmult(cpvforangle((cpFloat)(2*i+1)/(cpFloat)numberOfLegs*M_PI), crankRadius)];
	}
}

- (void)addLeg:(float)side offset:(float)offset chassis:(CMBody*)chassisBody crank:(CMBody*)crankBody anchor:(cpVect)anchor {
	CMBody *upperLegBody = [mSpace addBodyWithMass:legMass moment:0];
	[upperLegBody setPositionUsingVect:cpvadd(cpv(offset, 0.0f), cpv(100, 100))];
	[upperLegBody addToSpace];
	
	CMShape *upperLegShape = [upperLegBody addSegmentFrom:cpvzero to:cpv(0.0f, side) radius:3.0f];
	[upperLegShape addToSpace];
	CMPivotJointConstraint *chassisUpperLegPivotConstraint = [chassisBody addPivotJointConstraintWithBody:upperLegBody anchor1:cpv(offset, 0.0f) anchor2:cpvzero];
	[chassisUpperLegPivotConstraint addToSpace];
	
	
	CMBody *lowerLegBody = [mSpace addBodyWithMass:legMass moment:0];
	[lowerLegBody setPositionUsingVect:cpvadd(cpv(offset, -side), cpv(100, 100))];
	[lowerLegBody addToSpace];
	
	CMShape *lowerLegSegmentShape = [lowerLegBody addSegmentFrom:cpvzero to:cpv(0.0f, -1.0f * side) radius:3.0f];
	[lowerLegSegmentShape setGroup:TJ_GROUP];
	[lowerLegSegmentShape addToSpace];
	CMShape *lowerLegCircleShape = [lowerLegBody addCircleWithRadius:3.0f*2.0f offset:cpv(0.0f, -1.0f*side)];
	[lowerLegCircleShape setGroup:TJ_GROUP];
	[lowerLegCircleShape setElasticity:0.0f];
	[lowerLegCircleShape setFriction:1.0f];
	[lowerLegCircleShape addToSpace];
	
	CMPinJointConstraint *chassisLowerLegConstraint = [chassisBody addPinJointConstraintWithBody:lowerLegBody anchor1:cpv(offset, 0.0f) anchor2:cpvzero];
	[chassisLowerLegConstraint addToSpace];
	CMGearJointConstraint *upperLegLowerLegGearConstraint = [upperLegBody addGearJointConstraintWithBody:lowerLegBody phase:0.0f ratio:1.0f];
	[upperLegLowerLegGearConstraint addToSpace];
	
	float distance = sqrtf(side * side + offset * offset);
	
	CMPinJointConstraint *crankUpperLegConstraint = [crankBody addPinJointConstraintWithBody:upperLegBody anchor1:anchor anchor2:cpv(0.0f, side)];
	[crankUpperLegConstraint setDistance:distance];
	[crankUpperLegConstraint addToSpace];
	
	CMPinJointConstraint *crankLowerLegConstraint = [crankBody addPinJointConstraintWithBody:lowerLegBody anchor1:anchor anchor2:cpvzero];
	[crankUpperLegConstraint setDistance:distance];
	[crankLowerLegConstraint addToSpace];
	
}

@end
