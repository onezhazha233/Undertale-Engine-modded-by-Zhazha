///@arg enemy_slot
function Battle_GetEnemyPosition(){
	var ENEMY = argument[0];
	
	if(Battle_IsEnemyLeft(ENEMY)){
		return 0;
	}
	else if(Battle_IsEnemyCenter(ENEMY)){
		return 1;
	}
	else if(Battle_IsEnemyRight(ENEMY)){
		return 2;
	}
	else{
		return -1;
	}
}