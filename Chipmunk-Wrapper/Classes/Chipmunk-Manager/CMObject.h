//
//  CMObject.h
//  Chipmunk
//
//  Created by Ronald Mathies on 1/12/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMSpace;

@interface CMObject : NSObject {

@protected
	CMSpace *mSpace;
	NSString *mName;

}

@property (nonatomic, assign) CMSpace *space;
@property (nonatomic, assign) NSString *name;

@end
