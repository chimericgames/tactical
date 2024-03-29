// Helpers

function dieRoll(sides = 100)
{
	return 1 + irandom(sides - 1);	
}

function addVariance(value, randomLow = .9, randomHigh = 1.1)
{
	value *= random_range(randomLow, randomHigh);
	return value;
}

function calculateHitpoints(character = noone)
{
	return (4 + character.vitality * 4 * character.size) * global.derivedStatMultiplier;
}

function getWeaponName(character = noone)
{
	if character.equippedWeapon == 1
		var weaponName = character.weapon1Name;
	else if character.equippedWeapon == 2
		var weaponName = character.weapon2Name;
	return weaponName;
}

function getWeaponRange(character = noone)
{
	if character.equippedWeapon == 1
		var weaponName = character.weapon1.range;
	else if character.equippedWeapon == 2
		var weaponName = character.weapon2.range;
	return weaponName;
}

function swapWeapons(unit = noone)
{
	var oldWeaponName = unit.activeWeaponName;
	if unit.equippedWeapon == 1
		unit.equippedWeapon = 2;
	else if unit.equippedWeapon == 2
		unit.equippedWeapon = 1;
	calculateSubstats(noone, 1, unit);
	log(string(unit.name) + " switches from their " + string(oldWeaponName) + " to their " + string(unit.activeWeaponName) + ".");
}

function calculateAttack(character = noone)
{
	if character.equippedWeapon == 1
		var weaponAttack = character.weapon1.damage;
	else if character.equippedWeapon == 2
		var weaponAttack = character.weapon2.damage;
	return (character.strength*character.size+weaponAttack) * global.derivedStatMultiplier;
}

function calculateWeaponHits(character = noone)
{
	if character.equippedWeapon == 1
		var weaponHits = character.weapon1.hits;
	else if character.equippedWeapon == 2
		var weaponHits = character.weapon2.hits;
	return weaponHits;
}

function calculateWeaponCritChance(character = noone)
{
	if character.equippedWeapon == 1
		var weaponCritModifier = character.weapon1.crit;
	else if character.equippedWeapon == 2
		var weaponCritModifier = character.weapon2.crit;
	return clamp(power(character.technique+weaponCritModifier,1.5) * .0125, 0, 1) * 100;
}

function calculateWeaponPenetration(character = noone)
{
	if character.equippedWeapon == 1
		var penetration = character.weapon1.penetration;
	else if character.equippedWeapon == 2
		var penetration = character.weapon2.penetration;
	return penetration;
}

function calculateWeaponBleed(character = noone)
{
	if character.equippedWeapon == 1
		var bleed = character.weapon1.bleed;
	else if character.equippedWeapon == 2
		var bleed = character.weapon2.bleed;
	return bleed;
}

function calculateWeaponStun(character = noone)
{
	if character.equippedWeapon == 1
		var stun = character.weapon1.stun;
	else if character.equippedWeapon == 2
		var stun = character.weapon2.stun;
	return stun;
}

// Weapon defense (shields, etc) used to factor directly into defense, but I want it to only do so while blocking
function calculateDefense(character = noone)
{
	return (character.endurance + character.armor.armorProtection + character.weapon2.armorProtection) * global.derivedStatMultiplier;
}

function calculateResistance(character = noone)
{
	return (character.spirit + character.armor.elementalProtection + character.weapon2.elementalProtection) * global.derivedStatMultiplier;
}

function calculateLastStandChance(character = noone)
{
	return character.endurance * .0125 + character.willpower * .025;
}

// Determine all possible menu choices for the first character's turn
function populateBattleChoices()
{
	// Add default battle choices
	battleChoices = [global.battleChoices.attack, global.battleChoices.defend, global.battleChoices.weaponSwap, global.battleChoices.position, global.battleChoices.retreat];
	
	// Add active abilities
	array_insert(battleChoices, 3, activeCharacter.active);
	
	// Add active items
	var numberOfItems = array_length(activeCharacter.items);
	for (var i=0; i<numberOfItems; i++)
	{
		var item = activeCharacter.items[i];
		if item.isBattleChoice
			array_insert(battleChoices, 3, item);
	}	
	battleChoiceNumber = array_length(battleChoices);
}

