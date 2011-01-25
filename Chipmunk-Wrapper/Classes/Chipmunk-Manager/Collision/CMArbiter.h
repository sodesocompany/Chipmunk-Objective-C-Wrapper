//
//  CMArbiter.h
//  ChipmunkWrapper
//
//  Created by Ronald Mathies on 1/25/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

@interface CMArbiter : NSObject {

@private
	cpArbiter *mArbiter;
}

- (id)initWithCpArbiter:(cpArbiter*)arbiter;

- (CMShape*)shapeA;
- (CMShape*)shapeB;

- (void)setElasticity:(float)elasticity;
- (void)setFriction:(float)friction;
- (int)numberOfContacts;
- (BOOL)areShapesSwapped;

@end
