// Battle menu GUI

global.debugMode = false;
displayUnitStats = true;

menuX = 20;
menuY = 20;
leading = 20;
mousePos = -1;
menuChoiceY = menuY+leading*3;
selectBoxWidth = 150;
selectBoxHeight = leading;
selectUnitBoxWidth = 225;
selectUnitBoxHeight = leading * 2;
battleChoices = [];
battleChoice = "";
battleChoicesAvailable = true;
battleStart = false;
battleIndex = 0;
displayUnits = true;
targetingPlayer = false;
targetingEnemy = false;
targetPositionEnemy = -1;
targetPositionPlayer = -1;

// Turn data
firstTurnInitialized = false;
turnCount = 1;
turnIndex = 0;
turnOrder = [];
actionQueue = [];
playerTurn = false;
actionCountdown = global.initialActionDelay;

// Create the enemy party
enemyPartyList=[];
array_push(enemyPartyList, instantiateUnit("palegroveReaver", global.enemies));
array_push(enemyPartyList, instantiateUnit("crimsonPlumedRaptor", global.enemies));
array_push(enemyPartyList, instantiateUnit("palegroveReaver", global.enemies));
array_push(enemyPartyList, instantiateUnit("palegrovePoacher", global.enemies));
array_push(enemyPartyList, instantiateUnit("palegrovePoacher", global.enemies));
array_push(enemyPartyList, instantiateUnit("palegrovePoacher", global.enemies));

// Enemies
// Assign each unit to a position
enemyPositions=[];
addUnitToPosition(noone, 0, enemyPositions);
addUnitToPosition(enemyPartyList[0], 1, enemyPositions);
addUnitToPosition(enemyPartyList[1], 2, enemyPositions);
addUnitToPosition(enemyPartyList[2], 3, enemyPositions);
addUnitToPosition(enemyPartyList[3], 4, enemyPositions);
addUnitToPosition(enemyPartyList[4], 5, enemyPositions);
addUnitToPosition(enemyPartyList[5], 6, enemyPositions);

// Create the turn order
determineTurnOrder(global.partyList);
determineTurnOrder(enemyPartyList);

// See whose turn it is
activeCharacter = turnOrder[turnIndex];

// TESTING: Set an active enemy
activeEnemy = enemyPartyList[0];

/*

Position reference

Enemy
[4][5][6]
[1][2][3]

  ^
Player
[1][2][3]
[4][5][6]


*/