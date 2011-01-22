//
//  CMBody.h
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright 2010 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

/**
 * The data container is used to wrap a user 
 */
@interface CMData : NSObject {

@private
	id mData;
	id mObject;
}

@property (nonatomic, assign) id data;
@property (nonatomic, assign) id object;

- (id)init;

+ (CMData*)createWithObject:(id)object;

@end