// Iterate through each unit and add them to the turn order based on their swiftness
function determineTurnOrder(list)
{
	var unitCurrent = list[0];
	var unitToCompare = list[0];
	var unitCount = array_length(list);

	for (var i=0; i<unitCount; i++)
	{
		// Pick a character
		unitCurrent = list[i];
		var turnOrderCount = array_length(turnOrder);
	
		// Add it if its the first
		if turnOrderCount = 0
		{
			array_push(turnOrder, unitCurrent);
			continue;
		}	
	
		for (var ii=0; ii<turnOrderCount; ii++)
		{	
			// Check comparative switness for each unit already in the turnOrder array
			unitToCompare = turnOrder[ii]
			
			// Randomize the current unit's swiftness by a range for the purpose of turn order
			var randomizedSwiftness = unitCurrent.swiftness + random_range(-global.swiftnessVariance,global.swiftnessVariance);
			
			if randomizedSwiftness > unitToCompare.swiftness
			{
				array_insert(turnOrder, ii, unitCurrent);
				break;
			}
			// If they're the slowest, add them to the end of the queue
			else if ii = turnOrderCount - 1
				array_push(turnOrder, unitCurrent);
		}	
	}
}

// Get percentile of success
function checkOdds(offense, defense, baseHitChance = global.baseHitChance, minHitChance = global.minHitChance)
{
	var chanceOfSuccess = clamp(minHitChance+(offense / max(defense,.0000001)*baseHitChance),0,1)*100;
	return chanceOfSuccess;
}

// Check if an ability hits
function rollToHit(offense, defense, offenseStat, defenseStat)
{	
	var hitRoll = dieRoll();
	var hitChance = checkOdds(offenseStat, defenseStat);
	show_debug_message(string(offense.name) + "'s hit roll: " + string(hitRoll) + " / " + string(hitChance)+"%");
	if hitRoll<=hitChance
		return true;
	else
		return false;
}

// Get random target at any range
function getRandomTarget(targetList)
{
	// Get a random enemy target from an array
	var target = noone;
	var targetListCount = array_length(targetList)-1;
	var validTargets = [];
	for (var i=0; i<=targetListCount; i++) 
	{		
		// Make sure the unit is a unit, and not an empty slot (or part of a big monster)
		if is_struct(targetList[i])
		{
			var unit = targetList[i];
			if unit.concious == true
			{
				array_push(validTargets, unit);
			}
		}		
	}
	var validTargetCount = array_length(validTargets)-1;
	if validTargetCount >= 0
		var target = validTargets[irandom(validTargetCount)];
	else 
	{
		log("No foes remain");
		return target;
	}	

	return target;
}

// Return true if a unit has a particular passive
function checkUnitPassive(unit, passiveName)
{
	var passivesCount = array_length(unit.passive);
	for (var i = 0; i < passivesCount; i++) 
	{
		var passiveToCheck = unit.passive[i];
		if passiveToCheck.name == passiveName
			return 1;
	}
}

function actionAttack(unit, applyStatus = noone)
{
	var targetEnemy = actionQueue[battleIndex,2];
		
	// Attack the enemy if its alive
	if targetEnemy != noone && targetEnemy.concious
	{
		attackTarget(unit, targetEnemy,,,applyStatus);
		log("");
		actionCountdown = global.actionDelay;
	}
	
	// Choose a new target and then attack if it isn't
	else
	{
		if targetEnemy == noone
			log(string(unit.name) + " has no target. They choose a new target to attack...");
		if !targetEnemy.concious
			log(string(targetEnemy.name) + " is already down, so " + string(unit.name) + " chooses a new target to attack...");
		var targetEnemy = getTarget(unit, false);
		log("Chose a new target: " + string(targetEnemy.name));
		attackTarget(unit, targetEnemy,,,applyStatus);
		actionCountdown = global.actionDelay;				
	}
}	

// Deal any sort of damage (after reductions)
function dealDamage(unit, damageDealt)
{
	// Apply the damage
	var previousHitpoints = unit.hitpoints;
	unit.hitpoints = max(unit.hitpoints - damageDealt, 0);
			
	// Proc on-damage passives
	if checkUnitPassive(unit, "Berserker") && unit.endurance >= 1
	{
		unit.endurance -= 1;
		unit.strength += 1;
		calculateSubstats(noone, 1, unit);
		log((unit.name) + "'s rage grows! Their endurance falls to " + string(unit.endurance) + " and their strength grows to " + string(unit.strength) + ".");
	}

	checkUnitKO(unit, previousHitpoints);		
}

