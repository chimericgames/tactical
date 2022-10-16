function battleActions(unitName)
{

	var unit = unitName;
	var battleAction = actionQueue[battleIndex,1];
	switch(battleAction)
	{
		case "Attack": 
		actionAttack(unit);
		break;

		case "Ignite": 
		actionAttack(unit, "Ignite");
		break;
	}
	
}