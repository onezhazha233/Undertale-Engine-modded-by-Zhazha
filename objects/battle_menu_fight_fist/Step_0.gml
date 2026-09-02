if(_input_acceptable){
	if((_dir==DIR.LEFT&&_aim_x<=battle_board.x-battle_board.left-sprite_get_width(spr_battle_menu_fight_aim)/2) || (_dir==DIR.RIGHT&&_aim_x>=battle_board.x+battle_board.right+sprite_get_width(spr_battle_menu_fight_aim)/2)){
			Battle_SetMenuFightDamage(-1);
			Battle_EndMenuFightAim();
			_input_acceptable=false;
	}
}

if(alarm[0] != -1&&_attack_time < attack_time_max){
	_attack_time += 1;
	if(Input_IsPressed(INPUT.CONFIRM)&&_attack<attack_max){
		if(instance_exists(battle_menu_fight_anim_fist_pressz)){
			battle_menu_fight_anim_fist_pressz.alarm[0] = 14;
			battle_menu_fight_anim_fist_pressz.alarm[1] = -1;
		}
		_attack += 1;
		event_user(0);
	}
}
	
if(Input_IsPressed(INPUT.CONFIRM)&&_input_acceptable){
	if(alarm[0] = -1){
		Anim_Destroy(id,"_aim_x");
		alarm[0] = 1;
			
		var ATK=Player_GetAtkTotal();
		var DEF=Battle_GetEnemyDEF(Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy()));
		var DISTANCE=point_distance(x,y,_aim_x,y);
		var WIDTH=sprite_get_width(spr_battle_menu_fight_bg)/2;
		damage=ATK-DEF+random(2);
		if(DISTANCE<=12){
			damage*=2.1;
		}else{
			damage*=(1-DISTANCE/WIDTH)*2;
		}
		damage=round(damage);
		if(damage<=0){
			damage=1;
		}
		
		Battle_SetMenuFightDamage(damage);
		Battle_SetMenuFightAnimTime(attack_time_max);
		Battle_SetMenuFightDamageTime(60);
		_input_acceptable = false;
		var ENEMY=Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy());
		var X=Battle_GetEnemyCenterPosX(ENEMY);
		var Y=Battle_GetEnemyCenterPosY(ENEMY);
		instance_create_depth(X,Y-50,0,battle_menu_fight_anim_fist_pressz);
		Battle_EndMenuFightAim();
	}
}
	
if((_attack = attack_max||_attack_time = attack_time_max)&&_attack_time != attack_time_max+1){
	if(_attack = 0){
		damage = -1;
		Battle_SetMenuFightAnimTime(0);
		Battle_SetMenuFightDamage(damage);
	}
	else{
		_attack_time = attack_time_max+1;
		damage = ceil((damage*(_attack/attack_max)));
		instance_destroy(battle_menu_fight_anim_fist_pressz);
		Battle_SetMenuFightDamage(damage);
		if(_attack = attack_max){
			Battle_SetMenuFightAnimTime(0);
			DelayFunction(function(){
				audio_stop_sound(snd_damage);
			},1);
		}
	}
}