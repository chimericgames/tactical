function battleActions(unitName)
{
	var unit = unitName;
	var battleAction = actionQueue[battleIndex,1];
	switch(battleAction)
	{
		case "Attack": 
		var targetEnemy = actionQueue[battleIndex,2];
		
		// Attack the enemy if its alive
		if targetEnemy != noone && targetEnemy.concious
		{
			attackTarget(unit, targetEnemy);
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
			var targetEnemy = getTarget(unit);
			attackTarget(unit, targetEnemy);
			log("");
			actionCountdown = global.actionDelay;				
		}
		break;
	}

}