// Attack target
function attackTarget(offense, defense, canBeCountered = true, isACounter = false, applyStatus = noone)
{	
	
	var offenseDamage = offense.attack;
	var defenseDefense = defense.defense;
	var offenseTech = offense.technique;
	var defenseTech = defense.technique;
	
	// Increase defender's defense if they're defending
	if defense.defending
	{
		
		// While defending, increase defense by 4 and then add defense from any shields, etc
		defenseDefense += (2 + max(defense.weapon1.armorProtection, defense.weapon2.armorProtection)) * global.derivedStatMultiplier;
		// TODO: This isn't using shields yet!
		
		defenseTech += 2;
		//log(string(defense.name) + " is defending, raising their defense from " + string(defenseOriginal) + " to " + string(defenseDefense) + " and their technique from " + string(techOriginal) + " to " + string(defenseTech) + ".");
	}		
	
	// See if the attack hits
	var hit = rollToHit(offense, defense, offenseTech, defenseTech);	
	
	if hit
	{		
		
		// Attack bonuses from passives
		var critChanceBonus = 0;
		
		// Attack a number of times
		var weaponHits = offense.weaponHits;
		repeat(weaponHits)
		{			
			show_debug_message(string(offense.name) + "'s attack damage: " + string(offenseDamage));
			// Randomize the damage
			offenseDamage = round(addVariance(offenseDamage));
			show_debug_message(string(offense.name) + "'s attack damage randomized: " + string(offenseDamage));
		
			// Viscious Counter passive
			if isACounter
			{
				if checkUnitPassive(offense, "Vicious Counter")
				{
					offenseDamage *= global.viciousCounterMult;	
					var critChanceBonus = global.viciousCounterCritRateBonus;
					log(string(offense.name) + "'s Vicious Counter skill doubles the damage!");
				}
			}
		
			// See if the hit is a crit
			var critRoll = dieRoll();
			var critChance = calculateWeaponCritChance(offense) + critChanceBonus; // TODO: Isn't this already calculated?
			show_debug_message(string(offense.name) + "'s crit roll: " + string(critRoll) + " / " + string(critChance)+"%");
			var crit = critRoll <= critChance
			if crit 
			{
				show_debug_message(string(offense.name) + " crits!");
				offenseDamage *= global.critDamage;
				show_debug_message(string(offense.name) + "'s critical attack damage: " + string(offenseDamage));
			}	
			
			// Apply defense
			show_debug_message(string(defense.name) + " has " + string(defenseDefense) + " defense.");
			var weaponPen = offense.penetration;
			var defenseAdjusted = defenseDefense * (1 - weaponPen);
			if weaponPen > 0
				show_debug_message(string(offense.name) + "'s weapon penetration reduced the defense to " + string(defenseAdjusted) + ".");			
			var damageDealt = max(offenseDamage - defenseAdjusted, 0);
			
			// Round the damage
			damageDealt = round(damageDealt);
			
			// Log attack result
			if crit
			{
				log(string(offense.name) + " attacks " + string(defense.name) + " with their " + string(offense.activeWeaponName) + " landing a Critical hit dealing " + string(damageDealt) + " damage! (" + string(offenseDamage) + " - " + string(defenseAdjusted) + ")");
			}	
			else	
			{
				log(string(offense.name) + " attacks " + string(defense.name) + " with their " + string(offense.activeWeaponName) + " and connects, dealing " + string(damageDealt) + " damage. (" + string(offenseDamage) + " - " + string(defenseAdjusted) + ")");
			}
			
			// Apply the damage and proc on-damage passives and effects
			dealDamage(defense, damageDealt);

			// Status applied from innate weapon chance
			var bleedRoll = dieRoll();
			if bleedRoll < offense.bleed
			{
				defense.bleedTurns = global.bleedDuration;
				log(string(offense.name) + "'s attack cuts " + string(defense.name) + " deep!");			
			}

			// Status applied always (usually from items)
			if offense.alwaysApplyPoison
				applyStatus = "Poison";

			// Status applied from active abilities
			switch(applyStatus)
			{
				case "Ignite":
				defense.igniteTurns = global.igniteDuration;
				log(string(offense.name) + "'s attack ignites " + string(defense.name) + "!");
				break;
				
				case "Poison":
				if checkUnitPassive(offense, "Pernicious Horticulturist") && defense.poisonStacks <= 0 // TODO: This should be a partywide passive check
						defense.poisonStacks += 1;
				defense.poisonStacks += 2;
				log(string(offense.name) + "'s attack poisons " + string(defense.name) + "!");
				break;
				
				case "Bleed":
				defense.bleedTurns = global.bleedDuration;
				log(string(offense.name) + "'s attack cuts " + string(defense.name) + " deep!");
				break;				
			}	

		}	
	}
	else 
	{	
		// Only counter medium and short ranged attacks and only if it isn't already a counter
		if canBeCountered && offense.range < Range.Long
		{			
			// Check if the target counter attacks
			var counteredRoll = dieRoll();
			var counterChance = checkOdds(defenseTech, offenseTech, .5, 0);
			show_debug_message(string(offense.name) + "'s chance to be countered roll: " + string(counteredRoll) + " / " + string(counterChance)+"%");
			var countered = counteredRoll <= counterChance
			if countered
			{
				log(string(offense.name) + " attacks " + string(defense.name) + " with their " + string(offense.activeWeaponName) + " and misses. " + string(defense.name) + " dodges and retaliates!");
				attackTarget(defense,offense,false,true);
				exit;
			}
		}	
	log(string(offense.name) + " attacks " + string(defense.name) + " with their " + string(offense.activeWeaponName) + " and misses.");				
	}
}

