///@arg enemy_slot
function Battle_IsEnemySerious(){
	var ENEMY=argument[0];
	
	if(Battle_IsEnemyValid(Battle_GetEnemy(ENEMY))){
		return Battle_GetEnemy(ENEMY).serious;
	}
	else{
		return false;
	}
	
}