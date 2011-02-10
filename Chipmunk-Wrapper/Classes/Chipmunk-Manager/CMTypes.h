//
//  Types.h
//  Chipmunk
//
//  Created by Ronald Mathies on 1/4/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

typedef enum { 
	CMCollisionBegin = 1, 
	CMCollisionPreSolve, 
	CMCollisionPostSolve, 
	CMCollisionSeparate
} CollisionMoment;

#define CP_GROUP_TYPE unsigned int
#define CP_LAYERS_TYPE unsigned int
#define CP_COLLISION_TYPE_TYPE id
#define CP_DATA_POINTER_TYPE id

#define CM_WINDOW_CONTAINMENT_COLLISION_TYPE @"CM_WALL"