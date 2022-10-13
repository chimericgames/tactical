if global.gameOver
	exit;
	
// Pause between actions / animations / enemy choices
if actionCountdown > 0
{
	actionCountdown --;
	exit;
}	

// Begin combat! Play out queued actions
if battleStart
{	
	// Bail on combat if one unit remains
	var turnOrderCount = array_length(turnOrder);
	if turnOrderCount <= 1
	{
		log("Combat over: One unit remains.");
		exit;
	}
	
	var unit = actionQueue[battleIndex,0];
	
	// Perform the action if still concious
	if unit.concious
	{
		battleActions(unit);
	}
	// If unconcious, just move on
	else
	{
		log(string(unit.name) + " is unconcious...");
		log("");
		actionCountdown = 1;
	}
	
	// Advance to the next unit in the action queue
	battleIndex ++;
	
	// If we've reached the end, start a new round
	if battleIndex >= array_length(actionQueue)
	{
		battleStart = false;
		
		// Clear the action queue and turn order and create a new one
		turnIndex = 0;
		actionQueue = [];
		turnOrder = [];		
		determineTurnOrder(global.partyList);
		determineTurnOrder(enemyPartyList);
		
		// Find next active unit
		var unit = (turnIndex);
		activeCharacter = turnOrder[unit];
		firstTurnInitialized = false;
		
		// Announce the new round
		log("");
		log("NEW ROUND.");
		log("");
	}
}

inputControl();