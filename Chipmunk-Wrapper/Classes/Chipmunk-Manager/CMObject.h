//
//  CMObject.h
//  Chipmunk
//
//  Created by Ronald Mathies on 1/12/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMSpace;

/**
 * The CMObject functions as a base class for a number of other classes
 * which all have a relation with the space.
 */
@interface CMObject : NSObject {

@protected
	CMSpace *mSpace;
	NSString *mName;

}

/**
 * The space under which this object was created.
 */
@property (nonatomic, assign) CMSpace *space;

/**
 * A user customizable name for this instance.
 */
@property (nonatomic, assign) NSString *name;

@end
