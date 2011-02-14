//
//  CMDefaultLoader.m
//  ChipmunkWrapper
//
//  Created by Ronald Mathies on 2/6/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMDefaultLoader.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

static inline cpVect CPVectFromString(NSString *position) {
	CGPoint point = CGPointFromString(position);
	return cpv(point.x, point.y);
}

// --- private interface ---------------------------------------------------------------------------

@interface CMDefaultLoader ()

/**
 * Constructs a new body, the definition in the .plist file would look like:
 *
 * Root<br/>
 * &nbsp;&nbsp;bodies<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: myBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;position: {160,240}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mass: 5<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;moment: 0<br/>
 *
 * @param listerer listener that recieves events about bodies and shapes.
 * @param cmSpace the space for which this body is created.
 * @param bodyConfig the configuration of the shape.
 */
+ (void) createBody:(id)listener cmSpace:(CMSpace*)cmSpace bodyConfig:(NSDictionary*)bodyConfig;

/**
 * Constructs a new circle shape, the definition in the .plist file would look like:
 *
 * Root<br/>
 * &nbsp;&nbsp;bodies<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{body properties}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Shapes<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: circleShape<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type: circle<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;friction: 0.7 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;elasticity: 1.0 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sensor: false (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;radius: 15<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;offset: {10,10} (optional)<br/>
 *
 * @param cmBody the body for which this shape is created.
 * @param shapeConfig the configuration of the shape.
 */
+ (CMShape*) createCircleShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig;

/**
 * Constructs a new rectangle shape, the definition in the .plist file would look like:
 *
 * Root<br/>
 * &nbsp;&nbsp;bodies<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{body properties}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Shapes<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: rectangleShape<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type: rectangle<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;friction: 0.7 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;elasticity: 1.0 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sensor: false (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;width: 20<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;height: 20<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;offset: {10,10} (optional)<br/>
 *
 * @param cmBody the body for which this shape is created.
 * @param shapeConfig the configuration of the shape.
 */
+ (CMShape*) createRectangleShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig;

/**
 * Constructs a new segment shape, the definition in the .plist file would look like:
 *
 * Root<br/>
 * &nbsp;&nbsp;bodies<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{body properties}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Shapes<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: segmentShape<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type: segment<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;friction: 0.7 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;elasticity: 1.0 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sensor: false (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;radius: 3<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from: {-15,-15}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;to: {15,15}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;offset: {10,10} (optional)<br/>
 *
 * @param cmBody the body for which this shape is created.
 * @param shapeConfig the configuration of the shape.
 */
+ (CMShape*) createSegmentShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig;

/**
 * Constructs a new polygon shape, the definition in the .plist file would look like:
 *
 * Root<br/>
 * &nbsp;&nbsp;bodies<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{body properties}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Shapes<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: polyShape<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type: polygon<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;friction: 0.7 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;elasticity: 1.0 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sensor: false (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vertices:<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Item 0: {-2.8,3.1}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Item 1: {8.8,-9.1}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Item 2: {-3.0-8.9} (optional)<br/>
 *
 * @param cmBody the body for which this shape is created.
 * @param shapeConfig the configuration of the shape.
 */
+ (CMShape*) createPolygonShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig;

/**
 * Sets the general properties of a shape (friction, elasticity, sensor, etc...) which
 * are shared among all constraints.
 *
 * @param cmShape the shape.
 * @param shapeConfig the configuration of the shape.
 */
+ (void)updateShapeWithGeneralProperties:(CMShape*)cmShape shapeConfig:(NSDictionary*)shapeConfig;

