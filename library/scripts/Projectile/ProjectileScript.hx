// API Script for Character Template Projectile

var X_SPEED = 7; // X speed of water
var Y_SPEED = -7; // Y Speed of water

// Instance vars
var life = self.makeInt(60 * 5);
var originalOwner = null;

// after image aspects
var timeBetweenAfterImage:Int = 5;
var afterImageLife:Int = 15;

function initialize() {
	self.addEventListener(EntityEvent.COLLIDE_FLOOR, onGroundHit, { persistent: true });
	self.addEventListener(EntityEvent.COLLIDE_WALL, onWallHit, {persistent:true});
	self.addEventListener(GameObjectEvent.HIT_DEALT, onHit, { persistent: true });

	// Set up horizontal reflection
	Common.enableReflectionListener({ mode: "X", replaceOwner: true });

	originalOwner = self.getOwner();
	self.setCostumeIndex(originalOwner.getCostumeIndex());

	// after images
	self.addTimer(timeBetweenAfterImage, -1, createAfterImage);

	self.setState(PState.ACTIVE);
	self.setXSpeed(X_SPEED);
	self.setYSpeed(Y_SPEED);
}

// runs every frame
function update() {
	if (self.inState(PState.ACTIVE)) {
		life.dec();
		if (life.get() <= 0) {
			// Engine.log("going to die now");
			destroy();
		}
	}
} 

// =====================================================
function createAfterImage(){
	var afterImage:Vfx = match.createVfx(new VfxStats({
		spriteContent: self.getResource().getContent("projectile"),
		animation: "idle",
		relativeWith: false,
		x: self.getX(), y: self.getY(),
		scaleX: self.flipX(1),
		timeout: afterImageLife,
		fadeOut: true,
		flipWith: true,
		layer: VfxLayer.CHARACTERS_BACK
	}));

	afterImage.addShader(self.getCostumeShader());
}

function destroy() {
	// Engine.log("destroy!");
	self.toState(PState.DESTROYING);
}

function onGroundHit(event) {
	// Engine.log("hit ground");
	destroy();
}

function onWallHit(event) {
	// Engine.log("hit wall");
	destroy();
}

function onHit(event) {
	// Engine.log("hit something");
	destroy();
}
// =====================================================


function onTeardown() {
	// Engine.log("tearing down");
	self.removeEventListener(EntityEvent.COLLIDE_FLOOR, onGroundHit);
	self.removeEventListener(EntityEvent.COLLIDE_WALL, onWallHit);
	self.removeEventListener(GameObjectEvent.HIT_DEALT, onHit);
}