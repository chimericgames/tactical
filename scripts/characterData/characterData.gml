// Randomize game seed
randomize();

// Constants
global.initialActionDelay = 5; // The delay at the start of combat
global.menuDelay = 2; // The delay after selecting a unit's action
global.actionDelay = 30; // Delay after actions
global.critDamage = 1.5;
global.baseHitChance = .65;
global.minHitChance = .05;
global.swiftnessVariance = 1.5; // Slightly randomizes turn order
global.battleLog = [];
global.gameOver = false;
global.derivedStatMultiplier = 2; // Makes attack, defense, and hitpoints larger for ease of use and interest
global.viciousCounterMult = 2;
global.viciousCounterCritRateBonus = 25;


// Passive abilities
global.passives =
{
	guardian :
	{
		name : "Guardian",
		description : "Once per turn while defending, takes an attack for an adjacent ally.",
	},		
	viciousCounter :
	{
		name : "Vicious Counter",
		description : "While defending, counter attacks deal double damage and have an increased chance to be critical strikes.",
	},			
	predator :
	{
		name : "Predator",
		description : "",
	},				
	sunderer :
	{
		name : "Sunderer",
		description : "",
	},				
	sharpReflexes :
	{
		name : "Sharp Reflexes",
		description : "",
	},			
	perniciousHorticulturist :
	{
		name : "Pernicious Horticulturist",
		description : "Poison items have a 50% chance to not consume a charge when used. Poisoned targets are also enfeebled.",
	},				
	beguiling :
	{
		name : "Beguiling",
		description : "",
	},				
	unyielding :
	{
		name : "Unyielding",
		description : "",
	},				
	unstoppable :
	{
		name : "Unstoppable",
		description : "",
	},				
	firebug :
	{
		name : "Firebug",
		description : "Fire items have a 50% chance to not consume a charge when used. Ignites have increased damage.",
	},				
	irrepressible :
	{
		name : "Irrepressible",
		description : "Unaffected by the effects of bad morale and the effects of good morale are increased.",
	},	
	falconer :
	{
		name : "Falconer",
		description : "",
	},
	herbalist :
	{
		name : "Herbalist",
		description : "",
	},
	aerialist :
	{
		name : "Aerialist",
		description : "Trigger a wing attack on position change.",
	},
	spiritWard :
	{
		name : "Spirit Ward",
		description : "When taking elemental or spirit damage, consume mana to resist half of the damage.",
	},
	berserker :
	{
		name : "Berserker",
		description : "Damage taken converts endurance to strength, consuming mana, provided endurance exceeds 1.",
	},
	pulverize :
	{
		name : "Pulverize",
		description : "Attacks against stunned enemies ignore all armor.",
	},
	benediction :
	{
		name : "Benediction",
		description : "Mana spent is converted to hitpoints healed for allies.",
	},	
	fateBinder :
	{
		name : "Fate Binder",
		description : "Increases the chances that allies cling to conciousness when their hitpoints are depleted.",
	},
	herosJourney :
	{
		name : "Hero's Journey",
		description : "Receives double the benefits from training and increased benefits from combat buffs.",
	},	
	survivor :
	{
		name : "Survivor",
		description : "Attack and defense is increased for each downed ally.",
	},		
}

global.adventurePassives =
{

	fletcher : 
	{
		name : "Fletcher",
		description : "Creates a random quiver of arrows while the party camps.",
	},

	overwatch :
	{
		name : "Overwatch", 
		description : "Reduces the chances of being ambushed while increasing the chances of ambushing enemies while scouting.",
	},
	
	rousingVerse :
	{
		name : "Rousing Verse", 
		description : "Reduces the effects of low morale and increases the effects of good morale after camping.",	// Can reduce and increase always be 25%?
	},

	fateWeaver :
	{
		name : "Fate Weaver", 
		description : "Increases the chances of favorable outcomes while adventuring.",
	},
	
	inspirational :
	{
		name : "Inspirational", 
		description : "Increases party morale and chance to resist being downed while leading",
	},	

}

