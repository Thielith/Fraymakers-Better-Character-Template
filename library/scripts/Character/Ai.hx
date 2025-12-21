// Custom AI for the character
// As the character's AI is treated like a seperate entity, the character should be referred to as "character" rather than "self"

// How far horizontally away from the ledge we need to be to permit risking side special usage
var RECOVERY_SSPEC_X_THRESHOLD = 200;

// How far above ledge we need to be at minimum to permit risking side special usage
var RECOVERY_SSPEC_Y_THRESHOLD = 150;

// How far below a ledge we need to be at minimum to do up special recovery (positive means below ledge)
var RECOVERY_USPEC_Y_THRESHOLD = 190; 

// How close to the ledge we need to be to permit risking up special usage
var RECOVERY_USPEC_X_THRESHOLD = 110;

// Other vars
var sideSpecialRecoveryUsed = self.makeBool(false);

// ----------------------------------------------------------------------------------------------------
// Start general functions
// Runs on the character being loaded in
function initialize(){

}


// ----------------------------------------------------------------------------------------------------
// Runs every frame the character is active
function update(){
	
	if (character.inState(CState.TUMBLE) || character.inHurtState()){
		// Reset recovery variables
		sideSpecialRecoveryUsed.set(false);
	}

	if (self.isRecovering()){
		// Do recovery logic
		checkRecovery();
	} else {
		// Reset recovery variables
		sideSpecialRecoveryUsed.set(false);
	}
}

// ----------------------------------------------------------------------------------------------------
// Runs when the character is unloaded (Exiting a match)
function onTeardown() {
}

// End general functions

// ----------------------------------------------------------------------------------------------------
// The character's custom recovery code
function checkRecovery(){
	// Get the entity the AI wants to target (could be anything from a foe, graph node, etc.)
	var target:Entity = self.getImmediateTarget();

	// Make sure current target is a graph node (indicating a floor), we're falling, and not currently attacking or hurt/helpless
	if (target == null || target.getType() != EntityType.AI_GRAPH_NODE || character.inStateGroup(CStateGroup.ATTACK) || character.inHurtState() || character.inState(CState.FALL_SPECIAL) || character.isOnFloor() || character.getYSpeed() < -1 || self.hasInputOverrides()){
		return;
	}

	// Calculates the distance from the character to the graph node targeted
	var xDistance = character.getX() - target.getX();
	var xDistanceAbs = Math.abs(xDistance);

	// Chooses between up special and side special depending on circumstances like position
	// Up special
	if (((character.getY() >= target.getY() + RECOVERY_USPEC_Y_THRESHOLD && xDistanceAbs < RECOVERY_USPEC_X_THRESHOLD) || character.getY() >= stage.getDeathBounds().getRectangle().bottom - 200) && character.getDoubleJumpCount() > 0){
		upSpecialRecovery(target);
	// Side special
	} else if (character.getY() < target.getY() + RECOVERY_SSPEC_Y_THRESHOLD && xDistanceAbs > RECOVERY_SSPEC_X_THRESHOLD && !sideSpecialRecoveryUsed.get()){
		sideSpecialRecovery(target);
	}
}

function upSpecialRecovery(target:Entity){
	// Determine length to hold up special based on X distance from ledge
	var xDistanceLocal = character.getX() - target.getX();

	// Temporarily override engine AI inputs with our own for up special
	self.addInputOverrides([
		// Release currently held buttons
		0, 1,
		// Hold up special buttons
		Buttons.SPECIAL | ((xDistanceLocal >= 0) ? Buttons.LEFT : Buttons.RIGHT) | Buttons.UP, 1,
		// Release
		0, 1
	]);
}

function sideSpecialRecovery(target:Entity) {
	// Determine length to hold side special based on X distance from ledge
	var xDistanceLocal = character.getX() - target.getX();
	
	// Remember that we already attempted side special once
	sideSpecialRecoveryUsed.set(true);

	// Temporarily override engine AI inputs with our own for side special
	self.addInputOverrides([
		// Release currently held buttons
		0, 1,
		// Press side special buttons
		Buttons.SPECIAL | ((xDistanceLocal > 0) ? Buttons.LEFT : Buttons.RIGHT), 1,
		// Release
		0, 1
	]);
}