///@arg enemy_slot
function Battle_IsEnemyLeft(){
	var ENEMY=argument[0];

	if(Battle_GetEnemyNumber() > 1){
		if(Battle_IsEnemyValid(Battle_GetEnemy(ENEMY))){
			if(ENEMY = 0||ENEMY = 1&&!Battle_IsEnemyValid(Battle_GetEnemy(0))){
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