// Items
global.items = 
{
	
	drinkingHorn :
	{
		name : "Carved Drinking Horn",
		description : "",
		charges : 4,
		isBattleChoice : true,
	},
	
	wineSkin :
	{
		name : "Enchanted Wineskin",
		description : "",
		charges : infinity,
		isBattleChoice : true,
	},
	
	shatteredShackles :
	{
		name : "Shattered Shackles",
		description : "",
		charges : -1,
		isBattleChoice : false,			
	},
	
	herbalBalm :
	{
		name : "Herbal Balm",
		description : "",
		charges : 4,
		isBattleChoice : true,
	},
	
	furyDraught :
	{
		name : "Fury Draught",
		description : "",
		charges : 2,
		isBattleChoice : true,
	},
	
	woad :
	{
		name : "Woad",
		description : "",
		charges : -1,
		isBattleChoice : false,
	},
	
	witbaneToxin :
	{
		name : "Witbane Toxin",
		description : "",
		charges : 4,
		isBattleChoice : true,
	},
	
	nectarUnguent :
	{
		name : "Nectar Unguent",
		description : "",
		charges : 4,
		isBattleChoice : false,
	},
	
	fieldMedkit :
	{
		name : "Field Medkit",
		description : "",
		charges : 4,
		isBattleChoice : true,
	},
	
	whetstone :
	{
		name : "Whetstone",
		description : "",
		charges : -1,
		isBattleChoice : false,
	},
	
	pitchFlask :
	{
		name : "Pitch Flask",
		description : "",
		charges : 1,
		isBattleChoice : true,
	},
	
	falconryGauntlet :
	{
		name : "Falconry Gauntlet",
		description : "",
		charges : -1,
		isBattleChoice : false,		
	},
	
	galeCharm :
	{
		name : "Gale Charm",
		description : "Consume charge: Blasts the user to the rear position and deals elemental damage to the enemy front row.",
		charges : 2,
		isBattleChoice : true,
	},
	
	runicTalisman :
	{
		name : "Runic Talisman",
		description : "Gains a charge whenever its bearer takes their combat turn or takes non-physical damage. Adds spirit damage to the bearer's attacks, up to the number of charges",
		charges : 0,
		isBattleChoice : true,
	},
	
	greathartReigns :
	{
		name : "greathartReigns",
		description : "Restores 1 hp per combat turn. Doubles the chances of resisting being downed once per battle.",
		charges : -1,
		isBattleChoice : false,
	},
	
	greathartReigns :
	{
		name : "greathartReigns",
		description : "Restores 1 hp per combat turn. Doubles the chances of resisting being downed once per battle.",
		charges : -1,
		isBattleChoice : false,
	},
	
	broadheadQuiver :	// Acatl makes these 30% of the time
	{
		name : "Broadhead Arrow Quiver",
		description : "A quiver containing specialized arrows designed for bleeding out big game.", // +1 damage, +2 bleeding
		charges : 6,
		isBattleChoice : false,
	},
	
	poisonedQuiver :	// Acatl makes these 20% of the time
	{
		name : "Poisoned Arrow Quiver",
		description : "A quiver containing specialized arrows designed to deliver a fast-acting poison.", // +4 poison
		charges : 6,
		isBattleChoice : false,
	},
	
	incendiaryQuiver :	// Acatl makes these 20% of the time
	{
		name : "Incendiary Arrow Quiver",
		description : "A quiver containing specialized arrows designed to be ignited.", // +4 fire
		charges : 6,
		isBattleChoice : false,
	},
	
	bodkinQuiver :	// Acatl makes these 20% of the time
	{
		name : "Bodkin Arrow Quiver",
		description : "A quiver containing specialized arrows designed to penetrate light armor.", // +2 penetration
		charges : 6,
		isBattleChoice : false,
	},
	
	explosiveQuiver :	// Acatl makes these 10% of the time
	{
		name : "Bodkin Arrow Quiver",
		description : "A quiver containing specialized arrows designed to penetrate light armor.", // +2 penetration
		charges : 6,
		isBattleChoice : false,
	},		
	
}	

// Active abilities
global.battleChoices =
{
	attack :
	{
		name: "Attack",
		manaCost : 0,
		description : "",
	},
	defend : 
	{
		name: "Defend",
		manaCost : 0,
		description : "",		
	},	
	weaponSwap :
	{
		name: "Swap Weapons",
		manaCost : 0,
		description : "",		
	},	
	position :
	{
		name: "Position",
		manaCost : 0,
		description : "",		
	},	
	retreat :
	{
		name: "Retreat",
		manaCost : 0,
		description : "",		
	},	
	none :
	{
		name: "None",
		manaCost : 0,
		description : "",		
	},		
	rally :
	{
		name: "Rally",
		manaCost : 1,
		description : "The active character and a target ally attack a target simultaneously, combining their attack power.",
	},	
	deadeye :
	{
		name: "Deadeye",
		manaCost : 1,
		description : "",		
	},	
	thorns :
	{
		name: "Thorns",
		manaCost : 1,
		description : "",		
	},	
	cryHavoc :
	{
		name: "Cry Havoc",
		manaCost : 1,
		description : "",		
	},	
	ignite :
	{
		name: "Ignite",
		manaCost : 1,
		description : "",		
	},	
	harry :
	{
		name : "Harry",
		manaCost : 1,
		description : "",		
	},
	tailWind :
	{
		name : "Tail Wind",
		manaCost : 1,
		description : "",		
	},	
	batteringRam :
	{
		name : "Battering Ram",
		manaCost : 0,
		description : "Attacks with horns from the back row with increased chance to stun while changing position to the front row.",		
	},
	sanctuary :
	{
		name : "Sanctuary",
		manaCost : 1,
		description : "Prevents a quarter of elemental damage dealt to allies. Damage prevented in this way is reflected to foes with doubled damage.",
	},
	lashOut :
	{
		name : "Lash Out",	
		manaCost : 1,
		description : "A desperate attack that adds random damage up to the attacker's missing hitpoints.",
	}
}

