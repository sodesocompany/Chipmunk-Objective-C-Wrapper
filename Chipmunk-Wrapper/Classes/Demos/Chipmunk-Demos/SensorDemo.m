//
//  SensorDemo.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import "SensorDemo.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

static float frand_unit() {
	return 2.0f * ((float) rand() / (float)RAND_MAX) - 1.0f;
}

// --- private interface ---------------------------------------------------------------------------

@interface SensorDemo ()

- (void)initializeChipmunkObjects;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation SensorDemo

- (void) initializeChipmunkObjects {
	CMBody *staticBody = [mSpace addStaticBody];
	CMShape *shape = [staticBody addCircleWithRadius:15.0f offset:cpv(160, 150)];
	[shape setSensor:YES];
	[shape setCollisionType:BLOCKING_SENSOR_TYPE];
	[shape addToSpace];
		
	shape = [staticBody addSegmentFrom:cpv(1, 400) to:cpv(320, 400) radius:1.0f];
	[shape setSensor:YES];
	[shape setCollisionType:CATCH_SENSOR_TYPE];
	[shape addToSpace];
	
    [mSpace addCollisionHandlerBetween:CATCH_SENSOR_TYPE andTypeB:BALL_TYPE target:self begin:@selector(collisionBetweenCatchSensorAndBallBegin:space:) preSolve:NULL postSolve:NULL separate:NULL];
 }

- (BOOL) collisionBetweenCatchSensorAndBallBegin:(CMArbiter*)arbiter space:(CMSpace*)space {
	[mSpace addPostStepCallback:self selector:@selector(removeBall:) data:[[arbiter shapeA] body]];
	return NO;
}

- (void)removeBall:(id)data {
	[mSpace removeBody:data];
}

- (void)step:(SPEnterFrameEvent *)event {
	CMBody *cmBody = [mSpace addBodyWithMass:1.0f moment:0];
	[cmBody setPositionUsingVect:cpv(160, 150)];
	[cmBody setVelocity:cpvmult(cpv(frand_unit(), frand_unit()), 100.0f)];
	[cmBody addToSpace];
	
	CMShape *cmShape = [cmBody addCircleWithRadius:15.0f];
	[cmShape setCollisionType:BALL_TYPE];
	[cmShape addToSpace];
	
	[super step:event];
}
@end
