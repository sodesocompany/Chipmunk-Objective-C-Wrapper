//
//  PhysicsEditorLoader.m
//  ChipmunkWrapper
//
//  Created by Ronald Mathies on 2/6/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMLoader.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

static inline cpVect CPVectFromString(NSString *position) {
	CGPoint point = CGPointFromString(position);
	return cpv(point.x, point.y);
}

// --- private interface ---------------------------------------------------------------------------

@interface CMLoader ()

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
 * @param cmSpace the space for which this body is created.
 * @param bodyConfig the configuration of the shape.
 */
+ (void) createBody:(CMSpace*)cmSpace bodyConfig:(NSDictionary*)bodyConfig;

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
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;radius: 15<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;offset: {10,10} (optional)<br/>
 *
 * @param cmBody the body for which this shape is created.
 * @param shapeConfig the configuration of the shape.
 */
+ (void) createCircleShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig;

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
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;width: 20<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;height: 20<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;offset: {10,10} (optional)<br/>
 *
 * @param cmBody the body for which this shape is created.
 * @param shapeConfig the configuration of the shape.
 */
+ (void) createRectangleShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig;

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
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;radius: 3<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from: {-15,-15}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;to: {15,15}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;offset: {10,10} (optional)<br/>
 *
 * @param cmBody the body for which this shape is created.
 * @param shapeConfig the configuration of the shape.
 */
+ (void) createSegmentShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig;

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
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anchor1: {15,0}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anchor2: {-15,0}<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (void) createPinJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

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
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;restAngle: 1<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;stiffness: 1<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;damping: 1<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (void) createDampedRotarySpringConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

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
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;restAngle: 1<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;stiffness: 1<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;damping: 1<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anchor1: {-10,-10}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anchor2: {10,10}<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (void) createDampedSpringConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

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
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;phase: 1<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ratio: 1<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (void) createGearJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

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
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anchor1: {10,10}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;grooveA: {-15,-15}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;grooveB: {15,15}<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (void) createGrooveJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

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
+ (void) createPivotJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

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
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;phase: 5<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ratchet: 5<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (void) createRatchetJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

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
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;min: 30<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max: 50<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (void) createRotaryLimitConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

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
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rate: 20<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (void) createSimpleMotorConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

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
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anchor1: {-15,15}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;anchor1: {15,15}<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;min: 30<br/>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;max: 60<br/>
 *
 * @param cmSpace the space.
 * @param constraintConfig the configuration of the constraint.
 */
+ (void) createSlideJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

@end

@implementation CMLoader

+ (void) loadFromConfiguration:(CMSpace *)cmSpace configuration:(NSString *)configuration {
	NSString *pathToConfig = [[NSBundle mainBundle] pathForResource:configuration ofType:@"plist"];
	NSDictionary *spaceConfig = [NSDictionary dictionaryWithContentsOfFile:pathToConfig];
	
	NSArray *bodies = [spaceConfig valueForKey:@"bodies"];
	for (NSDictionary *bodyConfig in bodies) {
		[self createBody:cmSpace bodyConfig:bodyConfig];
	};

	
	NSArray *constraints = [spaceConfig valueForKey:@"constraints"];
	for (NSDictionary *constraintConfig in constraints) {
		NSString *type = [constraintConfig valueForKey:@"type"];
		if ([type isEqualToString:@"pin_joint"]) {
			[self createPinJointConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"damped_rotary_spring"]) {
			[self createDampedRotarySpringConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"damped_spring"]) {
			[self createDampedSpringConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"gear_joint"]) {
			[self createGearJointConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"groove_joint"]) {
			[self createGrooveJointConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"pivot_joint"]) {
			[self createPivotJointConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"ratchet_joint"]) {
			[self createRatchetJointConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"rotary_limit"]) {
			[self createRotaryLimitConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"simple_motor"]) {
			[self createSimpleMotorConstraint:cmSpace constraintConfig:constraintConfig];
		} else if ([type isEqualToString:@"slide_joint"]) {
			[self createSlideJointConstraint:cmSpace constraintConfig:constraintConfig];
		}
	};
	
	
	
}