// Weapon properties to derive stats from
global.weaponProperties = 
{
	
	base:
	{
		damage : 5,
		crit : 0,
		wieldiness : 0,
		penetration : 0,
		bleed : 0,
		stun : 0,
		range : 0,
		hits : 1,
		encumbrance : -1,
		armorProtection : 0,
		elementalProtection : 0,		
	},
	
	slashing:
	{
		damage : 0,
		crit : 0,
		wieldiness : .5,
		penetration : 0,
		bleed : 2,
		stun : 0,
		range : 0,
		hits : 0,
		encumbrance : 0,
		armorProtection : 0,
		elementalProtection : 0,			
	},

	piercing:
	{
		damage : 0,
		crit : .5,
		wieldiness : 1,
		penetration : 0,
		bleed : 1,
		stun : 0,
		range : 0,
		hits : 0,
		encumbrance : 0,
		armorProtection : 0,
		elementalProtection : 0,			
	},
	
	splitting:
	{
		damage : 1,
		crit : 0,
		wieldiness : -1,
		penetration : .1,
		bleed : 0,
		stun : .5,
		range : 0,
		hits : 0,
		encumbrance : 0,
		armorProtection : 0,
		elementalProtection : 0,			
	},
	
	crushing:
	{
		damage : -1,
		crit : -1,
		wieldiness : 0,
		penetration : .25,
		bleed : -1,
		stun : 1,
		range : 0,
		hits : 0,
		encumbrance : 0,
		armorProtection : 0,
		elementalProtection : 0,			
	},
	
	pole:
	{
		damage : 0,
		crit : 0,
		wieldiness : 0,
		penetration : 0,
		bleed : 0,
		stun : 0,
		range : 1,
		hits : 0,
		encumbrance : -.5,
		armorProtection : 0,
		elementalProtection : 0,			
	},
	
	thrownLight:
	{
		damage : 0,
		crit : 0,
		wieldiness : -2,
		penetration : 0,
		bleed : 0,
		stun : 0,
		range : 2,
		hits : 0,
		encumbrance : 0,
		armorProtection : 0,
		elementalProtection : 0,			
	},
	
	thrownHeavy:
	{
		damage : 0,
		crit : 0,
		wieldiness : -1,
		penetration : 0,
		bleed : 0,
		stun : 0,
		range : 2,
		hits : 0,
		encumbrance : -.5,
		armorProtection : 0,
		elementalProtection : 0,			
	},
	
	missile:
	{
		damage : 0,
		crit : 0,
		wieldiness : -1,
		penetration : 0,
		bleed : 0,
		stun : 0,
		range : 2,
		hits : 0,
		encumbrance : -.5,
		armorProtection : 0,
		elementalProtection : 0,			
	},

	verySmall:
	{
		damage : -2,
		crit : 1,
		wieldiness : 0,
		penetration : 0,
		bleed : 0,
		stun : -1,
		range : 0,
		hits : 0,
		encumbrance : 1,
		armorProtection : 0,
		elementalProtection : 0,			
	},
	
	small:
	{
		damage : -1,
		crit : .5,
		wieldiness : 0,
		penetration : 0,
		bleed : 0,
		stun : -.5,
		range : 0,
		hits : 0,
		encumbrance : .5,
		armorProtection : 0,
		elementalProtection : 0,			
	},
	
	large:
	{
		damage : 1,
		crit : -.5,
		wieldiness : -.5,
		penetration : .05,
		bleed : 0,
		stun : .5,
		range : 0,
		hits : 0,
		encumbrance : -.5,
		armorProtection : 0,
		elementalProtection : 0,			
	},
	
	great:
	{
		damage : 2,
		crit : -1,
		wieldiness : -1,
		penetration : .1,
		bleed : 0,
		stun : 1,
		range : 0,
		hits : 0,
		encumbrance : -1,
		armorProtection : 0,
		elementalProtection : 0,			
	},
	
	dual:
	{
		damage : 0,
		crit : 0,
		wieldiness : -1,
		penetration : 0,
		bleed : 0,
		stun : 0,
		range : 0,
		hits : 1,
		encumbrance : -1,
		armorProtection : 0,
		elementalProtection : 0,			
	},
	
	flesh:
	{
		damage : -2,
		crit : 0,
		wieldiness : 0,
		penetration : 0,
		bleed : 0,
		stun : 0,
		range : 0,
		hits : 0,
		encumbrance : 1,
		armorProtection : 0,
		elementalProtection : 0,			
	},
	
	disabling:
	{
		damage : -1,
		crit : -1,
		wieldiness : 0,
		penetration : 0,
		bleed : 0,
		stun : 1.5,
		range : 0,
		hits : 0,
		encumbrance : 0,
		armorProtection : 0,
		elementalProtection : 0,			
	},	
	
// Shield -3 damage, -2 crit, +2 armor, +2 elemental protection
// Great shield: +1 damage, +1 armor, +1 elemental protection (compared to shield)	

}


