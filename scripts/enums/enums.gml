// Enumerations
enum Range
{
	Short = 0,
	Medium = 1,
	Long = 2
}

enum Size
{
	Normal = 1,
	Large = 2,
	Gigantic = 4
}

enum DamageTypes
{
	None = 0,
	Slashing = 1,	// Best vs flesh, worst vs armor. Best bleed. Wieldy. Resisted by endurance.
	Piercing = 2,	// Good vs flesh. Best crit. Bad vs solid. Most wieldy. Resisted by endurance.
	Splitting = 3,	// Good vs armor. Tends to do a lot of damage, but is unwieldy. Resisted by endurance.
	Crushing = 4,	// Best vs armored. Worst crit. Best stun. Resisted by endurance.
	Fire = 5,		// Shortest DOT, best damage. Target may panic. Resisted by spirit.
	Bleed = 6,		// Balanced DOT. Worsens when the target acts. Resisted by spirit.
	Poison = 7,		// Long DOT, lowest damage. Often has other effects. Resisted by spirit.
	Elemental = 8,	// Thermal, electrical, or otherwise natural & intangible damage. Resisted by spririt.
	Spirit = 9,		// Supernatural damage. Resisted by spirit.
}

enum Alignment
{
	Foe = 0,
	Friend = 1	
}

enum Skill
{
	Catastrophic = -3,
	Dismal = -2,
	Poor = -1,
	Decent = 0,
	Skilled = 1,
	Masterful = 2,
	Unmatched = 3,
}