Chipmunk Objective-C Wrapper
============================

The Chipmunk Objective-C Wrapper was created because a lot of people find the combination of Objective-C / C not pleasant to work with. It doesn't look nice and it can even be very confusing.

This Wrapper also add some functionality so that it can integrate very well with Sparrow.

Version details:
----------------

Current head release:

TODO:
- Document all the new methods that have been created since Februari 12

16 Februari 2010:

- Added the CMSprite class which is a sub-class of SPSprite, it allows you to do direct loading of a CMObject using
parameters.. HIGHLY EXPERIMENTAL and could be removed in the future.

- Added a new demo: PlanetDemo

Really cool demo which displays two planets and a object that flies by it will be attracted to
the planets as if the planets have gravity.

- Added a new demo: ImplosionEffectDemo 

Just like the ExplosionEffectDemo but then an implosion.

- CMSpace: Added the methods: - (void)forEachShape:(id)target selector:(SEL)selector boundingBox:(cpBB)boundingBox data:(id)data;

The signature for the selector should look like:

- (void)performImpExplosion:(cpBB*)boundingBox cmShape:(CMShape*)cmShape data:(id)data;

Alows you to loop through all the shapes that are available within the specified bounding box using the specified selector.

- CMShape: Added the methods:

- (float)elasticity;
- (float)friction;
- (cpCollisionType)collisionType;
- (cpGroup)group;
- (cpLayers)layer;
- (BOOL)sensor;
- (cpBB)boundingBox;

- CMBody: Added the methods:

- (float)mass;
- (float)moment;
- (cpVect)velocity;
- (cpVect)force;
- (cpVect)position;
- (float) angle;
- (float)angularVelocity;
- (float)torque;

- CMShape: Renamed the method: - (id)getData; to: - (id)data;
- CMBody: Renamed the method: - (id)getData; to: - (id)data;
- CMBlastEffect: Added implotion methods, so now explosion and implosion is available.
- Refactored CMExplosionEffect to CMBlastEffect.

14 Februari 2010:

- Updated the demo.plist with the new fields
- Added friction, elasticity and sensor to the CMDefaultLoader
- Added a new demo: SensorDemo
- Added the class CMPostCallbackHandler for handling the post step callbacks.
- CMSpace: Added the method: - (void)addPostStepCallback:(id)target selector:(SEL)selector data:(id)data;

Add a function that will be called after the space / step has completed, you can register multiple callbacks.

11 Februari 2010:

The PhysicsEditor can now export correct defined polygon shapes, even when they are
concave / convex. This is a major improvement. There are still some changes that need
to be made like setting the momentum on bodies and the friction, elasticity on the shapes
but it's getting there.

- Added a new demo: BuoyancyDemo

Demonstrates the buoyancy of water, it is however somewhat limited that when
you add a constraint the effects might be strange (for example when you
drag the block arround in the upper part of the screen).

Without any constraints the blocks behave normal and it all works fine.

- CMBody added the method: - (void) updateVelocity:(cpVect)gravity damping:(float)damping dt:(float)dt;
- CMBody added the method: - (void) updatePosition:(float)dt;

- Modified the PhysicsEditorDemo to include a nicer polygon demo.

Due to valantines day i couln't resist and join the whole thing with a nicer demo,
so the demo now includes a heart shaped polygon model.

- Added CMInvocationUtils class

Simple class which creates a NSInvocation based on a given target and selector.

- CMBody added the method:

- (void) setVelocityFunction:(id)target selector:(SEL)selector;

The selector has the following signature:

- (void)velocityFunction:(CMBody*)cmBody gravity:(cpVect)gravity damping:(float)damping dt:(float)dt;

- CMBody added the method:

- (void) setVelocityFunction:(id)target selector:(SEL)selector;

The selector has the following signature:

- (void)positionFunction:(CMBody*)cmBody dt:(float)dt;

10 Februari 2010:

- Added: CMExplosionEffect

This is really cool, using the CMExplosionEffect you can simulate an ... explotion..
It is very easy to use, you only need to specify where, how big, what radius and optionally a
layer and a group:

[CMExplosionEffect perform:mSpace position:[spPoint toCpVect] radius:150 force:800];

See the demo for some cool effects.

- Changed CMArbiter: added the method: - (NSArray*)contactPoints;

This will return all the contact points (an array of CMContactPoint objects) at the moment of colission.

