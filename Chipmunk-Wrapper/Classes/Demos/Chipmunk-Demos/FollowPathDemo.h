//
//  FollowPathDemo.h
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseDemo.h"

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

@interface FollowPathDemo : BaseDemo {

@private
	CMBody *mCmBody;
	CMBody *mCmStaticBody;

	CMPivotJointConstraint *mCmConstraint;

}

@end
