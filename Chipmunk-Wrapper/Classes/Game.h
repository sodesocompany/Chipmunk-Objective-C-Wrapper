//
//  Game.h
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright Sodeso 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "BaseDemo.h"
#include "SimpleMotorJointConstraintDemo.h"
#include "DampedRotarySpringConstraintDemo.h"
#include "DampedSpringConstraintDemo.h"
#include "GearJointConstraintDemo.h"
#include "GrooveJointConstraintDemo.h"
#include "PinJointConstraintDemo.h"
#include "PivotJointConstraintDemo.h"
#include "RatchetJointConstraintDemo.h"
#include "RotaryLimitConstraintDemo.h"
#include "SlideJointConstraintDemo.h"
#include "PolyDemo.h"
#include "CarDemo.h"
#include "TheoJansenDemo.h"
#include "LayerCollisionDemo.h"
#include "SimpleCollisionDemo.h"
#include "BallDemo.h"
#include "RopeDemo.h"
#include "NewtonsCradleDemo.h"
#include "BlocksDemo.h"
#include "ManyBlocksDemo.h"
#include "DefaultLoaderDemo.h"
#include "PhysicsEditorDemo.h"
#include "ExplosionEffectDemo.h"
#include "ImplosionEffectDemo.h"
#include "BuoyancyDemo.h"
#include "SensorDemo.h"
#include "PlanetDemo.h"

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

@interface Game : SPStage <UIAccelerometerDelegate> {

@private 
	BaseDemo *demo;
	int selected;
	
	SPImage *previousDemo;
	SPImage *nextDemo;
	SPTextField *textField;
}

@end