global.weapons =
{
	
	fists :
	{
		tags : [ global.weaponProperties.crushing, global.weaponProperties.dual, global.weaponProperties.verySmall, global.weaponProperties.flesh ],
	},
	
	piercingTeeth :
	{
		tags : [ global.weaponProperties.piercing, global.weaponProperties.small ],
	},	
	
	terribleClaws :
	{
		tags : [ global.weaponProperties.slashing, global.weaponProperties.dual, global.weaponProperties.verySmall ],
	},	
	
	monsterWings :
	{
		tags : [ global.weaponProperties.crushing, global.weaponProperties.flesh, global.weaponProperties.large, global.weaponProperties.pole ],
	},

	monsterHorns :
	{
		tags : [ global.weaponProperties.crushing ],
	},

	sword :
	{
		tags : [ global.weaponProperties.slashing ],
	},
	
	heavySword :
	{
		tags : [ global.weaponProperties.slashing, global.weaponProperties.large ],
	},	

	spear :
	{
		tags : [ global.weaponProperties.piercing, global.weaponProperties.pole ],
	},
	
	axe :
	{
		tags : [ global.weaponProperties.splitting ],
	},	
	
	poleAxe :
	{
		tags : [ global.weaponProperties.splitting, global.weaponProperties.pole, global.weaponProperties.large ],
	},		
	
	mace :
	{
		tags : [ global.weaponProperties.crushing ],
	},		
		
	eztli : // Eztli is a trained microraptor
	{
		tags : [ global.weaponProperties.slashing, global.weaponProperties.dual, global.weaponProperties.verySmall, global.weaponProperties.missile],
	},	
	
	shortbow : 
	{
		tags : [ global.weaponProperties.piercing, global.weaponProperties.missile, global.weaponProperties.small ],
	},		

	recurveBow : 
	{
		tags : [ global.weaponProperties.piercing, global.weaponProperties.missile ],
	},

	longbow : 
	{
		tags : [ global.weaponProperties.piercing, global.weaponProperties.missile, global.weaponProperties.large ],
	},
	
	greatBow :
	{
		tags : [ global.weaponProperties.piercing, global.weaponProperties.missile, global.weaponProperties.great ],
	},		
	
	greatSword : 
	{
		tags : [ global.weaponProperties.slashing, global.weaponProperties.great ],
	},
	
	greatMace : 
	{
		tags : [ global.weaponProperties.crushing, global.weaponProperties.great ],
	},	
	
	greatAxe : 
	{
		tags : [ global.weaponProperties.splitting, global.weaponProperties.great ],
	},	
	
	shortSwords : 
	{
		tags : [ global.weaponProperties.slashing, global.weaponProperties.dual, global.weaponProperties.small ],
	},	
	
	dagger : 
	{
		tags : [ global.weaponProperties.piercing, global.weaponProperties.verySmall ],
	},
	
	combatKnives : 
	{
		tags : [ global.weaponProperties.slashing, global.weaponProperties.dual, global.weaponProperties.verySmall ],
	},		
	
	thrownBlade : 
	{
		tags : [ global.weaponProperties.piercing, global.weaponProperties.verySmall, global.weaponProperties.thrownLight ],
	},
	
	thrownAxe : 
	{
		tags : [ global.weaponProperties.splitting, global.weaponProperties.small, global.weaponProperties.thrownHeavy ],
	},	

	bolas : 
	{
		tags : [ global.weaponProperties.crushing, global.weaponProperties.small, global.weaponProperties.thrownLight, global.weaponProperties.disabling ],
	},	

	mediumShield : 
	{
		damage : 1,
		range : Range.Short,
		hits : 1,
		damageType : DamageTypes.Crushing,
		wieldiness : 0,
		crit : -2,
		armorProtection : 2,
		elementalProtection : 2
	},		
	
	largeShield : 
	{
		damage : 2,
		range : Range.Short,
		hits : 1,
		damageType : DamageTypes.Crushing,
		wieldiness : 0,
		crit : -2,
		armorProtection : 3,
		elementalProtection : 3,
	},	

	greatShield : 
	{
		damage : 4,
		range : Range.Short,
		hits : 1,
		damageType : DamageTypes.Crushing,
		wieldiness : 0,
		crit : -3,
		armorProtection : 4,
		elementalProtection : 4,
	},	


}