+ (void) createBody:(CMSpace*)cmSpace bodyConfig:(NSDictionary*)bodyConfig {
	NSNumber *mass = [bodyConfig valueForKey:@"mass"];
	NSNumber *moment = [bodyConfig valueForKey:@"moment"];
	
	CMBody *cmBody = [cmSpace addBodyWithMass:[mass floatValue] moment:[moment floatValue]];
	[cmBody setName:[bodyConfig valueForKey:@"name"]];
	[cmBody setPositionUsingVect:CPVectFromString([bodyConfig valueForKey:@"position"])];
	[cmBody addToSpace];
	
	NSArray *shapes = [bodyConfig valueForKey:@"shapes"];
	for (NSDictionary *shapeConfig in shapes) {
		NSString *type = [shapeConfig valueForKey:@"type"];
		if ([type isEqualToString:@"circle"]) {
			[self createCircleShape:cmBody shapeConfig:shapeConfig];
		} else if ([type isEqualToString:@"rectangle"]) {
			[self createRectangleShape:cmBody shapeConfig:shapeConfig];
		} else if ([type isEqualToString:@"segment"]) {
			[self createSegmentShape:cmBody shapeConfig:shapeConfig];
		}
	}
}

+ (void) createCircleShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig {
	NSNumber *radius = [shapeConfig valueForKey:@"radius"];
	
	CMCircleShape *shape;
	NSString *offset = [shapeConfig valueForKey:@"offset"];
	if (offset != nil) {
		shape = [cmBody addCircleWithRadius:[radius floatValue] offset:CPVectFromString(offset)];
	} else {
		shape = [cmBody addCircleWithRadius:[radius floatValue]];
		
	}
	
	[shape setName:[shapeConfig valueForKey:@"name"]];
	[shape addToSpace];
}



+ (void) createRectangleShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig {
	NSNumber *width = [shapeConfig valueForKey:@"width"];
	NSNumber *height = [shapeConfig valueForKey:@"height"];

	CMRectShape *shape;
	NSString *offset = [shapeConfig valueForKey:@"offset"];
	if (offset != nil) {
		shape = [cmBody addRectangleWithWidth:[width floatValue] height:[height floatValue] offset:CPVectFromString(offset)];
	} else {
		shape = [cmBody addRectangleWithWidth:[width floatValue] height:[height floatValue]];
	}
	[shape setName:[shapeConfig valueForKey:@"name"]];
	[shape addToSpace];
}


+ (void) createSegmentShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig {
	NSNumber *radius = [shapeConfig valueForKey:@"radius"];
	cpVect from = CPVectFromString([shapeConfig valueForKey:@"from"]);
	cpVect to = CPVectFromString([shapeConfig valueForKey:@"to"]);

	CMSegmentShape *shape = [cmBody addSegmentFrom:from to:to radius:[radius floatValue]];
	[shape setName:[shapeConfig valueForKey:@"name"]];
	[shape addToSpace];
	
}


+ (void) createPinJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	NSString* fromBody = [constraintConfig valueForKey:@"fromBody"];
	NSString* toBody = [constraintConfig valueForKey:@"toBody"];
	
	CMBody* from = [cmSpace findBody:fromBody];
	CMBody *to = [cmSpace findBody:toBody];
	
	cpVect anchor1 = CPVectFromString([constraintConfig valueForKey:@"anchor1"]);
	cpVect anchor2 = CPVectFromString([constraintConfig valueForKey:@"anchor2"]);
	
	CMPinJointConstraint *constraint = [from addPinJointConstraintWithBody:to anchor1:anchor1 anchor2:anchor2];
	[constraint setName:[constraintConfig valueForKey:@"name"]];
	[constraint addToSpace];
}

