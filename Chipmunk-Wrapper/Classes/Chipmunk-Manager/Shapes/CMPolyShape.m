//
//  CMPoly.m
//  Chipmunk
//
//  Created by Ronald Mathies on 1/3/11.
//  Copyright 2011 Sodeso. All rights reserved.
//

#import "CMPolyShape.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface CMPolyShape ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation CMPolyShape

- (id) initWithBody:(CMBody *)cmBody vertices:(NSArray*)vertices {
	if (self = [super init]) {
		
		cpVect verts[[vertices count]];
		for (int index = 0; index < [vertices count] ; index++) {
			NSString *point = [vertices objectAtIndex:index];
			CGPoint cgPoint = CGPointFromString(point);
			verts[index] = cpv(cgPoint.x, cgPoint.y);
		}
		
		cpBody *body = [cmBody cpBody];
		if (body->m != INFINITY) {
			
			// Calculate the moment.
			cpFloat moment = cpMomentForPoly(body->m, [vertices count], verts, cpvzero);
			cpBodySetMoment(body, moment);
		}
		
		mCpShape = cpPolyShapeNew(body, [vertices count], verts, cpvzero);
		mCpShape->data = [[CMData createWithObject:self] retain];
	}
	return self;
}

- (id) initWithBody:(CMBody *)cmBody numberOfVertices:(int)numberOfVertices firstVertice:(cpVect)firstVertice withParameters:(va_list)vaVerticesList {
	if (self = [self initWithBody:cmBody numberOfVertices:numberOfVertices offset:cpvzero firstVertice:firstVertice withParameters:vaVerticesList]) {
	}
	return self;	
}


- (id) initWithBody:(CMBody *)cmBody numberOfVertices:(int)numberOfVertices offset:(cpVect)offset firstVertice:(cpVect)firstVertice withParameters:(va_list)vaVerticesList {
	if (self = [super init]) {
		cpVect vertices[numberOfVertices];
		vertices[0] = firstVertice;
		for (int index = 1; index < numberOfVertices; index++) {
			vertices[index] = va_arg(vaVerticesList, cpVect);
		}
		
		cpBody *body = [cmBody cpBody];
		if (body->m != INFINITY) {
			
				// Calculate the moment.
			cpFloat moment = cpMomentForPoly(body->m, numberOfVertices, vertices, offset);
			cpBodySetMoment(body, moment);
		}
		
		mCpShape = cpPolyShapeNew(body, numberOfVertices, vertices, offset);
		mCpShape->data = [[CMData createWithObject:self] retain];
	}
	return self;
}

- (id) initWithBody:(CMBody*)cmBody numberOfVertices:(int)numberOfVertices vertices:(cpVect)vertices,... {
	va_list args;
	va_start(args,vertices);
	
	if (self = [self initWithBody:cmBody numberOfVertices:numberOfVertices firstVertice:vertices withParameters:args]) {
	}
	
	va_end(args);
	
	return self;
}

- (id) initWithBody:(CMBody*)cmBody numberOfVertices:(int)numberOfVertices offset:(cpVect)offset vertices:(cpVect)vertices,... {
	va_list args;
	va_start(args,vertices);
	
	if (self = [self initWithBody:cmBody numberOfVertices:numberOfVertices firstVertice:vertices withParameters:args]) {
	}
	
	va_end(args);
	
	return self;
}

@end