calculateWeaponStats(global.weapons.fists);
calculateWeaponStats(global.weapons.piercingTeeth);
calculateWeaponStats(global.weapons.terribleClaws);
calculateWeaponStats(global.weapons.monsterWings);
calculateWeaponStats(global.weapons.monsterHorns);
calculateWeaponStats(global.weapons.sword);
calculateWeaponStats(global.weapons.heavySword);
calculateWeaponStats(global.weapons.spear);
calculateWeaponStats(global.weapons.axe);
calculateWeaponStats(global.weapons.poleAxe);
calculateWeaponStats(global.weapons.mace);
calculateWeaponStats(global.weapons.eztli);
calculateWeaponStats(global.weapons.shortbow);
calculateWeaponStats(global.weapons.recurveBow);
calculateWeaponStats(global.weapons.longbow);
calculateWeaponStats(global.weapons.greatBow);
calculateWeaponStats(global.weapons.greatSword);
calculateWeaponStats(global.weapons.greatMace);
calculateWeaponStats(global.weapons.greatAxe);
calculateWeaponStats(global.weapons.shortSwords);
calculateWeaponStats(global.weapons.dagger);
calculateWeaponStats(global.weapons.combatKnives);
calculateWeaponStats(global.weapons.thrownBlade);
calculateWeaponStats(global.weapons.thrownAxe);
calculateWeaponStats(global.weapons.bolas);

// Armors
global.armors =
{
	none :
	{
		weight : 0,		
		armorProtection : 0,
		elementalProtection : 0,
		evasionBonus : 0,
	},
	
	light :
	{
		weight : 1,
		armorProtection : 1,
		elementalProtection : 2,
		evasionBonus : 0,
	},

	medium :
	{
		weight : 2,
		armorProtection : 2,
		elementalProtection : 1,
		evasionBonus : 0,
	},
	
	heavy :
	{
		weight : 3,
		armorProtection : 3,
		elementalProtection : 0,
		evasionBonus : 0,
	},
	
	monsterArmorEvasion :
	{
		weight : 0,		
		armorProtection : 1,
		elementalProtection : 2,
		evasionBonus : 2,
	},
	
}		


function calculateWeaponStats(weaponName)
{
	var weapon = weaponName;
	var weaponTags = array_length(weapon.tags);
	
	// Damage
	weapon.damage = global.weaponProperties.base.damage;
	for (var i = 0; i < weaponTags; ++i) 
	{
		var weaponProperty = weapon.tags[i];
		weapon.damage += weaponProperty.damage;
		weapon.damage = max(weapon.damage, 0);
	}
	
	// Crit
	weapon.crit = global.weaponProperties.base.crit;
	for (var i = 0; i < weaponTags; ++i) 
	{
		var weaponProperty = weapon.tags[i];
		weapon.crit += weaponProperty.crit;
	}
	
	// Wieldiness
	weapon.wieldiness = global.weaponProperties.base.wieldiness;
	for (var i = 0; i < weaponTags; ++i) 
	{
		var weaponProperty = weapon.tags[i];
		weapon.wieldiness += weaponProperty.wieldiness;
	}	
	
	// Penetration
	weapon.penetration = global.weaponProperties.base.penetration;
	for (var i = 0; i < weaponTags; ++i) 
	{
		var weaponProperty = weapon.tags[i];
		weapon.penetration += weaponProperty.penetration;
	}
	
	// Bleed
	weapon.bleed = global.weaponProperties.base.bleed;
	for (var i = 0; i < weaponTags; ++i) 
	{
		var weaponProperty = weapon.tags[i];
		weapon.bleed += weaponProperty.bleed;
	}		
		
	// Stun
	weapon.stun = global.weaponProperties.base.stun;
	for (var i = 0; i < weaponTags; ++i) 
	{
		var weaponProperty = weapon.tags[i];
		weapon.stun += weaponProperty.stun;
	}
	
	// Range
	weapon.range = global.weaponProperties.base.range;
	for (var i = 0; i < weaponTags; ++i) 
	{
		var weaponProperty = weapon.tags[i];
		weapon.range += weaponProperty.range;
	}	
	
	// Hits
	weapon.hits = global.weaponProperties.base.hits;
	for (var i = 0; i < weaponTags; ++i) 
	{
		var weaponProperty = weapon.tags[i];
		weapon.hits += weaponProperty.hits;
	}	
	
	// Encumbrance
	weapon.encumbrance = global.weaponProperties.base.encumbrance;
	for (var i = 0; i < weaponTags; ++i) 
	{
		var weaponProperty = weapon.tags[i];
		weapon.encumbrance += weaponProperty.encumbrance;
	}
	
	// Armor Protection
	weapon.armorProtection = global.weaponProperties.base.armorProtection;
	for (var i = 0; i < weaponTags; ++i) 
	{
		var weaponProperty = weapon.tags[i];
		weapon.armorProtection += weaponProperty.armorProtection;
	}
	
	// Elemental Protection
	weapon.elementalProtection = global.weaponProperties.base.elementalProtection;
	for (var i = 0; i < weaponTags; ++i) 
	{
		var weaponProperty = weapon.tags[i];
		weapon.elementalProtection += weaponProperty.elementalProtection;
	}	
	
}

calculateWeaponStats(global.weapons.greatAxe);


