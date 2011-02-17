//
//  CMContactPoint.h
//  ChipmunkWrapper
//
//  Created by Ronald Mathies on 2/10/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

/**
 * Object containing a single contact point.
 */
@interface CMContactPoint : NSObject {

@private
	cpVect mPoint;
	cpVect mNormal;
	float mDistance;
	
}

/**
 * The point
 */
@property (nonatomic, assign) cpVect point;

/**
 * The normal
 */
@property (nonatomic, assign) cpVect normal;

/**
 * The distance
 */
@property (nonatomic, assign) float distance;

@end
