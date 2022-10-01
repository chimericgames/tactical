// Randomize game seed
randomize();

// Constants
global.initialActionDelay = 5; // The delay at the start of combat
global.actionDelay = 30; // Delay after actions
global.critDamage = 2;
global.baseHitChance=.65;
global.minHitChance=.05;
global.swiftnessVariance=1.5; // Slightly randomizes turn order
global.battleLog=[];
global.gameOver = false;

// Passive abilities
global.passives =
{
	guardian :
	{
		name : "Guardian",
		description : "While defending, takes a single-target hit for an adjacent ally, once per turn.",
	},		
	viciousCounter :
	{
		name : "Vicious Counter",
		description : "While defending, counter attacks deal double damage.",
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
		description : "",
	},				
	irrepressible :
	{
		name : "Irrepressible",
		description : "",
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
	}
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
	}		
	pulverize :
	{
		name : "Pulverize",
		description : "Attacks against stunned enemies ignore all armor.",
	}		
	
}

global.adventurePassives =
{

	overwatch :
	{
		name : "Overwatch", 
		description : "While assigned to scouting, reduces the chances of being ambushed while increasing the chances of ambushing enemies.",
	}
	
	rousingVerse :
	{
		name : "Rousing Verse", 
		description : "Reduces the effects of low morale and increases the effects of good morale.",	// Can reduce and increase always be 25%?
	}	


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
	starEarrings :
	{
		name : "Star Earrings",
		description : "",
		charges : -1,
		isBattleChoice : false,
	},		
	falconryGauntlet :
	{
		name : "Falconry Gauntlet",
		description : "",
		charges : -1,
		isBattleChoice : false,		
		
	}
	galeCharm :
	{
		name : "Gale Charm",
		description : "Consume charge: Blasts the user to the rear position and deals light elemental damage to the enemy front row.",
		charges : 2,
		isBattleChoice : true,
	}
}	

// Active abilities
global.battleChoices =
{
	attack :
	{
		name: "Attack",
		description : "",
	},
	defend : 
	{
		name: "Defend",
		description : "",		
	},	
	weaponSwap :
	{
		name: "Swap Weapons",
		description : "",		
	},	
	position :
	{
		name: "Position",
		description : "",		
	},	
	retreat :
	{
		name: "Retreat",
		description : "",		
	},	
	none :
	{
		name: "None",
		description : "",		
	},		
	rally :
	{
		name: "Rally",
		description : "",		
	},	
	deadeye :
	{
		name: "Deadeye",
		description : "",		
	},	
	envenom :
	{
		name: "Envenom",
		description : "",		
	},	
	cryHavoc :
	{
		name: "Cry Havoc",
		description : "",		
	},	
	ignite :
	{
		name: "Ignite",
		description : "",		
	},	
	harry :
	{
		name : "Harry",	
		description : "",		
	},
	tailWind :
	{
		name : "Tail Wind",	
		description : "",		
	},	
	batteringRam :
	{
		name : "Battering Ram"	
		description : "Attacks with horns from the back row with increased chance to stun while changing position to the front row.",		
	},
}

// Weapons
// Baseline damage = 4
// Slashing weapons: +.5 wieldiness, +2 bleed
// Piercing weapons: +1 wieldiness, +.5 crit, +1 bleed
// Splitting weapons +1 damage, +1 penetration, -1 wieldiness
// Crushing weapons: -1 crit, -2 bleed, +3 penetration
// Shield -3 damage, -2 crit, +2 armor, +2 elemental protection
// Great shield: +1 damage, +1 armor, +1 elemental protection (compared to shield)
// Pole weapons: +1 range
// Great weapons: +2 attack, -1 wieldiness
// Thrown weapons -2 attack, long range, -1 wieldiness
// Small weapons: -1 attack, +.5 crit
// Very small weapons: -2 attack, +1 crit
// Dual weapons -1 attack, +1 hit
// TODO: Spreadsheet this, then derive stats