// Characters
global.characters =
{
	
	sigrid :
	{
		name : "Sigrid",
		race : "Human",
		alignment : Alignment.Friend,
		size : Size.Normal,
		weapon1 : global.weapons.spear,
		weapon1Name : "Inlaid Iron Spear",
		weapon2 : global.weapons.largeShield,
		weapon2Name : "Iron-Studded Round Shield",
		armor : global.armors.medium,
		armorName : "Fur-Lined Plate and Hide",
		strength : 5,
		spirit : 2, 
		endurance : 7,
		technique : 6,
		swiftness : 3,
		vitality : 5,
		willpower : 5,
		active : global.battleChoices.rally,
		passive : [ global.passives.guardian, global.passives.viciousCounter ],
		items : [ global.items.drinkingHorn, global.items.herbalBalm ],
		// Adventure skills
		leadership : Skill.Masterful,
		scouting : Skill.Poor,
		huntingGathering : Skill.Decent,
		cooking : Skill.Decent,
		adventurePassive : [],
		//protects : [],
	},
	
	ceres :
	{
		name : "Ceres",
		race : "Centaur",
		alignment : Alignment.Friend,
		size : Size.Large,
		weapon1 : global.weapons.greatBow,
		weapon1Name : "Great Bow",
		weapon2 : global.weapons.greatMace,
		weapon2Name : "Great Flail",
		armor : global.armors.light,
		armorName : "Stalker's Leathers",
		strength : 6,
		spirit : 3, 
		endurance : 5,
		technique : 5,
		swiftness : 4,
		vitality : 6,
		willpower : 3,
		active : global.battleChoices.deadeye,
		passive : [ global.passives.predator, global.passives.sunderer ],
		items : [ global.items.furyDraught, global.items.woad ],
		// Adventure skills
		leadership : Skill.Poor,
		scouting : Skill.Skilled,
		huntingGathering : Skill.Skilled,
		cooking : Skill.Decent,
		adventurePassive : [],
		//protects : [],
	},
	
	// Shelve ceres in favor of a poison-oriented cervitaur friend for thistle
	
	thistle :
	{
		name : "Thistle",
		race : "Nymph",
		alignment : Alignment.Friend,
		size : Size.Normal,
		weapon1 : global.weapons.thrownBlade,
		weapon1Name : "Throwing Knives",
		weapon2 : global.weapons.combatKnives,		
		weapon2Name : "Kukri",
		armor : global.armors.none,
		armorName : "Sylvan Wrap",
		strength : 2,
		spirit : 3, 
		endurance : 2,
		technique : 6,
		swiftness : 7,
		vitality : 4,
		willpower : 2,
		active : global.battleChoices.thorns,
		passive : [ global.passives.sharpReflexes, global.passives.perniciousHorticulturist ],
		items : [ global.items.witbaneToxin, global.items.nectarUnguent ],
		// Adventure skills
		leadership : Skill.Dismal,
		scouting : Skill.Masterful,
		huntingGathering : Skill.Skilled,
		cooking : Skill.Decent,
		adventurePassive : [],		
		//protects : [],
	},
	
	cassiel :
	{
		name : "Cassiel",
		race : "Human",
		alignment : Alignment.Friend,
		size : Size.Normal,
		weapon1 : global.weapons.greatSword,
		weapon1Name : "Etched Greatsword",
		weapon2 : global.weapons.fists,		
		weapon2Name : "Nothing",
		armor : global.armors.heavy,
		armorName : "Engraved Full Plate and Wrap Cloak",
		strength : 7,
		spirit : 4, 
		endurance : 6,
		technique : 4,
		swiftness : 3,
		vitality : 8,
		willpower : 7,
		active : global.battleChoices.cryHavoc,
		passive : [ global.passives.unyielding, global.passives.unstoppable ],
		items : [ global.items.fieldMedkit, global.items.whetstone ],
		// Adventure skills
		leadership : Skill.Skilled,
		scouting : Skill.Poor,
		huntingGathering : Skill.Poor,
		cooking : Skill.Skilled,
		adventurePassive : [],
		//protects : [],
	},	
	
	citalli :
	{
		name : "Citalli",
		race : "Human",
		alignment : Alignment.Friend,
		size : Size.Normal,
		weapon1 : global.weapons.longbow,
		weapon1Name : "Blackened Longbow",
		weapon2 : global.weapons.dagger,
		weapon2Name : "Obsidian Dagger",
		armor : global.armors.light,
		armorName : "Cotton Tunic",
		strength : 4,
		spirit : 5, 
		endurance : 3,
		technique : 8,
		swiftness : 5,
		vitality : 3,
		willpower : 1,
		active : global.battleChoices.ignite,
		passive : [ global.passives.firebug, global.passives.irrepressible ],
		items : [ global.items.pitchFlask, global.items.incendiaryQuiver ],
		// Adventure skills
		leadership : Skill.Decent,
		scouting : Skill.Skilled,
		huntingGathering : Skill.Masterful,
		cooking : Skill.Poor,
		adventurePassive : [],		
		//protects : [ global.characters.acatl ],
	},		
	
	acatl :
	{
		name : "Acatl",
		race : "Human",
		alignment : Alignment.Friend,
		size : Size.Normal,
		weapon1 : global.weapons.eztli, // Eztli is a trained microraptor
		weapon1Name : "Eztli",
		weapon2 : global.weapons.mediumShield,
		weapon2Name : "Deerskin Feathered Shield",
		armor : global.armors.light,
		armorName : "Worn Poncho",
		strength : 3,
		spirit : 5,
		endurance : 4,
		technique : 5,
		swiftness : 4,
		vitality : 4,
		willpower : 3,
		active : global.battleChoices.harry,
		passive : [ global.passives.falconer, global.passives.herbalist ],
		items : [ global.items.falconryGauntlet , global.items.herbalBalm ],
		// Adventure skills
		leadership : Skill.Poor,
		scouting : Skill.Decent,
		huntingGathering : Skill.Skilled,
		cooking : Skill.Masterful,
		adventurePassive : [ global.adventurePassives.fletcher ],
		//protects : [], // His pet
	},
	
	/* I need a monster for Acatl
	? :
	{
		name : "?",
		race : "Dinosaur",
		alignment : Alignment.Foe,
		size : Size.Normal,
		weapon1 : global.weapons.terribleClaws,
		weapon1Name : "Terrible Claws",
		weapon2 : global.weapons.piercingTeeth,
		weapon2Name : "Piercing Teeth",
		armor : global.armors.light,
		armorName : "Feathered hide",
		strength : 7,
		spirit : 2, 
		endurance : 5,
		technique : 6,
		swiftness : 7,
		vitality : 7,
		active : global.battleChoices.none,
		passive : [ ],
		items : [ ]		
	},		
	*/
	
	demi :
	{
		name : "Demi",
		race : "Harpy",
		alignment : Alignment.Friend,
		size : Size.Normal,
		weapon1 : global.weapons.monsterWings,
		weapon1Name : "Avian Wings",		
		weapon2 : global.weapons.terribleClaws,
		weapon2Name : "Hooked Talons",
		armor : global.armors.monsterArmorEvasion,
		armorName : "Dazzling Plumage",
		strength : 4,
		spirit : 7,
		endurance : 2,
		technique : 5,
		swiftness : 4,
		vitality : 4,
		willpower : 4,
		active : global.battleChoices.tailWind,
		passive : [ global.passives.aerialist, global.passives.spiritWard ],
		items : [ global.items.galeCharm ],
		// Adventure skills
		leadership : Skill.Poor,
		scouting : Skill.Masterful,
		huntingGathering : Skill.Skilled,
		cooking : Skill.Catastrophic,
		adventurePassive : [ global.adventurePassives.overwatch ],
		//protects : [ global.characters.alkimos ],
	},
	
	alkimos : // Berserker-poet satyr and lifelong friend of the harpy, Demi
	// Notes: Or maybe they both escaped from servitude
	{
		name : "Alkimos",
		race : "Satyr",
		alignment : Alignment.Friend,
		size : Size.Normal,
		weapon1 : global.weapons.axe, 
		weapon1Name : "Bearded Axe",
		weapon2 : global.weapons.monsterHorns,
		weapon2Name : "Spiral Greathorns",
		armor : global.armors.monsterArmorEvasion,
		armorName : "Hirsuit Hide",
		strength : 3,
		spirit : 1,
		endurance : 7,
		technique : 4,
		swiftness : 3,
		vitality : 7,
		willpower : 5,
		active : global.battleChoices.batteringRam,
		passive : [ global.passives.berserker, global.passives.pulverize ],
		items : [ global.items.wineSkin, global.items.shatteredShackles ],	// Alkimos' shackles are detrimental to technique and need to be removed by a smith
		// Adventure skills
		leadership : Skill.Decent,
		scouting : Skill.Skilled,
		huntingGathering : Skill.Skilled,
		cooking : Skill.Poor,
		adventurePassive : [ global.adventurePassives.rousingVerse ],		
		//protects : [ global.characters.demi ],
	},

	helle : // Megaloceros-mounted highland seidr worker
	// Notes: Helle has a lot of unique powers granted by her loadout at the cost of having locked item slots combined with taking up 2 party slots
	// Helle's unique shield restores mana by blocking nonphysical attacks
	{
		name : "Helle",
		race : "Human",
		alignment : Alignment.Friend,
		size : Size.Large,
		weapon1 : global.weapons.poleAxe, 
		weapon1Name : "Crescent Poleaxe",
		weapon2 : global.weapons.greatShield,
		weapon2Name : "Bone-Charmed Greatshield",	// Unique
		armor : global.armors.medium,
		armorName : "Fateweaver's Regalia",
		strength : 4,
		spirit : 6,
		endurance : 2,
		technique : 4,
		swiftness : 5,
		vitality : 4,
		willpower : 6,
		active : global.battleChoices.sanctuary,
		passive : [ global.passives.benediction, global.passives.fateBinder ],
		items : [ global.items.runicTalisman, global.items.greathartReigns ],	// These items are locked
		// Adventure skills
		leadership : Skill.Skilled,
		scouting : Skill.Skilled,
		huntingGathering : Skill.Skilled,
		cooking : Skill.Skilled,
		adventurePassive : [ global.adventurePassives.fateWeaver ],		
		//protects : [  ],
	},

	ilse :
	{
		name : "Ilse",
		race : "Human",
		alignment : Alignment.Friend,
		size : Size.Normal,
		weapon1 : global.weapons.heavySword, 
		weapon1Name : "Heirloom Longsword, 'Fable'",
		weapon2 : global.weapons.bolas,
		weapon2Name : "Braided Bolas",
		armor : global.armors.light,
		armorName : "Reinforced Fur-Lined Coat",
		strength : 2 + 2,	// Temp boosted stats to help with testing
		spirit : 3 + 2,
		endurance : 3 + 2,
		technique : 2 + 2,
		swiftness : 3 + 2,
		vitality : 3 + 2,
		willpower : 8,
		active : global.battleChoices.lashOut,
		passive : [ global.passives.herosJourney, global.passives.survivor ],
		items : [  ],
		// Adventure skills
		leadership : Skill.Skilled,
		scouting : Skill.Decent,
		huntingGathering : Skill.Poor,
		cooking : Skill.Poor,
		adventurePassive : [ global.adventurePassives.inspirational ],		
		//protects : [  ],
	},

};

