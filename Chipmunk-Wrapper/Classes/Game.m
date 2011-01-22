//
//  Game.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright Sodeso 2010. All rights reserved.
//

#import "Game.h" 

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface Game ()

- (void)previousDemo:(SPEvent*)event;
- (void)nextDemo:(SPEvent*)event;
- (void)switchDemo;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation Game

- (id)initWithWidth:(float)width height:(float)height {
    if (self = [super initWithWidth:width height:height]) {
		selected = -1;
		
		previousDemo = [SPImage imageWithContentsOfFile:@"left.png"];
		previousDemo.x = 5;
		previousDemo.y = 5;
		[self addChild:previousDemo];
		[previousDemo addEventListener:@selector(previousDemo:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
		
		textField = [SPTextField textFieldWithText:@"Demo"];
		[textField setColor:0xFFFFFF];
		[textField setHAlign:SPHAlignCenter];
		[textField setWidth:320 - ( 2 * 32) - 10];
		[textField setHeight:32];
		[textField setX:32 + 5];
		[textField setY:5];
		
		[self addChild:textField];
		
		
		nextDemo = [SPImage imageWithContentsOfFile:@"right.png"];
		nextDemo.x = self.stage.width - 5 - [nextDemo width];
		nextDemo.y = 5;
		[self addChild:nextDemo];
		[nextDemo addEventListener:@selector(nextDemo:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
	
    return self;
}

/**
 * The listener method for recieving events about collisions between
 * the ball and the block.
 */
- (BOOL) collisionBetweenBallAndBlock:(CollisionMoment)moment arbiter:(cpArbiter*)arbiter space:(cpSpace*)space {
	NSLog(@"Collission between ball and block!");
	return YES;
}

/**
 * The listener method for recieving events about collisions between
 * the ball and the block.
 */
- (BOOL) collisionBetweenTriangleAndBlock:(CollisionMoment)moment arbiter:(cpArbiter*)arbiter space:(cpSpace*)space {
	NSLog(@"Collission between triangle and block!");
	return YES;
}

- (void)previousDemo:(SPTouchEvent*)event {
	SPTouch *touch = [[event touchesWithTarget:previousDemo andPhase:SPTouchPhaseBegan] anyObject];
	if (touch) {
		selected--;
	
		if (selected < 0) {
			selected = 10;
		}
	
		[self switchDemo];
	}
}

- (void)nextDemo:(SPTouchEvent*)event {
	SPTouch *touch = [[event touchesWithTarget:nextDemo andPhase:SPTouchPhaseBegan] anyObject];
	if (touch) {
		selected++;
	
		if (selected == 11) {
			selected = 0;
		}
	
		[self switchDemo];
	}
}

- (void)switchDemo {
	if (demo != nil) {
		[demo stopDemo];
		[self removeChild:demo];
		[demo release];
	}
		
	switch (selected) {
		case 0:
			[textField setText:@"Simple Motor Joint"];
			demo = [[SimpleMotorJointConstraintDemo alloc] init];
			break;
		case 1:
			[textField setText:@"Damped Rotary"];
			demo = [[DampedRotarySpringConstraintDemo alloc] init];
			break;
		case 2:
			[textField setText:@"Damped Spring"];
			demo = [[DampedSpringConstraintDemo alloc] init];
			break;
		case 3:
			[textField setText:@"Slide Joint"];
			demo = [[SlideJointConstraintDemo alloc] init];
			break;
		case 4:
			[textField setText:@"Rotary Limit"];
			demo = [[RotaryLimitConstraintDemo alloc] init];
			break;
		case 5:
			[textField setText:@"Pin Joint"];
			demo = [[PinJointConstraintDemo alloc] init];
			break;
		case 6:
			[textField setText:@"Ratchet Joint"];
			demo = [[RatchetJointConstraintDemo alloc] init];
			break;
		case 7:
			[textField setText:@"Groove Joint"];
			demo = [[GrooveJointConstraintDemo alloc] init];
			break;
		case 8:
			[textField setText:@"Pivot Joint"];
			demo = [[PivotJointConstraintDemo alloc] init];
			break;
		case 9:
			[textField setText:@"Gear Joint"];
			demo = [[GearJointConstraintDemo alloc] init];
			break;
		case 10:
			[textField setText:@"Poly Demo"];
			demo = [[PolyDemo alloc] init];
			break;			
	}
	
	demo.x = 0;
	demo.y = 32 + 5;
	
	[self addChild:demo];
	
	[demo startDemo];
}

- (void) dealloc {
	[previousDemo release];
	[nextDemo release];
	
	[super dealloc];
}

@end