+ (void) createDampedRotarySpringConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	NSString* fromBody = [constraintConfig valueForKey:@"fromBody"];
	NSString* toBody = [constraintConfig valueForKey:@"toBody"];

	NSNumber *restAngle = [constraintConfig valueForKey:@"restAngle"];
	NSNumber *stiffness = [constraintConfig valueForKey:@"stiffness"];
	NSNumber *damping = [constraintConfig valueForKey:@"damping"];
	
	CMBody* from = [cmSpace findBody:fromBody];
	CMBody *to = [cmSpace findBody:toBody];
	
	CMDampedRotarySpringConstraint *constraint = [from addDampedRotaryConstraintWithBody:to restAngle:[restAngle floatValue] stiffness:[stiffness floatValue] damping:[damping floatValue]];
	[constraint setName:[constraintConfig valueForKey:@"name"]];
	[constraint addToSpace];
}

+ (void) createDampedSpringConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	NSString* fromBody = [constraintConfig valueForKey:@"fromBody"];
	NSString* toBody = [constraintConfig valueForKey:@"toBody"];
	NSNumber *restLength = [constraintConfig valueForKey:@"restLength"];
	NSNumber *stiffness = [constraintConfig valueForKey:@"stiffness"];
	NSNumber *damping = [constraintConfig valueForKey:@"damping"];

	cpVect anchor1 = CPVectFromString([constraintConfig valueForKey:@"anchor1"]);
	cpVect anchor2 = CPVectFromString([constraintConfig valueForKey:@"anchor2"]);

	CMBody* from = [cmSpace findBody:fromBody];
	CMBody *to = [cmSpace findBody:toBody];
	
	CMDampedSpringConstraint *constraint = [from addDampedSpringConstraintWithBody:to anchor1:anchor1 anchor2:anchor2 restLength:[restLength floatValue] stiffness:[stiffness floatValue] damping:[damping floatValue]];	
	[constraint setName:[constraintConfig valueForKey:@"name"]];
	[constraint addToSpace];
}

+ (void) createGearJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	NSString* fromBody = [constraintConfig valueForKey:@"fromBody"];
	NSString* toBody = [constraintConfig valueForKey:@"toBody"];
	NSNumber *phase = [constraintConfig valueForKey:@"phase"];
	NSNumber *ratio = [constraintConfig valueForKey:@"ratio"];
	
	CMBody* from = [cmSpace findBody:fromBody];
	CMBody *to = [cmSpace findBody:toBody];
	
	CMGearJointConstraint *constraint = [from addGearJointConstraintWithBody:to phase:[phase floatValue] ratio:[ratio floatValue]];
	[constraint setName:[constraintConfig valueForKey:@"name"]];
	[constraint addToSpace];							 
}

+ (void) createGrooveJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	NSString* fromBody = [constraintConfig valueForKey:@"fromBody"];
	NSString* toBody = [constraintConfig valueForKey:@"toBody"];
	
	CMBody* from = [cmSpace findBody:fromBody];
	CMBody *to = [cmSpace findBody:toBody];
	
	cpVect anchor1 = CPVectFromString([constraintConfig valueForKey:@"anchor1"]);
	cpVect grooveA = CPVectFromString([constraintConfig valueForKey:@"groove_a"]);
	cpVect grooveB = CPVectFromString([constraintConfig valueForKey:@"groove_b"]);
	
	CMGrooveJointConstraint *constraint = [from addGrooveJointConstraintWithBody:to grooveA:grooveA grooveB:grooveB anchor1:anchor1];
	[constraint setName:[constraintConfig valueForKey:@"name"]];
	[constraint addToSpace];
}