/**
 * Constructs a pin joint constraint, the definition in the .plist file would look like:
 *
 * Root<br/>
 * &nbsp;&nbsp;constraints<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: myPinJoint<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type: pin_joint<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fromBody: myCircleBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;toBody: myRectBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_force: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_bias: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bias_coef: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;distance: 10 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anchor1: {15,0}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anchor2: {-15,0}<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (CMConstraint*) createPinJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

/**
 * Constructs a new damped rotay spring constraint, the definition in the .plist file would look like:
 *
 * Root<br/>
 * &nbsp;&nbsp;constraints<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: myDampedRotarySpring<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type: damped_rotary_spring<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fromBody: myCircleBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;toBody: myRectBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_force: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_bias: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bias_coef: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;restAngle: 1<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;stiffness: 1<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;damping: 1<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (CMConstraint*) createDampedRotarySpringConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

/**
 * Constructs a new damped spring constraint, the definition in the .plist file would look like:
 *
 * Root<br/>
 * &nbsp;&nbsp;constraints<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: myDampedSpring<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type: damped_spring<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fromBody: myCircleBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;toBody: myRectBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_force: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_bias: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bias_coef: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;restAngle: 1<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;stiffness: 1<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;damping: 1<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anchor1: {-10,-10}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anchor2: {10,10}<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (CMConstraint*) createDampedSpringConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

/**
 * Constructs a new damped spring constraint, the definition in the .plist file would look like:
 *
 * Root<br/>
 * &nbsp;&nbsp;constraints<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: myGearJoint<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type: gear_joint<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fromBody: myCircleBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;toBody: myRectBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_force: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_bias: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bias_coef: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;phase: 1<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ratio: 1<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (CMConstraint*) createGearJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

/**
 * Constructs a new groove joint constraint, the definition in the .plist file would look like:
 *
 * Root<br/>
 * &nbsp;&nbsp;constraints<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: myGrooveJoint<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type: groove_joint<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fromBody: myCircleBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;toBody: myRectBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_force: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_bias: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bias_coef: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anchor1: {10,10}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;grooveA: {-15,-15}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;grooveB: {15,15}<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (CMConstraint*) createGrooveJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

/**
 * Constructs a new pivot joint constraint, the definition in the .plist file would look like:
 *
 * Root<br/>
 * &nbsp;&nbsp;constraints<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: myPivotJoint<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type: pivot_joint<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fromBody: myCircleBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;toBody: myRectBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_force: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_bias: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bias_coef: 2 (optional)<br/>
 * <br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Now you need to choose either pivot:<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pivot: {10,10}<br/>
 * <br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Or anchor1, anchor2:<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anchor1: {-15,-15}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anchor2: {15,15}<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (CMConstraint*) createPivotJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

/**
 * Constructs a new ratchet joint constraint, the definition in the .plist file would look like:
 *
 * Root<br/>
 * &nbsp;&nbsp;constraints<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: myRatchetJoint<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type: ratchet_joint<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fromBody: myCircleBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;toBody: myRectBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_force: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_bias: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bias_coef: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;phase: 5<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ratchet: 5<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (CMConstraint*) createRatchetJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

/**
 * Constructs a new rotary limit constraint, the definition in the .plist file would look like:
 *
 * Root<br/>
 * &nbsp;&nbsp;constraints<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: myRotaryLimit<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type: rotary_limit<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fromBody: myCircleBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;toBody: myRectBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_force: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_bias: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bias_coef: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;min: 30<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max: 50<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (CMConstraint*) createRotaryLimitConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

/**
 * Constructs a new simple motor constraint, the definition in the .plist file would look like:
 *
 * Root<br/>
 * &nbsp;&nbsp;constraints<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: mySimpleMotorJoint<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type: simple_motor<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fromBody: myCircleBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;toBody: myRectBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_force: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_bias: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bias_coef: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rate: 20<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (CMConstraint*) createSimpleMotorConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

/**
 * Constructs a new slide joint constraint, the definition in the .plist file would look like:
 *
 * Root<br/>
 * &nbsp;&nbsp;constraints<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;Item 0<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: mySlideJointJoint<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type: slide_joint<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fromBody: myCircleBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;toBody: myRectBody<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_force: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max_bias: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bias_coef: 2 (optional)<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anchor1: {-15,15}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anchor1: {15,15}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;min: 30<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max: 60<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (CMConstraint*) createSlideJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

/**
 * Sets the general properties of a constraint (max_force, max_bias, bias_coef) which
 * are shared among all constraints.
 *
 * @param cmConstraint the constraint.
 * @param constraintConfig the configuration of the constraint.
 */
+ (void) updateConstraintWithGeneralProperties:(CMConstraint*)cmConstraint constraintConfig:(NSDictionary*)constraintConfig;

