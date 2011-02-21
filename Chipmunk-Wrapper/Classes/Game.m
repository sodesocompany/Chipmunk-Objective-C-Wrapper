//
//  Game.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright Sodeso 2010. All rights reserved.
//

#import "Game.h" 

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface Game ()

- (void)showOptionSelector;
- (void)showDemo;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation Game

- (id)initWithWidth:(float)width height:(float)height {
    if (self = [super initWithWidth:width height:height]) {
		mOptions = [[NSArray arrayWithObjects:
							[Option createWithImage:@"SimpleMotorJoint.png" identifier:@"SimpleMotorJointConstraintDemo"], 
							[Option createWithImage:@"DampedRotarySpring.png" identifier:@"DampedRotarySpringConstraintDemo"],
							[Option createWithImage:@"DampedSpring.png" identifier:@"DampedSpringConstraintDemo"],
							[Option createWithImage:@"SlideJoint.png" identifier:@"SlideJointConstraintDemo"],
							[Option createWithImage:@"RotaryLimit.png" identifier:@"RotaryLimitConstraintDemo"],
							[Option createWithImage:@"PinJoint.png" identifier:@"PinJointConstraintDemo"],
							[Option createWithImage:@"RatchetJoint.png" identifier:@"RatchetJointConstraintDemo"],
							[Option createWithImage:@"GrooveJoint.png" identifier:@"GrooveJointConstraintDemo"],
							[Option createWithImage:@"PivotJoint.png" identifier:@"PivotJointConstraintDemo"], // -
							[Option createWithImage:@"GearJoint.png" identifier:@"GearJointConstraintDemo"],
							[Option createWithImage:@"Poly.png" identifier:@"PolyDemo"],
							[Option createWithImage:@"Car.png" identifier:@"CarDemo"],
							[Option createWithImage:@"SimpleCollision.png" identifier:@"SimpleCollisionDemo"],
							[Option createWithImage:@"ComplexCollision.png" identifier:@"LayerCollisionDemo"],
							[Option createWithImage:@"Ball.png" identifier:@"BallDemo"],
							[Option createWithImage:@"" identifier:@"TheoJansenDemo"],
							[Option createWithImage:@"Rope.png" identifier:@"RopeDemo"],
							[Option createWithImage:@"NewtonsCradle.png" identifier:@"NewtonsCradleDemo"], // -
							[Option createWithImage:@"Blocks.png" identifier:@"BlocksDemo"],
							[Option createWithImage:@"ManyBlocks.png" identifier:@"ManyBlocksDemo"],
							[Option createWithImage:@"DefaultLoader.png" identifier:@"DefaultLoaderDemo"],
							[Option createWithImage:@"PhysicsEditor.png" identifier:@"PhysicsEditorDemo"],
							[Option createWithImage:@"Explosion.png" identifier:@"ExplosionEffectDemo"],
							[Option createWithImage:@"Implosion.png" identifier:@"ImplosionEffectDemo"],
							[Option createWithImage:@"Buoyancy.png" identifier:@"BuoyancyDemo"],
							[Option createWithImage:@"Sensor.png" identifier:@"SensorDemo"],
							[Option createWithImage:@"Planet.png" identifier:@"PlanetDemo"],
							[Option createWithImage:@"FollowPath.png" identifier:@"FollowPathDemo"], nil] retain];
		
		[self showOptionSelector];
		
	}
	
    return self;
}

- (void)showOptionSelector {
	mOptionSelector = [[OptionSelector alloc] initWithOptions:mOptions];
	[mOptionSelector setDelegate:self];
	[self addChild:mOptionSelector];
}

- (void)selectedOption:(NSString*)identifier {
	[self removeChild:mOptionSelector];
	[mOptionSelector release];	

	mSelectedOption = identifier;
	[self showDemo];
}

- (void)showDemo {
	mDemo = [[NSClassFromString(mSelectedOption) alloc] init];
	[mDemo setDelegate:self];
	[mDemo setWidth:320];
	[mDemo setHeight:480];
	
	[self addChild:mDemo];
	
	[mDemo startDemo];	
}

- (void)back {
	[mDemo stopDemo];
	[self removeChild:mDemo];
	[self showOptionSelector];
}

- (void)previous {
	for (int index = 0; index < [mOptions count]; index++) {
		if ([[[mOptions objectAtIndex:index] identifier] isEqualToString:mSelectedOption]) {
			
			index--;
			if (index <= 0) {
				index = [mOptions count] - 1;
			}
			
			mSelectedOption = [[mOptions objectAtIndex:index] identifier];
			
			break;
		}
	}
	
	[self removeChild:mDemo];
	[self showDemo];
}

- (void)next {
	for (int index = 0; index < [mOptions count]; index++) {
		if ([[[mOptions objectAtIndex:index] identifier] isEqualToString:mSelectedOption]) {
			
			index++;
			if (index >= [mOptions count]) {
				index = 0;
			}
			
			mSelectedOption = [[mOptions objectAtIndex:index] identifier];
			
			break;
		}
	}
	
	[self removeChild:mDemo];
	[self showDemo];
}

- (void) dealloc {
	if (mOptionSelector != nil) {
		[mOptionSelector release];
	}
	
	if (mDemo != nil) {
		[mDemo release];
	}
	
	[mOptions release];
	
	[super dealloc];
}

@end
