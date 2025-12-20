// API Script for Character Template Projectile

var X_SPEED = 7; // X speed of water
var Y_SPEED = -7; // Y Speed of water

// Instance vars
var life = self.makeInt(60 * 5);
var originalOwner = null;

function initialize() {
	self.addEventListener(EntityEvent.COLLIDE_FLOOR, onGroundHit, { persistent: true });
	self.addEventListener(GameObjectEvent.HIT_DEALT, onHit, { persistent: true });

	// Set up horizontal reflection
	Common.enableReflectionListener({ mode: "X", replaceOwner: true });

	self.setCostumeIndex(self.getOwner().getCostumeIndex());
	self.setState(PState.ACTIVE);
	self.setXSpeed(X_SPEED);
	self.setYSpeed(Y_SPEED);
}

function destroy() {
	// Engine.log("destroy!");
	self.toState(PState.DESTROYING);
}

function onGroundHit(event) {
	// Engine.log("hit ground");
	destroy();
}

function onHit(event) {
	// Engine.log("hit something");
	destroy();
}

function update() {
	if (self.inState(PState.ACTIVE)) {
		life.dec();
		if (life.get() <= 0) {
			// Engine.log("going to die now");
			destroy();
		}
	}
} 

function onTeardown() {
	// Engine.log("tearing down");
	self.removeEventListener(EntityEvent.COLLIDE_FLOOR, onGroundHit);
	self.removeEventListener(GameObjectEvent.HIT_DEALT, onHit);
}