/**
 * Retrieves the fromBody from the CMSpace.
 *
 * @param cmSpace the space to retrieve the body from.
 * @param constraintConfig the configuration of the constraint.
 */
+ (CMBody*) fromBody:(CMSpace *)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

/**
 * Retrieves the toBody from the CMSpace.
 *
 * @param cmSpace the space to retrieve the body from.
 * @param constraintConfig the configuration of the constraint.
 */
+ (CMBody*) toBody:(CMSpace *)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMDefaultLoader

+ (void)loadFromConfiguration:(id)listener cmSpace:(CMSpace*)cmSpace configuration:(NSString *)configuration {
	if (![listener conformsToProtocol:@protocol(CMLoaderListenerProtocol)]  ) {
		[NSException raise:NSInternalInconsistencyException format:@"The listener doesn't confirm o the LoaderListenerProtocol.", NSStringFromSelector(_cmd)];
	}
	
	NSString *pathToConfig = [[NSBundle mainBundle] pathForResource:configuration ofType:@"plist"];
	NSDictionary *spaceConfig = [NSDictionary dictionaryWithContentsOfFile:pathToConfig];
	
	NSArray *bodies = [spaceConfig valueForKey:@"bodies"];
	for (NSDictionary *bodyConfig in bodies) {
		[self createBody:listener cmSpace:cmSpace bodyConfig:bodyConfig];
	};
	
	
	NSArray *constraints = [spaceConfig valueForKey:@"constraints"];
	for (NSDictionary *constraintConfig in constraints) {
		CMConstraint *cmConstraint;
		
		NSString *type = [constraintConfig valueForKey:@"type"];
		if ([type isEqualToString:@"pin_joint"]) {
			cmConstraint = [self createPinJointConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"damped_rotary_spring"]) {
			cmConstraint = [self createDampedRotarySpringConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"damped_spring"]) {
			cmConstraint = [self createDampedSpringConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"gear_joint"]) {
			cmConstraint = [self createGearJointConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"groove_joint"]) {
			cmConstraint = [self createGrooveJointConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"pivot_joint"]) {
			cmConstraint = [self createPivotJointConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"ratchet_joint"]) {
			cmConstraint = [self createRatchetJointConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"rotary_limit"]) {
			cmConstraint = [self createRotaryLimitConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"simple_motor"]) {
			cmConstraint = [self createSimpleMotorConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"slide_joint"]) {
			cmConstraint = [self createSlideJointConstraint:cmSpace constraintConfig:constraintConfig];
		} else {
			[NSException raise:NSInternalInconsistencyException format:@"The specified type for constraint is not allowed.", NSStringFromSelector(_cmd)];
		}
		
		[self updateConstraintWithGeneralProperties:cmConstraint constraintConfig:constraintConfig];
		
		if ([listener respondsToSelector:@selector(constraintBeforeAddToSpace:)]) {
			[listener constraintBeforeAddToSpace:cmConstraint];
		}
		
		[cmConstraint addToSpace];
		
		if ([listener respondsToSelector:@selector(constraintAfterAddToSpace:)]) {
			[listener constraintAfterAddToSpace:cmConstraint];
		}
	};
}