// Create a list of characters
global.characterList = [ global.characters.sigrid, global.characters.ceres, global.characters.thistle, global.characters.cassiel, global.characters.citalli, global.characters.acatl, global.characters.demi, global.characters.alkimos, global.characters.helle, global.characters.ilse ];
global.characterCount = array_length(global.characterList);

// Enemies
global.enemies =
{

	crimsonPlumedRaptor :
	{
		name : "Crimson-Plumed Raptor",
		race : "Dinosaur",
		alignment : Alignment.Foe,
		size : Size.Normal,
		weapon1 : global.weapons.terribleClaws,
		weapon1Name : "Terrible Claws",
		weapon2 : global.weapons.piercingTeeth,
		weapon2Name : "Piercing Teeth",
		armor : global.armors.monsterArmorEvasion,
		armorName : "",
		strength : 6,
		spirit : 2, 
		endurance : 3,
		technique : 6,
		swiftness : 5,
		vitality : 5,
		willpower : 1,
		active : global.battleChoices.none,
		passive : [ ],
		items : [ ]		
	},	

	palegrovePoacher :
	{
		name : "Palegrove Poacher",
		race : "Human",
		alignment : Alignment.Foe,
		size : Size.Normal,
		weapon1 : global.weapons.longbow,
		weapon1Name : "Rough-hewn Selfbow",
		weapon2 : global.weapons.dagger,
		weapon2Name : "Bone-Carved Hunting Knife",
		armor : global.armors.light,
		armorName : "Tattered Leathers",
		strength : 5,
		spirit : 2, 
		endurance : 2,
		technique : 4,
		swiftness : 4,
		vitality : 4,
		willpower : 2,
		active : global.battleChoices.none,
		passive : [ ],
		items : [ ]		
	},
	
	palegroveReaver :
	{
		name : "Palegrove Reaver",
		race : "Human",
		alignment : Alignment.Foe,
		size : Size.Normal,
		weapon1 : global.weapons.heavySword,
		weapon1Name : "Wicked Shamshir",
		weapon2 : global.weapons.heavySword,
		weapon2Name : "Wicked Shamshir",
		armor : global.armors.heavy,
		armorName : "Rusted Plate",
		strength : 6,
		spirit : 1, 
		endurance : 5,
		technique : 3,
		swiftness : 4,
		vitality : 7,
		willpower : 3,
		active : global.battleChoices.none,
		passive : [ ],
		items : [ ]		
	},	

}

