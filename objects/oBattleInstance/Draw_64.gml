var ii=0;

if playerTurn && !battleStart
{
	// Draw battle choices for the active character
	draw_text(menuX,menuY+ii*leading,string(activeCharacter.name)); ii++;
	var col = battleChoicesAvailable == true ?  c_white : c_dkgray;
	draw_set_color(col);	
	if actionCountdown = 0
	{
		ii++;
		draw_text(menuX,menuY+ii*leading,"Battle Choices:"); ii++;
		battleChoiceCount = array_length(battleChoices);
		for (var i=0; i<battleChoiceCount; i++)
		{
			// Draw the battle choice box
			draw_set_alpha(.375);
			draw_rectangle(menuX-5,menuChoiceY+i*leading,menuX+battleChoiceBoxWidth,menuChoiceY+battleChoiceBoxHeight+i*leading,true);
			// Draw the battle choice string
			draw_set_alpha(1);
			var battleChoiceString = battleChoices[i];
			draw_text(menuX + 10,menuY+ii*leading,battleChoiceString.name); ii++;
		}
		draw_set_color(c_white);
		ii++;

		// Draw the battle choices selecter box
		if battleChoicesAvailable
		{
			if mousePos != -1
				draw_rectangle(menuX-5,menuChoiceY+mousePos*leading,menuX+battleChoiceBoxWidth,menuChoiceY+battleChoiceBoxHeight+mousePos*leading,true);
		}
			
		// Highlight the active unit
		if playerTurn
		{
			var activePlayerX = global.partyXYPositions[activeCharacter.position, 0]-selectUnitBoxWidth/2;
			var activePlayerY = global.partyXYPositions[activeCharacter.position, 1];
			draw_rectangle(activePlayerX,activePlayerY-selectUnitBoxHeight/2,activePlayerX+selectUnitBoxWidth,activePlayerY+selectUnitBoxHeight,true);
		}	
		
		// If the active unit has a melee weapon, show their attack target //TODO: For now, this only shows the unit across, even if its invalid
		if activeCharacter.range == Range.Short
		{
			draw_set_alpha(.375);
			var position = activeCharacter.position;
			var unitX = global.enemyXYPositions[position, 0]-selectUnitBoxWidth/2;
			var unitY = global.enemyXYPositions[position, 1];
			draw_rectangle(unitX,unitY-selectUnitBoxHeight/2,unitX+selectUnitBoxWidth,unitY+selectUnitBoxHeight,true);
			draw_set_alpha(1);
		}
		
		// While targeting, show all possible targets and active target
		if targetingEnemy
		{
			// Draw all possible targets
			draw_set_alpha(.375);
			for (var i = 1; i <= 6; ++i) 
			{
				var unitX = global.enemyXYPositions[i, 0]-selectUnitBoxWidth/2;
				var unitY = global.enemyXYPositions[i, 1];
				draw_rectangle(unitX,unitY-selectUnitBoxHeight/2,unitX+selectUnitBoxWidth,unitY+selectUnitBoxHeight,true);
			}
			draw_set_alpha(1);
			
			// Draw the active enemy targeting box	
			if targetPositionEnemy > 0
			{
				draw_set_alpha(1);
				var selectionX = global.enemyXYPositions[targetPositionEnemy, 0]-selectUnitBoxWidth/2;
				var selectionY = global.enemyXYPositions[targetPositionEnemy, 1];
				draw_rectangle(selectionX,selectionY-selectUnitBoxHeight/2,selectionX+selectUnitBoxWidth,selectionY+selectUnitBoxHeight,true);
			}
		}				
			
		// Draw the active player targeting box
		if targetingPlayer && targetPositionPlayer > 0
		{
			var selectionX = global.partyXYPositions[targetPositionPlayer, 0]-selectUnitBoxWidth/2;
			var selectionY = global.partyXYPositions[targetPositionPlayer, 1];
			draw_rectangle(selectionX,selectionY-selectUnitBoxHeight/2,selectionX+selectUnitBoxWidth,selectionY+selectUnitBoxHeight,true);
		}			
	}	
}

// Draw player and enemy health bars
for (var i = 1; i <= 6; ++i) 
{
	var unit = enemyPositions[i];
	if unit != -1
	{
		// Enemy bars
		draw_set_alpha(.375);
		var unitX = global.enemyXYPositions[i, 0]-selectUnitBoxWidth/2;
		var unitY = global.enemyXYPositions[i, 1];
		// Health bar border
		draw_rectangle(unitX,unitY+selectUnitBoxHeight-2,unitX+selectUnitBoxWidth,unitY+selectUnitBoxHeight,true);
		// Health bar fill
		draw_set_alpha(1);
		var unit = enemyPositions[i];
		var unitHealth = unit.hitpoints / unit.maxHitpoints;
		draw_rectangle(unitX,unitY+selectUnitBoxHeight-2,unitX+selectUnitBoxWidth*unitHealth,unitY+selectUnitBoxHeight,false);
	}
	
	var unit = global.partyPositions[i];
	if unit != -1
	{
		// Player bars
		draw_set_alpha(.375);
		var unitX = global.partyXYPositions[i, 0]-selectUnitBoxWidth/2;
		var unitY = global.partyXYPositions[i, 1];
		// Health bar border
		draw_rectangle(unitX,unitY+selectUnitBoxHeight-2,unitX+selectUnitBoxWidth,unitY+selectUnitBoxHeight,true);
		// Health bar fill
		draw_set_alpha(1);
		var unit = global.partyPositions[i];
		var unitHealth = unit.hitpoints / unit.maxHitpoints;
		draw_rectangle(unitX,unitY+selectUnitBoxHeight-2,unitX+selectUnitBoxWidth*unitHealth,unitY+selectUnitBoxHeight,false);	
	}
}

