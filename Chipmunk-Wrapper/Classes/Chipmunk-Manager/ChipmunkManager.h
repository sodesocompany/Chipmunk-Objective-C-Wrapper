//
//  CipmunkManager.h
//  Chipmunk
//
//  Created by Ronald Mathies on 12/28/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#ifndef CHIPMUNK_MANAGER_HEADER
#define CHIPMUNK_MANAGER_HEADER

// Types and macros
#import "CMMacros.h"
#import "CMTypes.h"

#import "chipmunk.h"

// Utilities
#import "CMInvocationUtils.h"

// Loaders
#import "CMLoaderListenerProtocol.h"
#import "CMDefaultLoader.h"
#import "CMPhysicsEditorLoader.h"

// Data object and base object.
#import "CMData.h"
#import "CMObject.h"

// Shapes
#import "CMShape.h"
#import "CMCircleShape.h"
#import "CMPolyShape.h"
#import "CMRectShape.h"
#import "CMSegmentShape.h"

// Constraints
#import "CMConstraint.h"
#import "CMDampedRotarySpringConstraint.h"
#import "CMDampedSpringConstraint.h"
#import "CMGearJointConstraint.h"
#import "CMGrooveJointConstraint.h"
#import "CMSimpleMotorConstraint.h"
#import "CMPinJointConstraint.h"
#import "CMPivotJointConstraint.h"
#import "CMRatchetJointConstraint.h"
#import "CMRotaryLimitConstraint.h"
#import "CMSlideJointConstraint.h"

// Effects
#import "CMBlastEffect.h"

// Body
#import "CMBody.h"

// Collision detection and handling.
#import "CMContactPoint.h"
#import "CMArbiter.h"
#import "CMCollisionHandler.h"
#import "CMPostCallbackHandler.h"
#import "CMQueryFunctionHandler.h"

// Space
#import "CMSpace.h"

#endif