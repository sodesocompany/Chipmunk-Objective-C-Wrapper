//
//  CMPhysicsEditorLoader.m
//  ChipmunkWrapper
//
//  Created by Ronald Mathies on 2/6/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMPhysicsEditorLoader.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

static inline cpVect CPVectFromString(NSString *position) {
	CGPoint point = CGPointFromString(position);
	return cpv(point.x, point.y);
}

// --- private interface ---------------------------------------------------------------------------

@interface CMPhysicsEditorLoader ()

/**
 * Constructs a new body.
 *
 * @param listerer listener that recieves events about bodies and shapes.
 * @param cmSpace the space for which this body is created.
 * @param bodyConfig the configuration of the shape.
 * @param name the name of the body.
 */
+ (void) createBody:(id)listener cmSpace:(CMSpace*)cmSpace bodyConfig:(NSDictionary*)bodyConfig name:(NSString*)name;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMPhysicsEditorLoader

+ (void) loadFromConfiguration:(id)listener cmSpace:(CMSpace *)cmSpace configuration:(NSString *)configuration {
	if (![listener conformsToProtocol:@protocol(CMLoaderListenerProtocol)]  ) {
		[NSException raise:NSInternalInconsistencyException format:@"The listener doesn't confirm o the LoaderListenerProtocol.", NSStringFromSelector(_cmd)];
	}
	
	NSString *pathToConfig = [[NSBundle mainBundle] pathForResource:configuration ofType:@"plist"];
	NSDictionary *spaceConfig = [NSDictionary dictionaryWithContentsOfFile:pathToConfig];
	
	NSDictionary *bodies = [spaceConfig valueForKey:@"bodies"];
	NSEnumerator *bodiesEnumerator = [bodies keyEnumerator];
	for (NSString *bodyName in bodiesEnumerator) {
		[self createBody:listener cmSpace:cmSpace bodyConfig:[bodies valueForKey:bodyName] name:bodyName];
	};
	
}

+ (void) createBody:(id)listener cmSpace:(CMSpace*)cmSpace bodyConfig:(NSDictionary*)bodyConfig name:(NSString*)name {
	NSNumber *mass = [bodyConfig valueForKey:@"mass"];
	
		//	CMBody *cmBody = [cmSpace addBodyWithMass:[mass floatValue] moment:[moment floatValue]];
	CMBody *cmBody = [cmSpace addBodyWithMass:1 moment:0];
	[cmBody setName:name];
	
	if ([listener respondsToSelector:@selector(bodyBeforeAddToSpace:)]) {
		[listener bodyBeforeAddToSpace:cmBody];
	}
	
	[cmBody addToSpace];
	
	if ([listener respondsToSelector:@selector(bodyAfterAddToSpace:)]) {
		[listener bodyAfterAddToSpace:cmBody];
	}
	
	NSArray *shapes = [bodyConfig valueForKey:@"fixtures"];
	for (NSDictionary *shapeConfig in shapes) {
		NSDictionary *polygons = [shapeConfig valueForKey:@"polygons"];
		
		NSNumber *elasticity = [shapeConfig valueForKey:@"elasticity"];
		NSNumber *friction = [shapeConfig valueForKey:@"friction"];
		NSNumber *layers = [shapeConfig	valueForKey:@"layers"];
		NSNumber *group = [shapeConfig valueForKey:@"group"];
		NSNumber *collisionType = [shapeConfig valueForKey:@"collision_type"];
		NSNumber *isSensor = [shapeConfig valueForKey:@"isSensor"];
		
		for (NSArray *polygon in polygons) {
			CMShape *cmShape = [cmBody addPolyWithPoints:polygon];
			[cmShape setElasticity:[elasticity floatValue]];
			[cmShape setFriction:[friction floatValue]];
			
			if ([layers floatValue] != 0) {
				[cmShape setLayer:[layers floatValue]];
			}	

			if ([group floatValue] != 0) {
				[cmShape setGroup:[group floatValue]];
			}
			
			[cmShape setCollisionType:collisionType];
			[cmShape setSensor:[isSensor boolValue]];
			
			if ([listener respondsToSelector:@selector(shapeBeforeAddToSpace:)]) {
				[listener shapeBeforeAddToSpace:cmShape];
			}
			
			[cmShape addToSpace];
			
			if ([listener respondsToSelector:@selector(shapeAfterAddToSpace:)]) {
				[listener shapeAfterAddToSpace:cmShape];
			}
		}
	}
	
}

@end