- Changed CMTypes:

#define CP_GROUP_TYPE unsigned int
#define CP_LAYERS_TYPE unsigned int

It is better to have them as an unsigned int since it is more powerfull then.
Check out the documentation over at:

  http://files.slembcke.net/chipmunk/release/ChipmunkLatest-Docs/
  And then especially the section "Filtering Collisions".

- Renamed CMLoader to CMDefaultLoader

Makes it clear that this is the default loader variant that is directly supported
and doesn't receive sudden changes.

- Renamed LoaderDemo to DefaultLoaderDemo

- CMArbiter: Added the method: - (NSArray*)contactPoints;

Returns all the contact points that occured during this collision.

- Added the CMPhysicsEditorLoader

Just like the CMLoader this is also a loader. The difference is that this loader can load files that have
been created using the PhysicsEditor (http://www.physicseditor.de/). This product is still in beta and
support for it is not yet completed but i am working with the author to get it all working. (.plist files
will still change). So don't use it yet.

- Added the CMLoaderListenerProtocol

This is a callback mechanism for when objects have been loaded from .plist files. All methods are optional
and you can choose which callbacks you want to recieve. There are two different methods per type (body, shape, constraint).
One method is called before the object is added to the space and the other for when the object has been added to the space.

This can be used for example to attach Sparrow objects to a body so that the position and angle will be updated when
using the step function of chipmunk.

- CMShape: added the - (void)setSensor:(BOOL)isSensor; method to mark a shape as being a sensor.
- CMLoader: added the ability the load polygons from a .plist file.
- Added a new demo: PhysicsEditorDemo (not stable, still working on this with the author of PhysicsEditor)
- Added a new demo: LoaderDemo

8 February 2010:

CMArbiter: Added the method: - (BOOL)isFirstContact;

This method indicates if the collision is the first contact, can be used in the pre-solve and post-solve phase of the collision.

6 February 2010:

- Added the CMLoader class which allows you to load a complete space configuration from a .plist file.
Check out the documentation and the sample Demo.plist for usage.

- Added appledoc documentation (read below on how to use it)
- General: Added a lot of documentation again
- CMSpace: Added the method: - (CMBody*)findBody:(NSString*)name;
- CMPolyShape: Added the method: - (id) initWithBody:(CMBody *)cmBody points:(NSArray*)points
- CMBody: Added the method: - (void) setPositionUsingPoint:(SPPoint*)coordinate
- CMBody: Added the method: - (CMPolyShape*) addPolyWithPoints:(NSArray*)points;
- CMBody: Changed the method: 

(void) setPosition:(cpVect)coordinate; renamed to: - (void) setPositionUsingVect:(cpVect)coordinate;

- CMBody: Changed the methods:

- (CMRectShape*) addRectWithWidth:.... renamed to: - (CMRectShape*) addRectangleWithWidth:....

4 February 2010:

General note:

- Added the folowing definitions to CMTypes.h

(i had to remove the hash sign because that causes an html horizontal rule to be displayed)

* define CP_GROUP_TYPE id
* define CP_COLLISION_TYPE_TYPE id
* define CP_DATA_POINTER_TYPE id

These types change the cpLayers, cpGroup and cpCollisionType. The cpLayers, cpGroup and cpCollisionType are now 
by default defined as being an id (keyword), this has the advantage that you can specify an NSString or 
any object for that matter as a identification.

This has one side effect, you can't include the chipmunk.h header file yourself, this is not handled by
the ChipmunkManager.h file (the CMTypes.h file needs to be before the chipmunk.h header file otherwise
this won't work).

- Modified demos where applicable because of the collision change.
- CMSpace: Changed the method: 

(CMShape*)findShapeAtPoint:(SPPoint*)position; renamed to:  (CMShape*)queryFirstByPoint:(SPPoint*)point;

- CMSpace: Changed the method:

(CMShape*)findShapeAtPosition:(cpVect)position; renamed to:  (CMShape*)queryFirstByVect:(SPPoint*)point;

- CMSpace: Added the method: - (void)removeBody:(CMBody*)body
- CMSpace: Added the method: - (CMShape*)queryFirstByPoint:(SPPoint*)point layers:(cpLayers)layers group:(cpGroup)group;
- CMSpace: Added the method: - (CMShape*)queryFirstByVect:(cpVect*)point layers:(cpLayers)layers group:(cpGroup)group;

Both do the same but take a different first parameter. These functions return the first shape that is found
at the specified point. The layers and group information is used to identify more specific which shape you are looking for.

- CMConstraint: Removed the method: - (cpConstraint*) construct; (use [constraint cpConstraint] instead)
- CMConstraint: Removed the method: - (void) free;

- CMShape: Removed the method: - (cpShape*) construct; (use [shape cpShape] instead)
- CMShape: Added the method: - (void) removeFromSpace;

- CMBody: Removed the method: - (cpBody*) construct; (use [body cpBody] instead)
- CMBody: Removed the method: - (void)free;
- CMBody: Added the method: - (void) removeFromSpace;
- CMBody: Added the method: - (void)removeShape:(CMShape*)shape
- CMBody: Added the method: - (void)setLayer:(cpLayers)layer;
- Changed collision handling: the types (A & B) are now defined as cpCollisionType

3 February 2010:

- Dit a lot of code cleanup
- Changed the default chipmunk step size for the demo's now it's set to 1/15th, looks more smooth.
- Added a frames per second counter (thanks Shilo)
- Changed the starting height of the CarDemo
- Removed UIAccelerometer from NewtonsCradleDemo
- Added a new demo: BlocksDemo
- Fixed disabling UIAccelerometer, is now removed on dealloc of demo (might cause bugs)
- Added the ability to disable UIAccelerometer in demos (programmatically)

2 February 2010:

- Added a new demo: RopeDemo
- Added a new demo: Newtons Cradle
- Added setIterations on the CMSpace, read the API doc in the source before changing this.

1 February 2010 and before:

- Fixed CMCollisionHandler bug (resulting in a BAD_EXEC)
- Fixed a number of memory leaks
- Added a new demo: TheoJansenDemo
- Added elasticity and friction to the containment (user specified).
- Added the ability to set the distance on a pin joint
- Added a new demo: SimpleCollisionDemo
- Removed the CollisionMoment from the collision event selectors.
- Added the CMArbiter class which wraps the cpArbiter.
- Changed the way the selectors for the collision events should be build up, they now have the following definition:
  - (BOOL) defaultBegin:(CMArbiter*)arbiter space:(CMSpace*)space 
 
- Changed the following method:
  -(void)addDefaultCollisionHandler:(id)target begin:(SEL)begin preSolve:(SEL)preSolve postSolve:(SEL)postSolve separate:(SEL)separate;

  This method now has an extra argument: ignoreContainmentCollisions:(BOOL)ignoreContainmentCollisions;

  If you do don't want to receive events about shapes colliding with the window containment then set this argument to YES.

- Build a switch on the demo title to enable / disable the debug view.
- Moved the demo button bar to the bottom for easier navigation.
- New demo: Sparrow in combination with Chipmunk, ball demo.
- Added the group attribute to the shapes
- Set the elasticity and friction for the borders of the addWindowContainmentWithWidth method to 0.5 and 0.1
- Updated the updateShape method, now it will check the CMBody's data to see if a SPDisplayObject has been attached.
- New demo: Car demo, which will display a sort of car with suspension, it uses the groove joint and the damped spring constraint.
- Checked compatibility with Sparrow 1.1
- Added optional offsets for the shapes, if a body uses multiple shapes you can set the offset to get the shape in the correct position.
- CMManager is now CMSpace, another difference is that the CMSpace is no longer a singleton, this makes it possible to have multiple Chipmunk environments running. By default it will create an empty cpSpace.

Version compatibility:
----------------------

Sparrow 1.1
Chipmunk 5.3.4

NOTE: Both frameworks are already quite mature, in general
updating the sparrow version will not cause many problems since the API
methods that are used by this project have existed since the early versions and are not likely to change.

For Chipmunk it could be a different story, if you really need the upgrade to a newer version i would suggest it to try it out and see what happens, a lot of problems should already occur during the compilation process.

How to use:
-----------

This part still needs to be described, not sure if i will do it in documentation style or using a screen cast.

API Documentation:
------------------

There are two ways in which you can read the API documentation:

First method is by opening the docset within the doumentation folder. Another method is reading the documentation directly from tythe .h files and there are plenty code samples within the download. These code samples include a sample for every constraint and shape type. In just plain Chipmunk and in combination with Sparrow (later is not yet completed).

