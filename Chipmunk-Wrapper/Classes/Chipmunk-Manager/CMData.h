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
 * The data container is used to wrap a user object 
 */
@interface CMData : NSObject {

@private
	id mData;
	id mObject;
}

/**
 * The user object.
 */
@property (nonatomic, assign) id data;

/**
 * The object associated with this data object (for example the CMBody, CMShape etc..)
 * in this way we can find back from Chipmunk -> Chipmunk Manager when we receive a cpXXX
 * class.
 */
@property (nonatomic, assign) id object;

///---------------------------------------------------------------------------------------
/// @name Initialization
///---------------------------------------------------------------------------------------

/**
 * Constucts a new data container.
 *
 * @param object the object to which it is associated.
 */
- (id) initWithObject:(id)object;

/**
 * Creates a new (autoreleased) data container.
 *
 * @param object the object to which it is associated.
 */
+ (CMData*)createWithObject:(id)object;

@end
