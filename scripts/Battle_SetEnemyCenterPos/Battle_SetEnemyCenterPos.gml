///@arg enemy_slot
function Battle_SetEnemyCenterPos(ENEMY, X, Y){

	if(instance_exists(Battle_GetEnemy(ENEMY))){
		battle._enemy_center_pos_x[ENEMY]=X;
		battle._enemy_center_pos_y[ENEMY]=Y;
		return true;
	}else{
		return false;
	}
}
