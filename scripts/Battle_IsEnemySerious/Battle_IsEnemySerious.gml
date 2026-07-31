///@arg enemy_slot
function Battle_IsEnemySerious(ENEMY){
	
	if(Battle_IsEnemyValid(Battle_GetEnemy(ENEMY))){
		return Battle_GetEnemy(ENEMY).serious;
	}
	else{
		return false;
	}
}