+ (void) createPivotJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	NSString* fromBody = [constraintConfig valueForKey:@"fromBody"];
	NSString* toBody = [constraintConfig valueForKey:@"toBody"];
	
	CMBody* from = [cmSpace findBody:fromBody];
	CMBody *to = [cmSpace findBody:toBody];
	
	CMConstraint *constraint;
	NSString *pivot = [constraintConfig valueForKey:@"pivot"];
	if (pivot != nil) {
		constraint = [from addPivotJointConstraintWithBody:to pivot:CPVectFromString(pivot)];
	} else {
		cpVect anchor1 = CPVectFromString([constraintConfig valueForKey:@"anchor1"]);
		cpVect anchor2 = CPVectFromString([constraintConfig valueForKey:@"anchor2"]);
		constraint = [from addPivotJointConstraintWithBody:to anchor1:anchor1 anchor2:anchor2];
	}
	
	[constraint setName:[constraintConfig valueForKey:@"name"]];
	[constraint addToSpace];
}

+ (void) createRatchetJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	NSString* fromBody = [constraintConfig valueForKey:@"fromBody"];
	NSString* toBody = [constraintConfig valueForKey:@"toBody"];
	
	CMBody* from = [cmSpace findBody:fromBody];
	CMBody *to = [cmSpace findBody:toBody];
	
	NSNumber *phase = [constraintConfig valueForKey:@"phase"];
	NSNumber *ratchet = [constraintConfig valueForKey:@"ratchet"];
	
	CMRatchetJointConstraint *constraint = [from addRatchetJointConstraintWithBody:to phase:[phase floatValue] ratchet:[ratchet floatValue]];
	[constraint setName:[constraintConfig valueForKey:@"name"]];
	[constraint addToSpace];
}

+ (void) createRotaryLimitConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	NSString* fromBody = [constraintConfig valueForKey:@"fromBody"];
	NSString* toBody = [constraintConfig valueForKey:@"toBody"];
	
	CMBody* from = [cmSpace findBody:fromBody];
	CMBody *to = [cmSpace findBody:toBody];
	
	NSNumber *min = [constraintConfig valueForKey:@"min"];
	NSNumber *max = [constraintConfig valueForKey:@"max"];
	
	CMRotaryLimitConstraint *constraint = [from addRotaryLimitConstraintWithBody:to min:[min floatValue] max:[max floatValue]];
	[constraint setName:[constraintConfig valueForKey:@"name"]];
	[constraint addToSpace];
}

+ (void) createSimpleMotorConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	NSString* fromBody = [constraintConfig valueForKey:@"fromBody"];
	NSString* toBody = [constraintConfig valueForKey:@"toBody"];
	
	CMBody* from = [cmSpace findBody:fromBody];
	CMBody *to = [cmSpace findBody:toBody];
	
	NSNumber *rate = [constraintConfig valueForKey:@"rate"];
	
	CMSimpleMotorConstraint *constraint = [from addSimpleMotorConstraintWithBody:to rate:[rate floatValue]];
	[constraint setName:[constraintConfig valueForKey:@"name"]];
	[constraint addToSpace];
}

+ (void) createSlideJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig {
	NSString* fromBody = [constraintConfig valueForKey:@"fromBody"];
	NSString* toBody = [constraintConfig valueForKey:@"toBody"];
	
	CMBody* from = [cmSpace findBody:fromBody];
	CMBody *to = [cmSpace findBody:toBody];
	
	cpVect anchor1 = CPVectFromString([constraintConfig valueForKey:@"anchor1"]);
	cpVect anchor2 = CPVectFromString([constraintConfig valueForKey:@"anchor2"]);
	
	NSNumber *min = [constraintConfig valueForKey:@"min"];
	NSNumber *max = [constraintConfig valueForKey:@"max"];
	
	CMSlideJointConstraint *constraint = [from addSlideJointConstraintWithBody:to anchor1:anchor1 anchor2:anchor2 min:[min floatValue] max:[max floatValue]];
	[constraint setName:[constraintConfig valueForKey:@"name"]];
	[constraint addToSpace];
}

@end