// Switch from back row to front row or vice-versa
function changePositions(unit, manualSwitch = true)
{
	if unit.size >= Size.Large
	{
		//log(string(unit.name) + " can't switch positions because they take up two rows!");
		return false;
	}	
	var oldPosition = unit.position;
	
	// If this is a manual switch, switch places always. If not, only switch places if the unit is in the front row
	if manualSwitch
	{
		var newPosition = oldPosition <= 3 ? unit.position+3 : unit.position-3;
		log(string(unit.name) + " switches positions.");
	}	
	else if oldPosition <= 3
		newPosition = unit.position+3
	else
		return 0;
	
	if unit.alignment == Alignment.Foe
	{
		// If there's a unit in the back row, store it
		var unitToSwapWith = enemyPositions[newPosition] != noone ? enemyPositions[newPosition] : noone;
			
		// Move the unit to other row
		enemyPositions[newPosition] = unit;
			
		// Move the back row unit to the front row, if present
		if unitToSwapWith != noone
		{
			enemyPositions[oldPosition] = unitToSwapWith;
			unitToSwapWith.position = oldPosition;
		}	
	}
	else if unit.alignment == Alignment.Friend
	{
		// If there's a unit in the back row, store it
		var unitToSwapWith = global.partyPositions[newPosition] != noone ? global.partyPositions[newPosition] : noone;
			
		// Move the unit to other row
		global.partyPositions[newPosition] = unit;
			
		// Move the back row unit to the front row, if present
		if unitToSwapWith != noone
		{
			global.partyPositions[oldPosition] = unitToSwapWith;
			unitToSwapWith.position = oldPosition;
		}	
	}	
	unit.position = newPosition;
}

// See if a unit was knocked out and manage it
function checkUnitKO(unit, previousHitpoints)
{
	if unit.hitpoints <= 0
	{
		
		// Allies who would be knocked out check "lastStandChance" to see if they retain 1 hitpoint
		if unit.alignment = Alignment.Friend && previousHitpoints > 1 
		{
			var lastStandRoll = dieRoll(100);
			if lastStandRoll <= unit.lastStandChance
			{
				unit.hitpoints = 1;
				log(string(unit.name) + " waivers, but grits their teeth and clings to conciousness!");
				exit;
			}	
		}
		
		log(string(unit.name) + " was knocked out!");
		
		// Make a unit with no hitpoints unselectable, unconcious, and remove them from the turn order
		unit.concious = false;
		unit.selectable = false;
				
		// If the unit got KO'd in the front row, move the KO'd unit to the back row
		if unit.position <= 3
			changePositions(unit, false);
				
		// Temporary: Change the active enemy (for displaying stats)
		if unit.alignment = Alignment.Foe
			activeEnemy = noone;
					
		// Remove the KO'd unit from the turn order
		var turnOrderCount = array_length(turnOrder);
		for (var i=0; i<turnOrderCount; i++) 
		{					
			if turnOrder[i] == unit
			{
				array_delete(turnOrder,i,1);
				return true;
			}
		}
		/*
		// Remove the KO'd unit from the the action queue	
		var actionQueueCount = array_length(actionQueue);
		for (var i=0; i<actionQueueCount; i++) 
		{					
			if actionQueue[i,0] == unit
			{
				array_delete(actionQueue,i,1);
				return true;
			}
		}
		*/
	}	
	return false;
}

