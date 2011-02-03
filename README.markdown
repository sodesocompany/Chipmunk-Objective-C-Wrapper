Chipmunk Objective-C Wrapper
============================

The Chipmunk Objective-C Wrapper was created because a lot of people find the combination of Objective-C / C not pleasant to work with. It doesn't look nice and it can even be very confusing.

This Wrapper also add some functionality so that it can integrate very well with Sparrow.

Version details:
----------------

Current head release:

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

Since it is basically a wrapper with some extra functionality the Chipmunk documentation should do fine. Specific documentation can be found in the .h files and there are plenty code samples within the download. These code samples include a sample for every constraint and shape type. In just plain Chipmunk and in combination with Sparrow (later is not yet completed).

