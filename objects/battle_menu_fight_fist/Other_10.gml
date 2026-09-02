///@desc Anim
if(Battle_GetMenuFightDamage()>=0){
	var ENEMY=Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy());
	var X=Battle_GetEnemyCenterPosX(ENEMY);
	var Y=Battle_GetEnemyCenterPosY(ENEMY);
	if(_attack < attack_max&&_attack != 0){
	    instance_create_depth(X+random_range(-50,50),Y+random_range(-50,50),0,battle_menu_fight_anim_fist_small);
	}
	if(_attack = attack_max){
	    instance_create_depth(X+random_range(-25,25),Y+random_range(-25,25),0,battle_menu_fight_anim_fist_big);
	}
}