// Display the log
var battleLogSize = array_length(global.battleLog);
for (var i=0; i<battleLogSize; i++)
{
	draw_set_alpha(2.1 - .15 * i);
	draw_text(menuX,window_get_height()-leading*(i+2),string(global.battleLog[i])); ii++;
	draw_set_alpha(1);
}

// Temp: Write the unit's name in rank and file
if displayUnits
{
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	
	// Player units
	for (var i = 1; i <= 6; ++i) 
	{
		var unit = global.partyPositions[i];
		if unit != -1
		{
			if !unit.concious
				draw_set_color(c_dkgray);
			var unitX = global.partyXYPositions[i, 0];	
			var unitY = global.partyXYPositions[i, 1];
			draw_text(unitX,unitY,"[" + string(unit.position) + "]" + unit.name);
			draw_set_color(c_white);
		}	
	}
	
	// Enemy units
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	for (var i = 1; i <= 6; ++i) 
	{
		var unitX = global.enemyXYPositions[i, 0];	
		var unitY = global.enemyXYPositions[i, 1];
		var unit = enemyPositions[i];
		if unit != -1
		{
			if !unit.concious
				draw_set_color(c_dkgray);
			draw_text(unitX,unitY,"[" + string(unit.position) + "]" + unit.name);
			draw_set_color(c_white);
		}	
	}	
	draw_set_halign(fa_left);
}

if displayUnitStats
{
	// Draw active character stats
	if activeEnemy != noone
	{
		drawCharacterStats(activeCharacter, activeEnemy, window_get_width()-450, 400);
		//drawCharacterStats(activeEnemy, activeCharacter, window_get_width()-500, 400);
	}
}

// Draw the turn order and list the health of all party members
ii = 0;
var turnOrderX = window_get_width()-450;
var turnOrderY = 20;
var turnOrderCount = array_length(turnOrder);
draw_text(turnOrderX,turnOrderY+ii*leading,"Turn: " + string(turnIndex+1)); ii++;
draw_text(turnOrderX,turnOrderY+ii*leading,"Turn Order:"); ii++;
for (var i=0; i<turnOrderCount; i++)
{
	var unit = turnOrder[i];
	if unit != -1
		draw_text(turnOrderX,turnOrderY+ii*leading,"[" + string(unit.position) + "]" + string(unit.name) + ": " + string(unit.hitpoints) + "/" + string(unit.maxHitpoints)); ii++;
}

// Draw queued actions
var turnOrderY = 20 + leading * 2;
ii = 0;
var queuedActions = array_length(actionQueue);
for (var i=0; i<queuedActions; i++)
{
	var action = actionQueue[i,1];
	draw_text(turnOrderX+325,turnOrderY+ii*leading,string(action)); ii++;
}

// Debug mode
if global.debugMode
{
	ii++;ii++;
	draw_text(turnOrderX,turnOrderY+ii*leading,"battleChoicesAvailable: " + string(battleChoicesAvailable)); ii++;
	draw_text(turnOrderX,turnOrderY+ii*leading,"targetingPlayer: " + string(targetingPlayer)); ii++;
	draw_text(turnOrderX,turnOrderY+ii*leading,"targetingEnemy: " + string(targetingEnemy)); ii++;
	draw_text(turnOrderX,turnOrderY+ii*leading,"targetPositionEnemy: " + string(targetPositionEnemy)); ii++;
	
	var testWeapon = global.weapons.monsterWings;
	draw_text(turnOrderX,turnOrderY+ii*leading,"test damage: " + string(testWeapon.damage)); ii++;
	draw_text(turnOrderX,turnOrderY+ii*leading,"test crit: " + string(testWeapon.crit)); ii++;
	draw_text(turnOrderX,turnOrderY+ii*leading,"test wieldiness: " + string(testWeapon.wieldiness)); ii++;
	draw_text(turnOrderX,turnOrderY+ii*leading,"test penetration: " + string(testWeapon.penetration)); ii++;
	draw_text(turnOrderX,turnOrderY+ii*leading,"test bleed: " + string(testWeapon.bleed)); ii++;
	draw_text(turnOrderX,turnOrderY+ii*leading,"test stun: " + string(testWeapon.stun)); ii++;
	draw_text(turnOrderX,turnOrderY+ii*leading,"test range: " + string(testWeapon.range)); ii++;
	draw_text(turnOrderX,turnOrderY+ii*leading,"test hits: " + string(testWeapon.hits)); ii++;
	draw_text(turnOrderX,turnOrderY+ii*leading,"test encumbrance: " + string(testWeapon.encumbrance)); ii++;
}