+ (void) createBody:(id)listener cmSpace:(CMSpace*)cmSpace bodyConfig:(NSDictionary*)bodyConfig {
	NSNumber *mass = [bodyConfig valueForKey:@"mass"];
	NSNumber *moment = [bodyConfig valueForKey:@"moment"];
	
	CMBody *cmBody = [cmSpace addBodyWithMass:[mass floatValue] moment:[moment floatValue]];
	[cmBody setName:[bodyConfig valueForKey:@"name"]];
	[cmBody setPositionUsingVect:CPVectFromString([bodyConfig valueForKey:@"position"])];
	
	if ([listener respondsToSelector:@selector(bodyBeforeAddToSpace:)]) {
		[listener bodyBeforeAddToSpace:cmBody];
	}
	
	[cmBody addToSpace];
	
	if ([listener respondsToSelector:@selector(bodyAfterAddToSpace:)]) {
		[listener bodyAfterAddToSpace:cmBody];
	}
	
	NSArray *shapes = [bodyConfig valueForKey:@"shapes"];
	for (NSDictionary *shapeConfig in shapes) {
		CMShape *cmShape;
		
		NSString *type = [shapeConfig valueForKey:@"type"];
		if ([type isEqualToString:@"circle"]) {
			cmShape = [self createCircleShape:cmBody shapeConfig:shapeConfig];
		} else if ([type isEqualToString:@"rectangle"]) {
			cmShape = [self createRectangleShape:cmBody shapeConfig:shapeConfig];
		} else if ([type isEqualToString:@"segment"]) {
			cmShape = [self createSegmentShape:cmBody shapeConfig:shapeConfig];
		} else if ([type isEqualToString:@"polygon"]) {
			cmShape = [self createPolygonShape:cmBody shapeConfig:shapeConfig];
		} else {
			[NSException raise:NSInternalInconsistencyException format:@"The specified type for shape is not allowed.", NSStringFromSelector(_cmd)];
		}
		
		[cmShape setName:[shapeConfig valueForKey:@"name"]];
		
		if ([listener respondsToSelector:@selector(shapeBeforeAddToSpace:)]) {
			[listener shapeBeforeAddToSpace:cmShape];
		}
		
		[cmShape addToSpace];
		
		if ([listener respondsToSelector:@selector(shapeAfterAddToSpace:)]) {
			[listener shapeAfterAddToSpace:cmShape];
		}
	}
}

+ (CMShape*) createCircleShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig {
	NSNumber *radius = [shapeConfig valueForKey:@"radius"];
	
	CMShape *cmShape = nil;
	NSString *offset = [shapeConfig valueForKey:@"offset"];
	if (offset != nil) {
		cmShape = [cmBody addCircleWithRadius:[radius floatValue] offset:CPVectFromString(offset)];
	} else {
		cmShape = [cmBody addCircleWithRadius:[radius floatValue]];
	}
	
	[self updateShapeWithGeneralProperties:cmShape shapeConfig:shapeConfig];
	return cmShape;
}



+ (CMShape*) createRectangleShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig {
	NSNumber *width = [shapeConfig valueForKey:@"width"];
	NSNumber *height = [shapeConfig valueForKey:@"height"];
	
	CMShape *cmShape = nil;
	NSString *offset = [shapeConfig valueForKey:@"offset"];
	if (offset != nil) {
		cmShape = [cmBody addRectangleWithWidth:[width floatValue] height:[height floatValue] offset:CPVectFromString(offset)];
	} else {
		cmShape = [cmBody addRectangleWithWidth:[width floatValue] height:[height floatValue]];
	}
	
	[self updateShapeWithGeneralProperties:cmShape shapeConfig:shapeConfig];
	return cmShape;
}


+ (CMShape*) createSegmentShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig {
	NSNumber *radius = [shapeConfig valueForKey:@"radius"];
	cpVect from = CPVectFromString([shapeConfig valueForKey:@"from"]);
	cpVect to = CPVectFromString([shapeConfig valueForKey:@"to"]);

	CMShape *cmShape = [cmBody addSegmentFrom:from to:to radius:[radius floatValue]];
	[self updateShapeWithGeneralProperties:cmShape shapeConfig:shapeConfig];

	return cmShape;
}

+ (CMShape*) createPolygonShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig {
	NSArray *vertices = [shapeConfig valueForKey:@"vertices"];

	CMShape *cmShape = [cmBody addPolyWithPoints:vertices];
	[self updateShapeWithGeneralProperties:cmShape shapeConfig:shapeConfig];

	return cmShape;
}

+ (void)updateShapeWithGeneralProperties:(CMShape*)cmShape shapeConfig:(NSDictionary*)shapeConfig {
	NSString *friction = [shapeConfig valueForKey:@"friction"];
	if (friction != nil) {
		[cmShape setFriction:[friction floatValue]];
	}
		
	NSString *elasticity = [shapeConfig valueForKey:@"elasticity"];
	if (elasticity != nil) {
		[cmShape setElasticity:[elasticity floatValue]];
	}
	
	NSString *sensor = [shapeConfig valueForKey:@"sensor"];
	if (sensor != nil) {
		[cmShape setSensor:[sensor boolValue]];
	}
}

