///@arg enemy_slot
function Battle_IsEnemyCenter(){
	var ENEMY=argument[0];

	if(Battle_GetEnemyNumber() = 3){
		if(Battle_IsEnemyValid(Battle_GetEnemy(ENEMY))){
			if(ENEMY = 1){
				return true;
			}
			else{
				return false;
			}
		}
	}
	else{
		return false;
	}
}