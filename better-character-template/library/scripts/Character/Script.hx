// API Script

// Notes:
// - format for framescript location:
//   [animation name]/[layer name]:[frame number]
//      e.g  stand/Framescript:70 means the stand animation, on the layer named Framescript, on frame 70
//      e.g  special_side/Framescript:10, 15 means the special_side animation, on the layer named Framescript, on frame 10 and 15
//
// - if you define a variable without "var", you can reference them in Framescript layer keyframes
// - you don't __need__ to have these magic number definitions and can just input the number directly.
//   however, doing this makes it more clear as to what the numbers actually mean

// --- Magic Number Definitions ---
    CHANCE_BLINK_ONE = self.makeFloat(0.20);  // 1/5 chance to blink, used in stand/Framescript:70
    CHANCE_BLINK_TWO = self.makeFloat(0.25);  // 1/4 chance to blink twice after blinking once, used in stand/Framescript:70

    LEDGE_ATK_SPEED = self.makeFloat(10);  // used in ledge_attack/Framescript:8

    DOWN_AIR_SPEED_X = self.makeFloat(5);   // used in aerial_down/Framescript:10
    DOWN_AIR_SPEED_Y = self.makeFloat(18);  // used in aerial_down/Framescript:10

    DASH_ATK_BOOST_X = self.makeFloat(12);  // used in dash_attack/Framescript:1
    DASH_ATK_SHIFT_X = self.makeFloat(40);  // used in dash_attack/Framescript:16
    DASH_ATK_SHIFT_Y = self.makeFloat(0);   // used in dash_attack/Framescript:16

    DOWN_TILT_BOOST_X = self.makeFloat(10);  // used in tilt_down/Framescript:8

    FORWARD_STRONG_ATK_CHANCE_CLIP = self.makeFloat(0.50);  // used in strong_forward_attack/Framescript:2
    FORWARD_STRONG_ATK_BOOST_ONE_X = self.makeFloat(8.5);   // used in strong_forward_attack/Framescript:3
    FORWARD_STRONG_ATK_BOOST_TWO_X = self.makeFloat(6.5);   // used in strong_forward_attack/Framescript:14

    UP_SPECIAL_BOOST_X = self.makeFloat(5);    // used in special_up/Framescript:6, special_up_air/Framescript:6
    UP_SPECIAL_BOOST_Y = self.makeFloat(-21);  // used in special_up/Framescript:6, special_up_air/Framescript:6

    SIDE_SPECIAL_BOOST_X = self.makeFloat(8);    // used in special_side/Framescript:10, 15, 19, 23, 27
    SIDE_SPECIAL_BOOST_Y = self.makeFloat(-15);  // used in special_side/Framescript:10
// --- End Magic Number Definitions ---


// Tracks active Neutral Special projectile (in case we need to handle any special cases)
var projectile = self.makeObject(null); 

var disableNSpecStatusEffect = self.makeObject(null);

var downSpecialLoopCheckTimer = self.makeInt(-1);

var clutchTimer = self.makeInt(-1); // tracks the latest
var clutchButtonIsHeld = self.makeBool(false); // Check if the clutch button is held current frame
var clutchButtonWasHeld = self.makeBool(false); // Check if the clutch button was held prev. frame

//offset projectile start position
var NSPEC_PROJ_X_OFFSET = 40;
var NSPEC_PROJ_Y_OFFSET = -50;

var NEUTRAL_SPECIAL_COOLDOWN = 60;

// start general functions --- 

//Runs on object init
function initialize(){
    self.addEventListener(GameObjectEvent.LINK_FRAMES, handleLinkFrames, {persistent:true});
}

function update(){
}

// Runs when reading inputs (before determining character state, update, framescript, etc.)
function inputUpdateHook(pressedControls:ControlsObject, heldControls:ControlsObject) {
    // This also runs when updating the buffer, below code should only be run on input tick
	if (self.isFirstInputUpdate()) {
        clutchButtonWasHeld.set(clutchButtonIsHeld.get());
		clutchButtonIsHeld.set(heldControls.SHIELD2);
	}

    // This runs when reading the buffer and on input tick -
	// Disable SHIELD2 input so engine will not see the shield2 input for shield/airdash
    //
    // self.getHeldControls().SHIELD2 will be false too
    // so must use clutchButtonHeld to check for clutch input
	pressedControls.SHIELD2 = false;
	heldControls.SHIELD2 = false;
}

