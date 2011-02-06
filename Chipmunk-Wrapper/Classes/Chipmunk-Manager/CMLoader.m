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

+ (void) createBody:(CMSpace*)cmSpace bodyConfig:(NSDictionary*)bodyConfig;

+ (void) createCircleShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig;
+ (void) createRectangleShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig;
+ (void) createSegmentShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig;

+ (void) createPinJointConstraint:(CMSpace*)cmSpace constraintConfig:(NSDictionary*)constraintConfig;

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
		}
	};
	
	
	
}

/**
 * Constructs a new body, the definition in the .plist file would look like:
 *
 * Root
 *   bodies
 *     Item 0
 *       name: myBody
 *       position: {160,240}
 *       mass: 5
 *       moment: 0
 *
 * @param cmBody the body for which this shape is created.
 * @param shapeConfig the configuration of the shape.
 */
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

/**
 * Constructs a new circle shape, the definition in the .plist file would look like:
 *
 * Root
 *   bodies
 *     Item 0
 *       {body properties}
 *       Shapes
 *         Item 0
 *           name: circleShape
 *           type: circle
 *           radius: 15
 *
 * @param cmBody the body for which this shape is created.
 * @param shapeConfig the configuration of the shape.
 */
+ (void) createCircleShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig {
	NSNumber *radius = [shapeConfig valueForKey:@"radius"];
	
	CMCircleShape *shape = [cmBody addCircleWithRadius:[radius floatValue]];
	[shape setName:[shapeConfig valueForKey:@"name"]];
	[shape addToSpace];
}


/**
 * Constructs a new rectangle shape, the definition in the .plist file would look like:
 *
 * Root
 *   bodies
 *     Item 0
 *       {body properties}
 *       Shapes
 *         Item 0
 *           name: rectangleShape
 *           type: rectangle
 *           width: 20
 *           height: 20
 *
 * @param cmBody the body for which this shape is created.
 * @param shapeConfig the configuration of the shape.
 */
+ (void) createRectangleShape:(CMBody*)cmBody shapeConfig:(NSDictionary*)shapeConfig {
	NSNumber *width = [shapeConfig valueForKey:@"width"];
	NSNumber *height = [shapeConfig valueForKey:@"height"];
	
	CMRectShape *shape = [cmBody addRectangleWithWidth:[width floatValue] height:[height floatValue]];
	[shape setName:[shapeConfig valueForKey:@"name"]];
	[shape addToSpace];
}

/**
 * Constructs a new rectangle shape, the definition in the .plist file would look like:
 *
 * Root
 *   bodies
 *     Item 0
 *       {body properties}
 *       Shapes
 *         Item 0
 *           name: segmentShape
 *           type: segment
 *           radius: 3
 *           from: {-15,-15}
 *           to: {15,15}
 *
 * @param cmBody the body for which this shape is created.
 * @param shapeConfig the configuration of the shape.
 */
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

@end
