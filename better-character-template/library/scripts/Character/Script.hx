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
    CHANCE_BLINK_ONE = 0.20;  // 1/5 chance to blink, used in stand/Framescript:70
    CHANCE_BLINK_TWO = 0.25;  // 1/4 chance to blink twice after blinking once, used in stand/Framescript:70

    LEDGE_ATK_SPEED = 10;  // used in ledge_attack/Framescript:8

    DOWN_AIR_SPEED_X = 5;   // used in aerial_down/Framescript:10
    DOWN_AIR_SPEED_Y = 18;  // used in aerial_down/Framescript:10

    DASH_ATK_BOOST_X = 12;  // used in dash_attack/Framescript:1
    DASH_ATK_SHIFT_X = 40;  // used in dash_attack/Framescript:16
    DASH_ATK_SHIFT_Y = 0;   // used in dash_attack/Framescript:16

    DOWN_TILT_BOOST_X = 10;  // used in tilt_down/Framescript:8

    FORWARD_STRONG_ATK_CHANCE_CLIP = 0.50;  // used in strong_forward_attack/Framescript:2
    FORWARD_STRONG_ATK_BOOST_ONE_X = 8.5;   // used in strong_forward_attack/Framescript:3
    FORWARD_STRONG_ATK_BOOST_TWO_X = 6.5;   // used in strong_forward_attack/Framescript:14

    UP_SPECIAL_BOOST_X = 5;    // used in special_up/Framescript:6, special_up_air/Framescript:6
    UP_SPECIAL_BOOST_Y = -21;  // used in special_up/Framescript:6, special_up_air/Framescript:6

    SIDE_SPECIAL_BOOST_X = 8;    // used in special_side/Framescript:10, 15, 19, 23, 27
    SIDE_SPECIAL_BOOST_Y = -15;  // used in special_side/Framescript:10
    SIDE_SPECIAL_SHIELD_HIT_SPEED_PENALTY = -4;  // used in onSideSpecialShieldHit() in this script 
// --- End Magic Number Definitions ---


// Tracks active Neutral Special projectile (in case we need to handle any special cases)
var projectile = self.makeObject(null); 

var disableNSpecStatusEffect = self.makeObject(null);
var NEUTRAL_SPECIAL_COOLDOWN:Int = 90;
var NSPEC_PROJ_X_OFFSET:Int = 40;
var NSPEC_PROJ_Y_OFFSET:Int = -50;

var clutchButtonIsHeld = self.makeBool(false);  // Check if the clutch button is held current frame
var clutchButtonWasHeld = self.makeBool(false); // Check if the clutch button was held prev. frame
var clutchEnabled = self.makeBool(true);        // if we can clutch

// HUD icons
var neutralSpecialCooldownIcon:Sprite = null; // The hud icon used for visualizing neutral special's cooldown
var darkenFilter:HsbcColorFilter = new HsbcColorFilter(); // The filter applied to the hud icons during their respective move's cooldown
darkenFilter.brightness = -0.35; // Makes the icon 35% as bright as normal

// ===== start general functions ===== 

    //Runs on object init
    function initialize(){
        // not used for this character but can be used execute important code that would be skipped during the transition
        // you can check what state you're in with inState()
        // self.addEventListener(GameObjectEvent.LINK_FRAMES, handleLinkFrames, {persistent:true});

        // Exports can be used to "export" variables and functions between entites
        // self.exports = {
        //     variableExample: neutralSpecialCooldownIcon,
        //     functionExample: clutchButtonPressed
        // }

        setupHUD();
    }

    function update(){
        if(clutchButtonPressed() && clutchEnabled.get()){
            doClutchStuff();
        }

        handleHUDiconAnimations();
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

    function onTeardown() {
    }
// ===== end general functions =====


// ===== HUD icon setup =====
    function setupHUD(){
        neutralSpecialCooldownIcon = Sprite.create(self.getResource().getContent("hud_icons"));
        self.getDamageCounterContainer().addChild(neutralSpecialCooldownIcon);
        neutralSpecialCooldownIcon.addShader(self.getCostumeShader());
        neutralSpecialCooldownIcon.currentAnimation = "neutralSpecialCooldownIcon_intro";
    }

    // since these are sprites, they can't run framescript layer keyframes, nor do they have a playAnimation()
    // so we gotta do this manually
    function handleHUDiconAnimations(){
        if(neutralSpecialCooldownIcon != null) handleNeutralSpecialCooldownIconAnimation();
    }

    function handleNeutralSpecialCooldownIconAnimation(){
        neutralSpecialCooldownIcon.advance();

        if(neutralSpecialCooldownIcon.currentAnimation == "neutralSpecialCooldownIcon_intro"){
            if(neutralSpecialCooldownIcon.currentFrame == neutralSpecialCooldownIcon.totalFrames){
                neutralSpecialCooldownIcon.currentAnimation = "neutralSpecialCooldownIcon";
            }
        }
    }

// ===== End HUD icon setup =====


// ===== Clutch logic =====
    function clutchButtonPressed() {
        return !clutchButtonWasHeld.get() && clutchButtonIsHeld.get();
    }

    // enables clutch for current animation
    function enableClutch() {
        clutchEnabled.set(true);

        // handle case where clutch is pressed on the exact frame clutch is enabled
        if (clutchButtonPressed()) {
            doClutchStuff();
            return;
        }
    }

    function disableClutch() {
        clutchEnabled.set(false);
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
        neutralSpecialCooldownIcon.addFilter(darkenFilter);
    }

    function enableNeutralSpecial(){
        if (disableNSpecStatusEffect.get() == null) {
            // Engine.log("neutral special already enabled.");
            return;
        }

        self.removeStatusEffect(StatusEffectType.DISABLE_ACTION, disableNSpecStatusEffect.get().id);
        disableNSpecStatusEffect.set(null);
        neutralSpecialCooldownIcon.removeFilter(darkenFilter);
    }
// ===== End Neutral Special =====


// ===== Side Special =====
    function onSideSpecialShieldHit(){
        self.setXSpeed(SIDE_SPECIAL_SHIELD_HIT_SPEED_PENALTY);
        self.setYSpeed(self.getYSpeed()*0.5);
    }

    // allow user to jump if the final hit hits
    function onSideSpecialHit(){
        self.updateAnimationStats({allowJump: true});
    }
// ===== End Side Special =====

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