+ (CMConstraint*) createPinJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	CMBody *from = [self fromBody:cmSpace constraintConfig:constraintConfig];
	CMBody *to = [self toBody:cmSpace constraintConfig:constraintConfig];
	
	cpVect anchor1 = CPVectFromString([constraintConfig valueForKey:@"anchor1"]);
	cpVect anchor2 = CPVectFromString([constraintConfig valueForKey:@"anchor2"]);
	
	CMPinJointConstraint *constraint = [from addPinJointConstraintWithBody:to anchor1:anchor1 anchor2:anchor2];
	
	NSNumber *distance = [constraintConfig valueForKey:@"distance"];
	if (distance != nil) {
		[constraint setDistance:[distance floatValue]];
	}
	
	return constraint;
}

+ (CMConstraint*) createDampedRotarySpringConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	CMBody *from = [self fromBody:cmSpace constraintConfig:constraintConfig];
	CMBody *to = [self toBody:cmSpace constraintConfig:constraintConfig];
	
	NSNumber *restAngle = [constraintConfig valueForKey:@"restAngle"];
	NSNumber *stiffness = [constraintConfig valueForKey:@"stiffness"];
	NSNumber *damping = [constraintConfig valueForKey:@"damping"];
	
	return [from addDampedRotaryConstraintWithBody:to restAngle:[restAngle floatValue] stiffness:[stiffness floatValue] damping:[damping floatValue]];
}

+ (CMConstraint*) createDampedSpringConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	CMBody *from = [self fromBody:cmSpace constraintConfig:constraintConfig];
	CMBody *to = [self toBody:cmSpace constraintConfig:constraintConfig];
	
	NSNumber *restLength = [constraintConfig valueForKey:@"restLength"];
	NSNumber *stiffness = [constraintConfig valueForKey:@"stiffness"];
	NSNumber *damping = [constraintConfig valueForKey:@"damping"];
	
	cpVect anchor1 = CPVectFromString([constraintConfig valueForKey:@"anchor1"]);
	cpVect anchor2 = CPVectFromString([constraintConfig valueForKey:@"anchor2"]);
	
	return [from addDampedSpringConstraintWithBody:to anchor1:anchor1 anchor2:anchor2 restLength:[restLength floatValue] stiffness:[stiffness floatValue] damping:[damping floatValue]];	
}

+ (CMConstraint*) createGearJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	CMBody *from = [self fromBody:cmSpace constraintConfig:constraintConfig];
	CMBody *to = [self toBody:cmSpace constraintConfig:constraintConfig];
	
	NSNumber *phase = [constraintConfig valueForKey:@"phase"];
	NSNumber *ratio = [constraintConfig valueForKey:@"ratio"];
	
	return [from addGearJointConstraintWithBody:to phase:[phase floatValue] ratio:[ratio floatValue]];
}

+ (CMConstraint*) createGrooveJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	CMBody *from = [self fromBody:cmSpace constraintConfig:constraintConfig];
	CMBody *to = [self toBody:cmSpace constraintConfig:constraintConfig];
	
	cpVect anchor1 = CPVectFromString([constraintConfig valueForKey:@"anchor1"]);
	cpVect grooveA = CPVectFromString([constraintConfig valueForKey:@"groove_a"]);
	cpVect grooveB = CPVectFromString([constraintConfig valueForKey:@"groove_b"]);
	
	return [from addGrooveJointConstraintWithBody:to grooveA:grooveA grooveB:grooveB anchor1:anchor1];
}

+ (CMConstraint*) createPivotJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	CMBody *from = [self fromBody:cmSpace constraintConfig:constraintConfig];
	CMBody *to = [self toBody:cmSpace constraintConfig:constraintConfig];
	
	NSString *pivot = [constraintConfig valueForKey:@"pivot"];
	if (pivot != nil) {
		return [from addPivotJointConstraintWithBody:to pivot:CPVectFromString(pivot)];
	} else {
		cpVect anchor1 = CPVectFromString([constraintConfig valueForKey:@"anchor1"]);
		cpVect anchor2 = CPVectFromString([constraintConfig valueForKey:@"anchor2"]);
		return [from addPivotJointConstraintWithBody:to anchor1:anchor1 anchor2:anchor2];
	}
}