// Add a message to the log
function log(str)
{
	// Put the string in the battle log
	array_insert(global.battleLog, 0, str);
	
	// And also the debug message
	show_debug_message(str);
	
	// Clear out old battle log entries
	if array_length(global.battleLog) > 40
		array_resize(global.battleLog, 40);
}

// Advance the turn and populate battle choices for player characters
function advanceTurn()
{
	// Reset flags
	targetingEnemy = false;
	targetingPlayer = false;
	battleChoicesAvailable = true;
	battleChoice = "";
	targetPositionEnemy = -1;
	targetPositionPlayer = -1;
	
	// Make sure there's still a fight going on
	var turnOrderCount = array_length(turnOrder);
	if turnOrderCount <= 1
	{
		log("Cannot advance turn: One unit remains.");
		return 0;
	}

	// Increment the turn count and index
	turnCount ++;
	turnIndex ++;
	
	// Once all units have chosen actions begin the battle
	if turnIndex >= turnOrderCount
	{
		
		// Start the battle!
		battleStart = true;
		battleIndex = 0;
		
		log("");
		log("COMBAT START.");
		log("");
		
		exit;
	}	
	
	// Find next active unit
	var unit = (turnIndex);
	activeCharacter = turnOrder[unit];
	
	// Reset the character
	activeCharacter.defending = false;
	
	log("");
	log(string(activeCharacter.name) + "'s turn.");
	
	// If unit is a player, create the battle menu.
	if !enemyTurn()
		populateBattleChoices();
}

// Queue up combat actions
function queueAction(action = "Attack", target = noone)
{
	actionQueue[turnIndex, 0] = activeCharacter;
	actionQueue[turnIndex, 1] = action;
	if target != noone
		actionQueue[turnIndex, 2] = target;
}

// Targeting logic
function getTarget(unit, chooseTarget = true)
{
	var opposingList = unit.alignment == Alignment.Foe ? global.partyPositions : enemyPositions;
	var range = unit.range;
	
	// Short range units auto attack whoever is engaged with them, or the nearest front row unit
	// TODO: Medium units work this way too, but need code changes
	if range <= Range.Medium
	{
		// For short range units, check for a foe in the same position and then next to it
		var position = unit.position;
		var positionToCheck = unit.position;
			
		// Check across	first // TODO: Can we make this more elegant?
		var target = opposingList[@ positionToCheck];
		if target != noone && target.concious
		{
			//log("Targeting: " + string(target.name));
			return opposingList[@ positionToCheck];	
		}	
			
		// If center, check either side
		else if position == 2
		{
			if dieRoll(2) == 1 
				positionToCheck = [1,3];
			else
				positionToCheck = [3,1];
				
			for(var i=0;i<2;i++)
			{
				var target = opposingList[@ positionToCheck[i]];
				if target != noone && target.concious
				{
					//log("Targeting: " + string(target.name));					
					return opposingList[@ positionToCheck[i]];		
				}	
			}	
		}
		
		// If edge, check middle
		else if position == 1
		{
			positionToCheck = 2;				
			var target = opposingList[@ positionToCheck];
			if target != noone && target.concious
			{
				//log("Targeting: " + string(target.name));						
				return opposingList[@ positionToCheck];		
			}	
			// And then check far
			positionToCheck = 3;
			var target = opposingList[@ positionToCheck];			
			if target != noone && target.concious
			{
				//log("Targeting: " + string(target.name));										
				return opposingList[@ positionToCheck];	
			}	
		}
		
		// If other edge, check middle
		else if position == 3
		{
			positionToCheck = 2;
			var target = opposingList[@ positionToCheck];
			if target != noone && target.concious
			{
				//log("Targeting: " + string(target.name));				
				return opposingList[@ positionToCheck];		
			}	
			// And then check far
			positionToCheck = 1;				
			var target = opposingList[@ positionToCheck];			
			if target != noone && target.concious
			{
				//log("Targeting: " + string(target.name));				
				return opposingList[@ positionToCheck];	
			}	
		}
	}
	// Long range enemies attack a random target
	else if chooseTarget = false || (unit.alignment == Alignment.Foe && range >= Range.Long)
	{
		return getRandomTarget(opposingList);
	}
	// Long range player characters attack a chosen target
	else if unit.alignment == Alignment.Friend && range >= Range.Long
	{
		targetingEnemy = true;
		battleChoicesAvailable = false;
		return true;
	}
	log(string(unit.name) + " has no one to attack!")	
	return noone;
}	