global.weapons =
{
	fists :
	{
		attack : 0,
		range : Range.Short,
		hits : 2,
		damageType : DamageTypes.Crushing,
		wieldiness : 0,
		bleed : 0,
		penetration : 0,
		critModifier : 0,
		armorProtection : 0,
		elementalProtection : 0
	},
	
	piercingTeeth :
	{
		attack : 4,
		range : Range.Short,
		hits : 1,
		damageType : DamageTypes.Piercing,
		wieldiness : 1,
		critModifier : 1,
		armorProtection : 0,
		elementalProtection : 0
	},	
	
	terribleClaws :
	{
		attack : 2,
		range : Range.Short,
		hits : 2,
		damageType : DamageTypes.Slashing,
		wieldiness : .5,
		critModifier : 1,
		armorProtection : 0,
		elementalProtection : 0
	},	
	
	greatWings :
	{
		attack : 2,
		range : Range.Medium,
		hits : 1,
		damageType : DamageTypes.Crushing,
		wieldiness : 0,
		critModifier : -1,
		armorProtection : 0,
		elementalProtection : 0
	},

	monsterHorns :
	{
		attack : 4,
		range : Range.Medium,
		hits : 1,
		damageType : DamageTypes.Crushing,
		wieldiness : 0,
		critModifier : -1,
		armorProtection : 0,
		elementalProtection : 0
	},

	sword :
	{
		attack : 4,
		range : Range.Short,
		hits : 1,
		damageType : DamageTypes.Slashing,
		wieldiness : .5,
		critModifier : 0,
		armorProtection : 0,
		elementalProtection : 0
	},

	spear :
	{
		attack : 4,
		range : Range.Medium,
		hits : 1,
		damageType : DamageTypes.Piercing,
		wieldiness : 1,
		critModifier : .5,
		armorProtection : 1,
		elementalProtection : 0
	},
	
	axe :
	{
		attack : 5,
		range : Range.Short,
		hits : 1,
		damageType : DamageTypes.Splitting,
		wieldiness : -1,
		critModifier : 0,
		armorProtection : 0,
		elementalProtection : 0
	},	
	
	mediumShield : 
	{
		attack : 1,
		range : Range.Short,
		hits : 1,
		damageType : DamageTypes.Crushing,
		wieldiness : 0,
		critModifier : -2,
		armorProtection : 2,
		elementalProtection : 2
	},		
	
	largeShield : 
	{
		attack : 2,
		range : Range.Short,
		hits : 1,
		damageType : DamageTypes.Crushing,
		wieldiness : 0,
		critModifier : -2,
		armorProtection : 3,
		elementalProtection : 3,
	},	
	
	eztli : // Eztli is a trained microraptor
	{
		attack : 2,
		range : Range.Long,
		hits : 2,
		damageType : DamageTypes.Piercing,
		wieldiness : 1,
		critModifier : 1,		
		armorProtection : 0,
		elementalProtection : 0,
	},
	
	shortbow : 
	{
		attack : 3,
		range : Range.Long,
		hits : 1,
		damageType : DamageTypes.Piercing,
		wieldiness : 1,
		critModifier : 1,		
		armorProtection : 0,
		elementalProtection : 0,
	},		

	longbow : 
	{
		attack : 4,
		range : Range.Long,
		hits : 1,
		damageType : DamageTypes.Piercing,
		wieldiness : 1,
		critModifier : .5,		
		armorProtection : 0,
		elementalProtection : 0,
	},
	
	greatBow :
	{
		attack : 6,
		range : Range.Long,
		hits : 1,
		damageType : DamageTypes.Piercing,
		wieldiness : 0,
		critModifier : .5,		
		armorProtection : 0,
		elementalProtection : 0,
	},		
	
	greatSword : 
	{
		attack : 6,
		range : Range.Short,
		hits : 1,
		damageType : DamageTypes.Slashing,
		wieldiness : -.5,
		critModifier : 0,		
		armorProtection : 1,
		elementalProtection : 0,
	},
	
	greatBlunt : 
	{
		attack : 6,
		range : Range.Short,
		hits : 1,
		damageType : DamageTypes.Crushing,
		wieldiness : -1,
		critModifier : -1,
		armorProtection : 0,
		elementalProtection : 0,
	},	
	
	greatAxe : 
	{
		attack : 7,
		range : Range.Short,
		hits : 1,
		damageType : DamageTypes.Splitting,
		wieldiness : -2,
		critModifier : 0,		
		armorProtection : 1,
		elementalProtection : 0,
	},	
	
	shortSwords : 
	{
		attack : 2,
		range : Range.Short,
		hits : 2,
		damageType : DamageTypes.Slashing,
		wieldiness : .5,
		critModifier : 1,		
		armorProtection : 0,
		elementalProtection : 0,
	},	
	
	dagger : 
	{
		attack : 1,
		range : Range.Short,
		hits : 2,
		damageType : DamageTypes.Piercing,
		wieldiness : 1,
		critModifier : 1.5,				
		armorProtection : 0,
		elementalProtection : 0,
	},
	
	combatKnife : 
	{
		attack : 1,
		range : Range.Short,
		hits : 2,
		damageType : DamageTypes.Slashing,
		wieldiness : .5,
		critModifier : 1,				
		armorProtection : 0,
		elementalProtection : 0,
	},		
	
	thrownBlade : 
	{
		attack : 1,
		range : Range.Long,
		hits : 1,
		damageType : DamageTypes.Piercing,
		wieldiness : -1,
		critModifier : 1.5,		
		armorProtection : 0,
		elementalProtection : 0,
	},			

}

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
	
	cloth :
	{
		weight : 1,		
		armorProtection : 1,
		elementalProtection : 2,
		evasionBonus : 0,
	},
	
	light :
	{
		weight : 2,
		armorProtection : 2,
		elementalProtection : 3,
		evasionBonus : 0,
	},

	medium :
	{
		weight : 3,
		armorProtection : 3,
		elementalProtection : 2,
		evasionBonus : 0,
	},
	
	heavy :
	{
		weight : 4,
		armorProtection : 4,
		elementalProtection : 1,
		evasionBonus : 0,
	}
	
	monsterArmorEvasion :
	{
		weight : 0,		
		armorProtection : 1,
		elementalProtection : 2,
		evasionBonus : 2,
	},
	
}		

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
		active : global.battleChoices.rally,
		passive : [ global.passives.guardian, global.passives.viciousCounter ],
		items : [ global.items.drinkingHorn, global.items.herbalBalm ],
		// Adventure skills
		leadership : Skill.Masterful,
		scouting : Skill.Poor,
		huntingGathering : Skill.Decent,
		cooking : Skill.Decent,
		adventurePassive : [],
		protects : [],
	},
	
	ceres :
	{
		name : "Ceres",
		race : "Centaur",
		alignment : Alignment.Friend,
		size : Size.Large,
		weapon1 : global.weapons.greatBow,
		weapon1Name : "Great Bow",
		weapon2 : global.weapons.greatBlunt,
		weapon2Name : "Great Flail",
		armor : global.armors.light,
		armorName : "Stalker's Leathers",
		strength : 6,
		spirit : 3, 
		endurance : 5,
		technique : 5,
		swiftness : 4,
		vitality : 6,
		active : global.battleChoices.deadeye,
		passive : [ global.passives.predator, global.passives.sunderer ],
		items : [ global.items.furyDraught, global.items.woad ],
		// Adventure skills
		leadership : Skill.Poor,
		scouting : Skill.Skilled,
		huntingGathering : Skill.Skilled,
		cooking : Skill.Decent,
		adventurePassive : [],
		protects : [],
	},
	
	thistle :
	{
		name : "Thistle",
		race : "Nymph",
		alignment : Alignment.Friend,
		size : Size.Normal,
		weapon1 : global.weapons.thrownBlade,
		weapon1Name : "Throwing Knives",
		weapon2 : global.weapons.shortSwords,		
		weapon2Name : "Kukri",
		armor : global.armors.none,
		armorName : "Sylvan Wrap",
		strength : 2,
		spirit : 3, 
		endurance : 2,
		technique : 6,
		swiftness : 7,
		vitality : 4,
		active : global.battleChoices.envenom,
		passive : [ global.passives.sharpReflexes, global.passives.beguiling ],
		items : [ global.items.witbaneToxin, global.items.nectarUnguent ],
		// Adventure skills
		leadership : Skill.Dismal,
		scouting : Skill.Masterful,
		huntingGathering : Skill.Skilled,
		cooking : Skill.Decent,
		adventurePassive : [],		
		protects : [],
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
		active : global.battleChoices.cryHavoc,
		passive : [ global.passives.unyielding, global.passives.unstoppable ],
		items : [ global.items.fieldMedkit, global.items.whetstone ],
		// Adventure skills
		leadership : Skill.Skilled,
		scouting : Skill.Poor,
		huntingGathering : Skill.Poor,
		cooking : Skill.Skilled,
		adventurePassive : [],
		protects : [],
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
		armor : global.armors.cloth,
		armorName : "Cotton Tunic",
		strength : 4,
		spirit : 5, 
		endurance : 3,
		technique : 8,
		swiftness : 5,
		vitality : 3,
		active : global.battleChoices.ignite,
		passive : [ global.passives.firebug, global.passives.irrepressible ],
		items : [ global.items.pitchFlask, global.items.starEarrings ],
		// Adventure skills
		leadership : Skill.Decent,
		scouting : Skill.Skilled,
		huntingGathering : Skill.Masterful,
		cooking : Skill.Poor,
		adventurePassive : [],		
		protects : [ global.characters.acatl ],
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
		armor : global.armors.cloth,
		armorName : "Worn Poncho",
		strength : 3,
		spirit : 6,
		endurance : 4,
		technique : 5,
		swiftness : 4,
		vitality : 3,
		active : global.battleChoices.harry,
		passive : [ global.passives.falconer, global.passives.herbalist ],
		items : [ global.items.falconryGauntlet , global.items.herbalBalm ],
		// Adventure skills
		leadership : Skill.Poor,
		scouting : Skill.Decent,
		huntingGathering : Skill.Skilled,
		cooking : Skill.Masterful,
		adventurePassive : [],
		protects : [], // His pet
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
		weapon1 : global.weapons.terribleClaws,
		weapon1Name : "Hooked Talons",
		weapon2 : global.weapons.greatWings,
		weapon2Name : "Avian Wings",
		armor : global.armors.monsterArmorEvasion,
		armorName : "Dazzling Plumage",
		strength : 4,
		spirit : 7,
		endurance : 2,
		technique : 5,
		swiftness : 4,
		vitality : 4,
		active : global.battleChoices.tailWind,
		passive : [ global.passives.aerialist, global.passives.spiritWard ],
		items : [ global.items.galeCharm ],
		// Adventure skills
		leadership : Skill.Poor,
		scouting : Skill.Masterful,
		huntingGathering : Skill.Skilled,
		cooking : Skill.Catastrophic,
		adventurePassive : [ global.adventurePassives.overwatch ],
		protects : [ global.characters.alkimos ],
	},
	
	alkimos : // Berserker-poet satyr and lifelong friend of the harpy, Demi
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
		strength : 4,
		spirit : 1,
		endurance : 7,
		technique : 3,
		swiftness : 2,
		vitality : 5,
		active : global.battleChoices.batteringRam,
		passive : [ global.passives.berserker, global.passives.pulverize ],
		items : [ global.items.wineSkin ],
		// Adventure skills
		leadership : Skill.Decent,
		scouting : Skill.Skilled,
		huntingGathering : Skill.Skilled,
		cooking : Skill.Poor,
		adventurePassive : [ global.adventurePassives.rousingVerse ],		
		protects : [ global.characters.demi ],
	},

};

