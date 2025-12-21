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
- Removed a bunch of unused files.
- Moved sprite files into more reasonable folders. (`0_body pieces` is a dumb name)
- If something is changed/used in a framescript, a comment was added to say where it happens.
- (gaming.\_\_) Unlocked all animation layers and made them visible.
	- *I (Thielith) might have missed some.  Let me know if I did.*
- (gaming.\_\_) Added reference image of HUD to some places.
	- *Yes, its the latest version.*
- Added folders for each animation so you don't have to make them yourself.

**Project**
- (gaming.\_\_) Framerate set to 180.

**manifest.json**
- (gaming.\_\_) Added explanation of various aspects in a separate file because JSON doesn't allow comments.

**Character.entity**
- Added a screenshot to point new users to where the animation tab is.
- Made down special implementation not stupid. (it does not need a separate animation for looping and end lag)
- Moved setting-an-opponent's-thrown-frame code into a function cause it got used a lot.
- (gaming.\_\_) Added separators to animation list.
- (gaming.\_\_) Removed the multi-hit neutral aerial variant.
- (gaming.\_\_) Balance changes.
	- Most aerials have slower startup.
	- Most aerials have more landing lag.
	- Side special shield hits slow down vertical speed.
	- Removed side special's damage armor.
	- Down special's end lag reduced.
	- Added damage armor (strength:6) to dash attack's startup.
	- Forward tilt is a bit slower.
	- Neutral aerial's hitbox is less active.

**Script.hx**
   - Renamed clutch stuff for clarity.
	   - Also changed logic to use `update()` following gaming.\_\_'s example
   - Renamed projectile stuff for clarity.
   - Moved `jab3loop()` logic to `jab3` framescript.
   - `handleLinkFrames()` doesn't do anything now due to balance changes, so it is commented out so people know the functionality still exists.
   - - (gaming.\_\_) HUD icon for neutral special projectile cooldown.
	- Includes sprite filter example darkening the image when it's active.
	- (Thielith) also added functionality for icon to be animated.
   - (gaming.\_\_) Balance changes.
	   - Neutral Special's cooldown increased.

**CharacterStats.hx**
- (gaming.\_\_) Includes all airdash stats now.
- (gaming.\_\_) Balance changes.
	- Weight decreased.
	- Most attacks weaker in general.
	- Disable reversible angle on most moves.
	- Up aerial has less hitstop.
	- Adjustments to up strong.
	- Down strong no longer buries.
	- Down aerial's sweet spot now buries.

**AnimationStats.hx**
- (gaming.\_\_) Neutral special air now uses link frames for landing
- (gaming.\_\_) Attacks with the "default" special angle now use the proper special angle wording instead of "361"

**AI.hx**
- (gaming.\_\_) General improvements.
	- *I (Thielith) am not touching that.*

**Projectile**
- Removed "projectile" from projectile animation names and updated references to them.
- (gaming.\_\_) Removed spawn animation because it wasn't used.

**ProjectileScript.hx**
- Removed duplicate `removeEventListener()` function calls as `onTeardown()` already handles this.
- `destroy()` function to do stuff when destroying self.
- `Engine.log()` statements in some places for sanity check.
- Added after images to projectile.
	- *gaming.\_\_'s changelog says they did this but I couldn't find any code that did so, so I just implemented it myself.*
- (gaming.\_\_) Projectile now dies when hitting a wall.

**menu.entity**
   - Added comments where they'd be helpful



## Credits / Thanks
- Thielith - Current maintainer.
- gaming.__ - For letting me absorb their own Better Template into this one.
- Whimz - For giving good feedback.
