function inputControl()
{

	// First turn per round only: If the unit is an enemy, target a random player character. If the active unit is a player, create the battle menu and give control.
	if !firstTurnInitialized
	{
		if !enemyTurn()
			populateBattleChoices();
		log(string(activeCharacter.name) + "'s turn.");
		firstTurnInitialized = true;
	}

		if mouse_check_button_pressed(mb_right)
		{
			if checkUnitPassive(global.characters.sigrid, global.passives.viciousCounter)
			{
				log("Vicious Counter skill improves crit chance and doubles the damage!");
			}
		}

	// Controls only work during the player turn
	if !playerTurn
		exit;

	// Action select & input control

	// Mouseover menu
	// TODO: Refactor this with a helper function
	if point_in_rectangle(mouse_x,mouse_y,menuX,menuChoiceY,menuX+selectBoxWidth,menuChoiceY+selectBoxHeight)
		mousePos = 0;
	else if point_in_rectangle(mouse_x,mouse_y,menuX,menuChoiceY+leading,menuX+selectBoxWidth,menuChoiceY+selectBoxHeight*2)
		mousePos = 1;
	else if point_in_rectangle(mouse_x,mouse_y,menuX,menuChoiceY+leading*2,menuX+selectBoxWidth,menuChoiceY+selectBoxHeight*3)
		mousePos = 2;	
	else if point_in_rectangle(mouse_x,mouse_y,menuX,menuChoiceY+leading*3,menuX+selectBoxWidth,menuChoiceY+selectBoxHeight*4)
		mousePos = 3;
	else if battleChoiceNumber>=5 && point_in_rectangle(mouse_x,mouse_y,menuX,menuChoiceY+leading*4,menuX+selectBoxWidth,menuChoiceY+selectBoxHeight*5)
		mousePos = 4;	
	else if battleChoiceNumber>=6 && point_in_rectangle(mouse_x,mouse_y,menuX,menuChoiceY+leading*5,menuX+selectBoxWidth,menuChoiceY+selectBoxHeight*6)
		mousePos = 5;		
	else if battleChoiceNumber>=7 && point_in_rectangle(mouse_x,mouse_y,menuX,menuChoiceY+leading*6,menuX+selectBoxWidth,menuChoiceY+selectBoxHeight*7)
		mousePos = 6;	
	else
		mousePos = -1;

	// Mouseover enemy units
	// TODO: Refactor this with a helper function for both enemies and players
	if targetingEnemy
	{
		targetPositionEnemy = -1;
		for (var i=1; i<=6; i++)
		{
			if enemyPositions[i] == noone
				continue;
			var selectionX = global.enemyXYPositions[i, 0]-selectUnitBoxWidth/2;
			var selectionY = global.enemyXYPositions[i, 1];
			if point_in_rectangle(mouse_x,mouse_y,selectionX,selectionY-selectUnitBoxHeight/2,selectionX+selectUnitBoxWidth,selectionY+selectUnitBoxHeight)
				targetPositionEnemy = i;
		}
	}	

	// Mouseover player units
	// TODO: Refactor this with a helper function for both enemies and players
	if targetingPlayer
	{
		targetPositionPlayer = -1;
		for (var i=1; i<=6; i++)
		{
			if global.partyPositions[i] == noone
				continue;
			var selectionX = global.partyXYPositions[i, 0]-selectUnitBoxWidth/2;
			var selectionY = global.partyXYPositions[i, 1];
			if point_in_rectangle(mouse_x,mouse_y,selectionX,selectionY-selectUnitBoxHeight/2,selectionX+selectUnitBoxWidth,selectionY+selectUnitBoxHeight)
				targetPositionPlayer = i;
		}
	}	

	// Select battle choice
	if battleChoicesAvailable
	{
		if mouse_check_button_pressed(mb_left) && mousePos != -1
		{
		
			var turnOrderCount = array_length(turnOrder);
			if turnOrderCount <= 1
			{
				log("Combat over: One unit remains.");
				exit;
			}	
	
			battleChoice = battleChoices[mousePos];
			switch(battleChoice.name)
			{
				case "Attack": 
					var targetEnemy = getTarget(activeCharacter);
					if targetingEnemy != true
					{
						activeEnemy = targetEnemy;
						if targetEnemy != noone
						{
							queueAction("Attack", targetEnemy);
						}
						else		
							exit;
						log(string(activeCharacter.name) + " prepares to attack the " + string(targetEnemy.name) + ".");
						actionCountdown = global.menuDelay;
						advanceTurn();
					}	
					break;
				case "Defend":
					log(string(activeCharacter.name) + " takes a defensive stance...");
					activeCharacter.defending = true;
					queueAction("Defend");
					actionCountdown = global.menuDelay;
					advanceTurn();
					break;
				case "Swap Weapons": 
					swapWeapons(activeCharacter);	// This does not end the turn
					break;
				case "Position": 
					changePositions(activeCharacter, true);
					queueAction("Position");
					actionCountdown = global.menuDelay;
					advanceTurn();
					break;
				case "Retreat":
					break;
			}
		}
	}

	// Manual enemy attack targeting
	else if targetingEnemy
	{
		if mouse_check_button_pressed(mb_left) && battleChoice.name == "Attack" && targetPositionEnemy != -1
		{
			var targetEnemy = enemyPositions[targetPositionEnemy];
			queueAction("Attack", targetEnemy);
			log(string(activeCharacter.name) + " prepares to attack the " + string(targetEnemy.name) + ".");			
			actionCountdown = global.menuDelay;
			advanceTurn(); 		
		}
	}
	
}