// CState-based handling for LINK_FRAMES
// needed to ensure important code that would be skipped during the transition is still executed
function handleLinkFrames(e){
	if(self.inState(CState.SPECIAL_SIDE)){
		if(self.getCurrentFrame() >= 14){
			self.updateAnimationStats({bodyStatus:BodyStatus.NONE});
		}
	} else if(self.inState(CState.SPECIAL_DOWN)){
        specialDown_resetTimer();
        downSpecialLoopCheckTimer.set(self.addTimer(1, -1, specialDown_checkLoop));    
    }
}

function onTeardown() {
	
}
// --- end general functions



// ===== Clutch logic =====
    function clutchButtonPressed() {
        return !clutchButtonWasHeld.get() && clutchButtonIsHeld.get();
    }

    // enables clutch for current animation
    function enableClutch() {
        // remove any pre-existing clutch checks
        disableClutch();

        // don't have to set timer if clutch button is held the frame this code runs
        if (clutchButtonPressed()) {
            doClutchStuff();
            return;
        }

        // when clutchButtonPressed, doClutchStuff()
        var timer = self.addTimer(0, -1, doClutchStuff, {condition: clutchButtonPressed});
        clutchTimer.set(timer);
    }

    function disableClutch() {
        self.removeTimer(clutchTimer.get());
        clutchTimer.set(-1);
    }

    // example clutch behavior:  reverse horizontal velocity
    function doClutchStuff() {
        self.flip();
        self.setXVelocity(-1 * self.getXVelocity());

        AudioClip.play(self.getResource().getContent("downspecial"));
        
        // disable clutch for the rest of this animation (so no double clutch)
        disableClutch();
    }

// ===== End Clutch logic =====



// ===== Neutral Special =====
    function spawnAndFireProjectile(){
        projectile.set(
            match.createProjectile(self.getResource().getContent("fraynkieProjectile"), self)
        );
        
        projectile.get().setX(
            self.getX() + self.flipX(NSPEC_PROJ_X_OFFSET)
        );
        projectile.get().setY(
            self.getY() + NSPEC_PROJ_Y_OFFSET
        );
    }

    function startNeutralSpecialCooldown(){
        disableNeutralSpecial();
        self.addTimer(NEUTRAL_SPECIAL_COOLDOWN, 1, enableNeutralSpecial, {persistent:true});
    }

    function disableNeutralSpecial(){
        if (disableNSpecStatusEffect.get() != null) {
            // Engine.log("neutral special already disabled");
            return;
        }

        disableNSpecStatusEffect.set(self.addStatusEffect(StatusEffectType.DISABLE_ACTION, CharacterActions.SPECIAL_NEUTRAL));
    }

    function enableNeutralSpecial(){
        if (disableNSpecStatusEffect.get() == null) {
            // Engine.log("neutral special already enabled.");
            return;
        }

        self.removeStatusEffect(StatusEffectType.DISABLE_ACTION, disableNSpecStatusEffect.get().id);
        disableNSpecStatusEffect.set(null);
    }
// ===== End Neutral Special =====


// ===== Side Special =====
    function onSideSpecialShieldHit(){
        self.setXSpeed(-4);
    }

    // allow user to jump if the final hit hits
    function onSideSpecialHit(){
        self.updateAnimationStats({allowJump: true});
    }
// ===== End Side Special =====

// ===== Down Special =====
    function specialDown_gotoEndlag(){
        if(self.isOnFloor()){
            self.playAnimation("special_down_endlag");
        } else {
            self.playAnimation("special_down_air_endlag");
        }
    }

    function specialDown_resetTimer(){
        self.removeTimer(downSpecialLoopCheckTimer.get());
        downSpecialLoopCheckTimer.set(-1);
    }

    function specialDown_checkLoop(){
        var heldControls:ControlsObject = self.getHeldControls();

        if(!heldControls.SPECIAL){
            specialDown_resetTimer();
            specialDown_gotoEndlag();
        }
    }

    function specialDown_gotoLoop(){
        if(self.isOnFloor()){
            self.playAnimation("special_down_loop");
        } else {
            self.playAnimation("special_down_air_loop");
        }

        //failsafe
        specialDown_resetTimer();

        // start checking inputs
        downSpecialLoopCheckTimer.set(self.addTimer(1, -1, specialDown_checkLoop));    
    }
// ===== End Down Special =====

// ===== Grab =====
    // used on throw_forward/Framescript:1, 3, 7, 13, 18, 20
    //         throw_back/Framescript:1, 4, 11, 18, 20
    //         throw_up/Framescript:1, 6, 13
    //         throw_down/Framescript:1, 4, 10, 12
    function setOpponentHurtThrownFrame(frame:Int){
        if (self.getGrabbedFoe().hasAnimation("hurt_thrown")) {
            self.getGrabbedFoe().playAnimation("hurt_thrown");
            self.getGrabbedFoe().playFrame(frame);
        }
    }
// ===== End Grab =====
