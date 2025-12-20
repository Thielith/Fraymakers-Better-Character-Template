// Hitbox stats
{
	//LIGHT ATTACKS
	jab1: {
		hitbox0: {
			damage: 1,
			angle: 80,
			baseKnockback: 20, knockbackGrowth: 5,
			hitstop: -1, selfHitstop: -1,
			limb: AttackLimb.FIST
		}
	},
	jab2: {
		hitbox0: {
			damage: 2,
			angle: 80,
			baseKnockback: 20, knockbackGrowth: 5,
			hitstop: -1, selfHitstop: -1,
			reversibleAngle: false,
			limb: AttackLimb.FIST
		}
	},
	jab3: {
		hitbox0: {
			damage: 1,
			angle: 85,
			baseKnockback: 17, knockbackGrowth: 0,
			hitstop: 1, selfHitstop: 3, hitstopNudgeMultiplier: 0.5,
			reversibleAngle: false,
			limb: AttackLimb.FOOT
		}
	},
	dash_attack: {
		hitbox0: {
			damage: 9,
			angle: 45,
			baseKnockback: 65, knockbackGrowth: 60,
			hitstop: -1, selfHitstop: -1,
			reversibleAngle: false,
			limb: AttackLimb.FOOT
		}
	},	
	tilt_forward: {
		hitbox0: {
			damage: 7,
			angle: 35,
			baseKnockback: 70, knockbackGrowth: 45,
			reversibleAngle: false,
			limb: AttackLimb.FIST
		}
	},
	tilt_up: {
		hitbox0: {
			damage: 3,
			angle: 90,
			baseKnockback: 70, knockbackGrowth: 50,
			reversibleAngle: false,
			limb: AttackLimb.FIST
		},
	},
	tilt_down: {
		hitbox0: {
			damage: 5,
			angle: 65,
			baseKnockback: 65, knockbackGrowth: 35,
			hitstop: -1, selfHitstop: -1,
			reversibleAngle: false,
			limb: AttackLimb.FOOT
		},
		hitbox1: {
			damage: 7,
			angle: 65,
			baseKnockback: 65, knockbackGrowth: 65,
			hitstop: -1, selfHitstop: -1,
			limb: AttackLimb.FOOT
		}
	},

	//STRONG ATTACKS
	strong_forward_attack: {
		hitbox0: {
			damage: 11,
			angle: 40,
			baseKnockback: 60, knockbackGrowth: 75,
			hitstop: -1, selfHitstop: -1,
			reversibleAngle: false,
			limb: AttackLimb.FOOT
		}
	},
	strong_up_attack: {
		hitbox0: {
			damage: 10,
			angle: 90,
			baseKnockback: 70, knockbackGrowth: 65,
			hitstop: -1, hitstopOffset: 3, selfHitstop: -1, selfHitstopOffset: 3,
			hitstun: -1,
			reversibleAngle: false,
			limb: AttackLimb.FIST
		},
		hitbox1: {
			damage: 8,
			angle: 80,
			baseKnockback: 60, knockbackGrowth: 60,
			hitstop: -1,
			hitstun: -1,
			reversibleAngle: false,
			limb: AttackLimb.FIST
		}
	},
	strong_down_attack: {
		hitbox0: {
			damage: 7,
			angle: 270,
			baseKnockback: 85, knockbackGrowth: 65,
			hitstop: -1, selfHitstop: -1,
			buryType: BuryType.BURY, buryTimeBase: 30, buryTimeScaling: 1.5,
			reversibleAngle: false,
			limb: AttackLimb.BODY
		}
	},

	//AERIAL ATTACKS
	aerial_neutral: {
		hitbox0: {  // gets updated on frame 8
			damage: 7,
			angle: SpecialAngle.DEFAULT,
			baseKnockback: 45, knockbackGrowth: 55,
			hitstop: -1, selfHitstop: -1,
			reversibleAngle: false,
			limb: AttackLimb.FOOT
		}
	},
	aerial_forward: {
		hitbox0: {
			damage: 6,
			angle: SpecialAngle.DEFAULT,
			baseKnockback: 60, knockbackGrowth: 45,
			hitstop: -1, selfHitstop: -1,
			reversibleAngle: false,
			limb: AttackLimb.FOOT
		},
		hitbox1: {
			damage: 8,
			angle: SpecialAngle.DEFAULT,
			baseKnockback: 65, knockbackGrowth: 50,
			hitstop: -1, hitstopOffset: 3, selfHitstop: -1, selfHitstopOffset: 3,
			reversibleAngle: false,
			limb: AttackLimb.FOOT
		}
	},
	aerial_back: {
		hitbox0: {
			damage: 5,
			angle: SpecialAngle.DEFAULT,
			baseKnockback: 55, knockbackGrowth: 40,
			hitstop: -1, selfHitstop: -1,
			reversibleAngle: false,
			limb: AttackLimb.FOOT
		},
		hitbox1: {
			damage: 7,
			angle: SpecialAngle.DEFAULT,
			baseKnockback: 65, knockbackGrowth: 50,
			hitstop: -1, hitstopOffset: 3, selfHitstop: -1, selfHitstopOffset: 3,
			reversibleAngle: false,
			limb: AttackLimb.FOOT
		},
	},
	aerial_up: {
		hitbox0: {
			damage: 1,
			angle: SpecialAngle.AUTOLINK_STRONG,
			baseKnockback: 70, knockbackGrowth: 0, knockbackCap: 30, knockbackCapDelay: 4,
			hitstop: 2, hitstopNudgeMultiplier: 0, selfHitstop: 2,
			hitstun: -1,
			reversibleAngle: false,
			tumbleType: TumbleType.NEVER,
			limb: AttackLimb.FIST
		}
	},
	aerial_down: {
		hitbox0: {
			damage: 8,
			angle: 280,
			baseKnockback: 45, knockbackGrowth: 40,
			hitstop: -1, hitstopOffset: 3, selfHitstop: -1, selfHitstopOffset: 3,
			buryType: BuryType.BURY, buryTimeBase: 30, buryTimeScaling: 1.15,
			reversibleAngle: false,
			limb: AttackLimb.FOOT
		},
		hitbox1: {
			damage: 6,
			angle: SpecialAngle.DEFAULT,
			baseKnockback: 50, knockbackGrowth: 45,
			hitstop: -1, selfHitstop: -1,
			reversibleAngle: false,
			limb: AttackLimb.FOOT
		}
	},

	//SPECIAL ATTACKS
	special_neutral: {
		hitbox0: {}
	},
	special_neutral_air: {
		hitbox0: {}
	},
	special_side: {
		hitbox0: {
			damage: 1,
			angle: SpecialAngle.AUTOLINK_STRONGER,
			baseKnockback: 80, knockbackGrowth: 0, knockbackCap: 75,
			hitstop: 2, hitstopNudgeMultiplier: 0, selfHitstop: 2,
			hitstun: -1,
			directionalInfluence: false,
			reversibleAngle: false,
			jabResetType: JabResetType.NEVER,
			limb: AttackLimb.FIST
		},
		hitbox1: {
			damage: 1,
			angle: SpecialAngle.AUTOLINK_STRONGER,
			baseKnockback: 80, knockbackGrowth: 0, knockbackCap: 75,
			hitstop: 2, hitstopNudgeMultiplier: 0, selfHitstop: 2,
			hitstun: -1,
			directionalInfluence: false,
			reversibleAngle: false,
			jabResetType: JabResetType.NEVER,
			limb: AttackLimb.FIST
		},
	},
	special_side_air: {
		hitbox0: {
			damage: 1,
			angle: SpecialAngle.AUTOLINK_STRONGER,
			baseKnockback: 80, knockbackGrowth: 50, knockbackCap: 75,
			hitstop: 2, hitstopNudgeMultiplier: 0, selfHitstop: 2,
			hitstun: -1,
			directionalInfluence: false,
			reversibleAngle: false,
			jabResetType: JabResetType.NEVER,
			limb: AttackLimb.FIST
		},
		hitbox1: {
			damage: 1,
			angle: SpecialAngle.AUTOLINK_STRONGER,
			baseKnockback: 80, knockbackGrowth: 50, knockbackCap: 75,
			hitstop: 2, hitstopNudgeMultiplier: 0, selfHitstop: 2,
			hitstun: -1,
			directionalInfluence: false,
			reversibleAngle: false,
			jabResetType: JabResetType.NEVER,
			limb: AttackLimb.FIST
		},
	},
	special_up: {
		hitbox0: {  // updated on frame 9, 15
			damage: 1,
			angle: SpecialAngle.AUTOLINK_STRONGER,
			baseKnockback: 140, knockbackGrowth: 100, knockbackCap: 140,
			hitstop: 2, hitstopNudgeMultiplier: 0, selfHitstop: 2,
			hitstun: -1,
			directionalInfluence: false,
			reversibleAngle: false,
			limb: AttackLimb.FIST
		}
	},
	special_up_air: {
		hitbox0: {  // updated on frame 9, 15
			damage: 1,
			angle: SpecialAngle.AUTOLINK_STRONGER,
			baseKnockback: 140, knockbackGrowth: 100, knockbackCap: 140,
			hitstop: 2, hitstopNudgeMultiplier: 0, selfHitstop: 2,
			hitstun: -1,
			directionalInfluence: false,
			reversibleAngle: false,
			limb: AttackLimb.FIST
		}
	},
	special_down: {
		hitbox0: {
			damage: 3,
			angle: 90,
			baseKnockback: 85, knockbackGrowth: 30,
			hitstop: -1, selfHitstop: -1
		}
	},
	special_down_air: {
		hitbox0: {
			damage: 3,
			angle: 90,
			baseKnockback: 85, knockbackGrowth: 30,
			hitstop: -1, selfHitstop: -1
		}
	},

	//THROWS
	throw_down: {
		hitbox0: {
			damage: 6,
			angle: 45,
			baseKnockback: 55, knockbackGrowth: 65,
			hitstop: -1, selfHitstop: -1,
			reversibleAngle: false,
			limb: AttackLimb.BODY
		}
	},
	throw_up: {
		hitbox0: {
			damage: 7,
			angle: 95,
			baseKnockback: 55, knockbackGrowth: 65,
			hitstop: -1, selfHitstop: -1,
			reversibleAngle: false,
			limb: AttackLimb.HEAD
		}
	},
	throw_forward: {
		hitbox0: {
			damage: 7,
			angle: 45,
			baseKnockback: 55, knockbackGrowth: 45,
			hitstop: 0, selfHitstop: 0,
			reversibleAngle: false,
			hitSoundOverride: "#n/a",
			hitEffectOverride: "#n/a",
			cameraShakeType: CameraShakeType.NONE
		}
	},
	throw_back: { 
		hitbox0: {
			damage: 7,
			angle: 145,
			baseKnockback: 55, knockbackGrowth: 45,
			hitstop: 0, selfHitstop: 0,
			reversibleAngle: false,
			hitSoundOverride: "#n/a",
			hitEffectOverride: "#n/a",
			cameraShakeType: CameraShakeType.NONE
		}
	},
	
	//MISC ATTACKS
	ledge_attack: {
		hitbox0: {
			damage: 8,
			angle: SpecialAngle.DEFAULT,
			baseKnockback: 40, knockbackGrowth: 60,
			hitstop: -1, selfHitstop: -1,
			reversibleAngle: false,
			limb: AttackLimb.FOOT
		},
		hitbox1: {
			damage: 8,
			angle: SpecialAngle.DEFAULT,
			baseKnockback: 40, knockbackGrowth: 60,
			hitstop: -1, selfHitstop: -1,
			reversibleAngle: false,
			limb: AttackLimb.FOOT
		},
	},
	crash_attack: {
		hitbox0: {
			damage: 6,
			angle: 35,
			baseKnockback: 70, knockbackGrowth: 25,
			hitstop: -1, selfHitstop: -1,
			reversibleAngle: false,
			limb: AttackLimb.FOOT
		}
	},
	emote: {
		hitbox0: {}
	}

	//UNUSED ATTACKS (Example attacks that are currently not used. You can rename the HitboxStats and the animation if you'd like to replace an existing animation.)
	/*
	aerial_neutral (multi-hit): {
		hitbox0: {  // gets updated on frame 12
			damage: 1,
			angle: 40,
			baseKnockback: 60, knockbackGrowth: 0,
			hitstop: -1, selfHitstop: -1,
			reversibleAngle: false,
			limb: AttackLimb.FOOT
		},
		hitbox1: {  // gets updated on frame 12
			damage: 1,
			angle: 40,
			baseKnockback: 60, knockbackGrowth: 0,
			hitstop: -1, selfHitstop: -1,
			reversibleAngle: false,
			limb: AttackLimb.FOOT
		},
	},
	*/
}