+ (CMConstraint*) createRatchetJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	CMBody *from = [self fromBody:cmSpace constraintConfig:constraintConfig];
	CMBody *to = [self toBody:cmSpace constraintConfig:constraintConfig];
	
	NSNumber *phase = [constraintConfig valueForKey:@"phase"];
	NSNumber *ratchet = [constraintConfig valueForKey:@"ratchet"];
	
	return [from addRatchetJointConstraintWithBody:to phase:[phase floatValue] ratchet:[ratchet floatValue]];
}

+ (CMConstraint*) createRotaryLimitConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	CMBody *from = [self fromBody:cmSpace constraintConfig:constraintConfig];
	CMBody *to = [self toBody:cmSpace constraintConfig:constraintConfig];
	
	NSNumber *min = [constraintConfig valueForKey:@"min"];
	NSNumber *max = [constraintConfig valueForKey:@"max"];
	
	return [from addRotaryLimitConstraintWithBody:to min:[min floatValue] max:[max floatValue]];
}

+ (CMConstraint*) createSimpleMotorConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	CMBody *from = [self fromBody:cmSpace constraintConfig:constraintConfig];
	CMBody *to = [self toBody:cmSpace constraintConfig:constraintConfig];
	
	NSNumber *rate = [constraintConfig valueForKey:@"rate"];
	
	return [from addSimpleMotorConstraintWithBody:to rate:[rate floatValue]];
}

+ (CMConstraint*) createSlideJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	CMBody *from = [self fromBody:cmSpace constraintConfig:constraintConfig];
	CMBody *to = [self toBody:cmSpace constraintConfig:constraintConfig];
	
	cpVect anchor1 = CPVectFromString([constraintConfig valueForKey:@"anchor1"]);
	cpVect anchor2 = CPVectFromString([constraintConfig valueForKey:@"anchor2"]);
	
	NSNumber *min = [constraintConfig valueForKey:@"min"];
	NSNumber *max = [constraintConfig valueForKey:@"max"];
	
	return [from addSlideJointConstraintWithBody:to anchor1:anchor1 anchor2:anchor2 min:[min floatValue] max:[max floatValue]];
}

+ (void) updateConstraintWithGeneralProperties:(CMConstraint*)cmConstraint constraintConfig:(NSDictionary*)constraintConfig {
	[cmConstraint setName:[constraintConfig valueForKey:@"name"]];
	
	NSNumber *maxForce = [constraintConfig valueForKey:@"max_force"];
	if (maxForce != nil) {
		[cmConstraint setMaxForce:[maxForce floatValue]];
	}
	
	NSNumber *maxBias = [constraintConfig valueForKey:@"max_bias"];
	if (maxForce != nil) {
		[cmConstraint setMaxBias:[maxBias floatValue]];
	}
	
	NSNumber *biasCoef = [constraintConfig valueForKey:@"bias_coef"];
	if (maxForce != nil) {
		[cmConstraint setBiasCoef:[biasCoef floatValue]];
	}
}

+ (CMBody*) fromBody:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	NSString* fromBody = [constraintConfig valueForKey:@"fromBody"];
	if (fromBody == nil) {
		[NSException raise:NSInternalInconsistencyException format:@"You must specify a fromBody for the constraint.", NSStringFromSelector(_cmd)];
	}
	
	CMBody* cmBody = [cmSpace findBody:fromBody];
	if (cmBody == nil) {
		[NSException raise:NSInternalInconsistencyException format:@"The fromBody could not be found in the space, is the name correct?.", NSStringFromSelector(_cmd)];
	}
	
	return nil;
}

+ (CMBody*) toBody:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	NSString* toBody = [constraintConfig valueForKey:@"toBody"];
	if (toBody == nil) {
		[NSException raise:NSInternalInconsistencyException format:@"You must specify a toBody for the constraint.", NSStringFromSelector(_cmd)];
	}
	
	CMBody *cmBody = [cmSpace findBody:toBody];
	if (cmBody == nil) {
		[NSException raise:NSInternalInconsistencyException format:@"The toBody could not be found in the space, is the name correct?.", NSStringFromSelector(_cmd)];
	}
	
	return nil;
}

@end