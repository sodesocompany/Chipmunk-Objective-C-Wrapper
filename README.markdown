Chipmunk Objective-C Wrapper
============================

The Chipmunk Objective-C Wrapper was created because a lot of people find the combination of Objective-C / C not pleasant to work with. It doesn't look nice and it can even be very confusing.

This Wrapper also add some functionality so that it can integrate very well with Sparrow.

Version details:
----------------

Current head release:

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