// Create a list of enemies
global.enemyList = [global.enemies.crimsonPlumedRaptor, global.enemies.palegrovePoacher, global.enemies.palegroveReaver ];
global.enemyCount = array_length(global.enemyList);

function calculateSubstats(unitList = noone, unitCount = 0, specificUnit = false)
{
	for (i=0; i < unitCount; i++)
	{
		if specificUnit
			var character = specificUnit;
		else
		{
			var character = unitList[i];
			character.equippedWeapon = 1;
		}	
		character.activeWeaponName = getWeaponName(character);
		character.range = getWeaponRange(character);
		character.attack = calculateAttack(character);
		character.weaponHits = calculateWeaponHits(character);
		character.critChance = calculateWeaponCritChance(character);
		character.penetration = calculateWeaponPenetration(character);
		character.maxHitpoints = calculateHitpoints(character);
		character.defense = calculateDefense(character);
		character.resistance = calculateResistance(character);
		character.lastStandChance = calculateLastStandChance(character);
		if specificUnit = false
		{
			character.hitpoints = character.maxHitpoints;
			character.defending = false;
			character.concious = true;
			character.selectable = true;
		}	
	}
}
	
// Derive and assign substats for characters and enemies
calculateSubstats(global.characterList, global.characterCount);
calculateSubstats(global.enemyList, global.enemyCount);