// Enemy turn logic
function enemyTurn(unit = activeCharacter)
{
	if unit.alignment == Alignment.Foe
	{

		// Enemy's turn
		playerTurn = false;	
		
		// Choose an enemy target based on range
		targetEnemy = getTarget(unit);
		
		// Got a target! Proceeding
		if targetEnemy != noone
		{
			// Enemies in the front row switch weapons randomly. TODO: Both rows
			if unit.position <= 3 && dieRoll(2) = 1
			{
				swapWeapons(unit);		
			}	
			
			queueAction("Attack", targetEnemy);
			//log(string(unit.name) + " chooses their action.")	
			
			// Advance the turn
			actionCountdown = global.menuDelay;
			advanceTurn();
			return 1;			
		}
		else
			queueAction("None");
		
		// No player targets. Game Over!
		global.gameOver = true;
	}
	playerTurn = true;
	return 0;
}

// Copy a value
// This will perform a deep copy on array and struct values
function valueCopy(src)
{
	switch typeof(src)
	{
	default:
		return src;
	case "array":
		return arrayCopy(src);
	case "struct":
		return structCopy(src);
	}
}

// Copy all array members to a new array
function arrayCopy(src)
{
	var size = array_length(src);
	var dest = array_create(size);
	
	for (var i = 0; i < size; ++i)
	{
		var value = valueCopy(array_get(src, i));
		array_set(dest, i, value);
	}
	
	return dest;
}

// Copy all struct members to a new struct
function structCopy(src) 
{
	var names = variable_struct_get_names(src);
	var size = array_length(names);
	var dest = {};
	
	for (var i = 0; i < size; ++i) 
	{
		var name = names[i];
		var value = valueCopy(variable_struct_get(src, name));
		variable_struct_set(dest, name, value);
	}
	
	return dest;
}

// Define unit positions
function defineUnitPositions()
{
	var unitXPos=350;
	var unitYPos=350;
	var enemySeparation=-150
	var unitRankSeparation=250;
	var unitFileSeparation=150;

	for (var i = 1; i <= 6; ++i) 
	{
		global.partyXYPositions[i, 0] = i>3 ? unitXPos+unitRankSeparation*(i-3) : unitXPos+unitRankSeparation*i;
		global.partyXYPositions[i, 1] = i>3 ? unitYPos+unitFileSeparation : unitYPos;
	
		global.enemyXYPositions[i, 0] = i>3 ? unitXPos+unitRankSeparation*(i-3) : unitXPos+unitRankSeparation*i;
		global.enemyXYPositions[i, 1] = i>3 ? unitYPos+enemySeparation-unitFileSeparation : unitYPos+enemySeparation;
	}
}	

// Instantiate a unit from the global struct for use in combat
function instantiateUnit(unitName, list = global.enemies) {
    var unitClass = variable_struct_get(list, unitName);
    if unitClass == undefined
        return undefined;
    var unitInstance = valueCopy(unitClass);
    return unitInstance;
}

// Add a unit to a battle position
function addUnitToPosition(unit, position, party)
{	
	if unit != noone
	{
		unit.position = position;
		party[@ position] = unit;
	}
	else
		party[@ position] = -1;
}
