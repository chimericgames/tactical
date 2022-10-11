function drawCharacterStats(unit, foe, statsX, statsY)
{
	
	// Draw name and race for the active character
	ii = 0;
	draw_text(statsX,statsY+ii*leading,string(unit.name)); ii++;
	draw_text(statsX,statsY+ii*leading,"Race: "+string(unit.race)); ii++;
	ii++;
	
	// Draw active and passives for the active character
	draw_text(statsX,statsY+ii*leading,"Active: "+string(unit.active.name)); ii++;
	var numberOfPassives = array_length(unit.passive);
	for (var i=0; i<numberOfPassives; i++)
	{
		var passive = unit.passive[i];
		draw_text(statsX,statsY+ii*leading,"Passive: "+string(passive.name)); ii++;
	}
	
	// Draw the gear for the active character
	draw_text(statsX,statsY+ii*leading,"Weapon 1: "+string(unit.weapon1Name)); ii++;
	draw_text(statsX,statsY+ii*leading,"Weapon 2: "+string(unit.weapon2Name)); ii++;
	draw_text(statsX,statsY+ii*leading,"Armor: "+string(unit.armorName)); ii++;	
	
	// Draw the items for the active character
	var numberOfItems = array_length(unit.items);
	for (var i=0; i<numberOfItems; i++)
	{
		var item = unit.items[i];
		draw_text(statsX,statsY+ii*leading,"Item: "+string(item.name)); ii++;
	}
	
	// Draw base stats for active character
	/*
	draw_text(statsX,statsY+ii*leading,"Base Stats: "); ii++;
	draw_text(statsX+10,statsY+ii*leading,"Strength: "+string(unit.strength)); ii++;
	draw_text(statsX+10,statsY+ii*leading,"Spirit: "+string(unit.spirit)); ii++;
	draw_text(statsX+10,statsY+ii*leading,"Endurance: "+string(unit.endurance)); ii++;
	draw_text(statsX+10,statsY+ii*leading,"Technique: "+string(unit.technique)); ii++;
	draw_text(statsX+10,statsY+ii*leading,"Swiftness: "+string(unit.swiftness)); ii++;
	draw_text(statsX+10,statsY+ii*leading,"Vitality: "+string(unit.vitality)); ii++;
	draw_text(statsX+10,statsY+ii*leading,"Willpower: "+string(unit.willpower)); ii++;
	*/
	
	// Draw derived stats for active character
	ii++;
	draw_text(statsX,statsY+ii*leading,"Derived Stats: "); ii++;
	draw_text(statsX+10,statsY+ii*leading,"Hitpoints: "+string(unit.hitpoints) + "/" + string(unit.maxHitpoints)); ii++;
	draw_text(statsX+10,statsY+ii*leading,"Equipped Weapon: "+string(unit.activeWeaponName));ii++;
	var attackAVG = unit.attack + (unit.attack * unit.critChance/100 * global.critDamage);
	var crit1 = string(unit.critChance);
	if unit.weaponHits > 1
		draw_text(statsX+10,statsY+ii*leading,"Weapon Attack: "+string(unit.attack) + " (" + string(crit1) + "% crit = " + string(attackAVG) + " avg) x" + string(unit.weaponHits));
	else
		draw_text(statsX+10,statsY+ii*leading,"Weapon Attack: "+string(unit.attack) + " (" + string(crit1) + "% crit = " + string(attackAVG) + " avg)");
	ii++;		
	draw_text(statsX+10,statsY+ii*leading,"Defense: "+string(unit.defense)); ii++;
	draw_text(statsX+10,statsY+ii*leading,"Resistance: "+string(unit.resistance)); ii++;
	draw_text(statsX+10,statsY+ii*leading,"Last Stand Chance: "+string(unit.lastStandChance*100)+"%"); ii++;
	var baseHitChance = .65;
	var minHitChance = .05;
	var hitChance = clamp(minHitChance+(unit.technique/foe.technique*baseHitChance),0,1)*100;
	var dodgeChance = clamp(1-minHitChance-(foe.technique/unit.technique*baseHitChance),0,1)*100;
	draw_text(statsX+10,statsY+ii*leading,"Hit%: "+string(hitChance)+"%"); ii++;
	draw_text(statsX+10,statsY+ii*leading,"Dodge%: "+string(dodgeChance)+"%"); ii++;

}