# Better Fraymakers Character Template for FrayTools

## Overview

This is the FrayTools project for the Fraymakers Character Template which demonstrates how to create a basic playable character for Fraymakers. You must have FrayTools installed on your system in order to view and modify this project.

## Downloading FrayTools

Download FrayTools for your operating system here: [https://fraytools.com/downloads/](https://fraytools.com/downloads/)

Then download the latest version of the following FrayTools Plugins below:
* Fraymakers Exporter:
[https://github.com/Fraymakers/content-exporter-plugin/releases](https://github.com/Fraymakers/content-exporter-plugin/releases)
* Fraymakers Metadata Definitions:
[https://github.com/Fraymakers/metadata-plugin/releases](https://github.com/Fraymakers/metadata-plugin/releases)
* Api Types (Optional but highly recommended):
[https://github.com/Fraymakers/api-types-plugin/releases](https://github.com/Fraymakers/api-types-plugin/releases)

Finally, open the `.fraytools` project file in FrayTools and you should be good to go!

For additional setup instructions, check out our [Deep Dive Guide](https://docs.google.com/document/d/1o6CE04FRaqQyksD2uX7zxOQXYiZ_M2YCwtqK0mMoARY/edit?usp=sharing).


## Changes Made
**Overall**
- All instances of "charactertemplate" are replaced with "fraynkie".
- All instances of "charactertemplateNspecProjectile" are replaced with "fraynkieProjectile".
- Formatted a lot of things to make them more readable.  Example:
```
special_up: {leaveGroundCancel:false, xSpeedConservation:0.5, ySpeedConservation:0.5, allowMovement:true, groundSpeedCap: 5.5, aerialSpeedCap: 3.25, nextState:CState.FALL_SPECIAL}

special_up: {  // updated on frame 6, 7
	leaveGroundCancel: false,
	xSpeedConservation: 0.5, ySpeedConservation: 0.5,
	allowMovement: true,
	groundSpeedCap: 5.5,
	aerialSpeedCap: 3.25,
	nextState: CState.FALL_SPECIAL
}, 
```

- Renamed sprite files to be simpler.  (e.g `character_body_circle` --> `circle`)
- Updated the palette preview image.
- Removed "projectile" from projectile animation names and updated references to them.
- Removed a bunch of unused files.
- Moved sprite files into more reasonable folders. (`0_body pieces` is a dumb name)
- If something is changed/used in a framescript, a comment was added to say where it happens.

**ProjectileScript.hx**
- Removed duplicate `removeEventListener()` function calls as `onTeardown()` already handles this.
- `destroy()` function to do stuff when destroying self.
- `Engine.log()` statements in some places for sanity check.

**Script.hx**
   - Renamed clutch stuff for clarity.
   - Renamed projectile stuff for clarity.
   - Moved `jab3loop()` logic to `jab3` framescript.
   - Put "magic numbers" into variables to better describe what they're doing.
   - Moved setting-an-opponent's-thrown-frame code into a function cause it got used a lot.
   - Made down special implementation not stupid. (it does not need a separate animation for looping and end lag)

**menu.entity**
   - Added comments where they'd be helpful



## Credits / Thanks
- Thielith - Current maintainer
- gaming.__ - For letting me absorb their work into this