// Create a list of characters
global.characterList = [ global.characters.sigrid, global.characters.ceres, global.characters.thistle, global.characters.cassiel, global.characters.citalli, global.characters.acatl, global.characters.demi, global.characters.alkimos ];
global.characterCount = array_length(global.characterList);

// Enemies
global.enemies =
{

	flimsyTrainingDummy :
	{
		name : "Flimsy Training Dummy",
		race : "Construct",
		alignment : Alignment.Foe,
		size : Size.Normal,
		weapon1 : global.weapons.fists,
		weapon1Name : "None",
		weapon2 : global.weapons.fists,
		weapon2Name : "None",
		armor : global.armors.light,
		armorName : "Ramshackle Trappings",
		strength : 0,
		spirit : 0, 
		endurance : 4,
		technique : 0,
		swiftness : 0,
		vitality : 6,
		active : global.battleChoices.none,
		passive : [ ],
		items : [ ]		
	},
	
	stoutTrainingDummy :
	{
		name : "Stout Training Dummy",
		race : "Construct",
		alignment : Alignment.Foe,
		size : Size.Normal,
		weapon1 : global.weapons.fists,
		weapon1Name : "None",
		weapon2 : global.weapons.fists,
		weapon2Name : "None",
		armor : global.armors.medium,
		armorName : "Scuffed Padded Armor",
		strength : 0,
		spirit : 0, 
		endurance : 5,
		technique : 0,
		swiftness : 0,
		vitality : 7,
		active : global.battleChoices.none,
		passive : [ ],
		items : [ ]		
	},	

	heavyTrainingDummy :
	{
		name : "Heavy Training Dummy",
		race : "Construct",
		alignment : Alignment.Foe,
		size : Size.Normal,
		weapon1 : global.weapons.fists,
		weapon1Name : "None",
		weapon2 : global.weapons.fists,
		weapon2Name : "None",
		armor : global.armors.heavy,
		armorName : "Plate and Chainmail",
		strength : 0,
		spirit : 0, 
		endurance : 6,
		technique : 0,
		swiftness : 0,
		vitality : 8,
		active : global.battleChoices.none,
		passive : [ ],
		items : [ ]		
	},	

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
		armor : global.armors.light,
		armorName : "Feathered hide",
		strength : 6,
		spirit : 2, 
		endurance : 5,
		technique : 6,
		swiftness : 6,
		vitality : 7,
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
		endurance : 3,
		technique : 3,
		swiftness : 5,
		vitality : 4,
		active : global.battleChoices.none,
		passive : [ ],
		items : [ ]		
	
	},

}

// Create a list of enemies
global.enemyList = [ global.enemies.flimsyTrainingDummy, global.enemies.stoutTrainingDummy, global.enemies.heavyTrainingDummy, global.enemies.crimsonPlumedRaptor, global.enemies.palegrovePoacher ];
global.enemyCount = array_length(global.enemyList);

function calculateSubstats(unitList = noone, unitCount = 0)
{
	for (i=0; i<unitCount; i++)
	{
		var character = unitList[i];
		character.equippedWeapon = 1;
		character.activeWeaponName = getWeaponName(character);
		character.range = getWeaponRange(character);
		character.attack = calculateAttack(character);
		character.weaponHits = calculateWeaponHits(character);
		character.critChance = calculateCritChance(character);
		character.maxHitpoints = calculateHP(character);
		character.defense = calculateDefense(character);
		character.resistance = calculateResistance(character);
		character.lastStandChance = calculateLastStandChance(character);
		character.hitpoints = character.maxHitpoints;
		character.defending = false;
		character.concious = true;
		character.selectable = true;
	}
}
	
// Derive and assign substats for characters and enemies
calculateSubstats(global.characterList, global.characterCount);
calculateSubstats(global.enemyList, global.enemyCount);