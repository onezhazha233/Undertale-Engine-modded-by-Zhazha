if(Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy()) = _enemy_slot){
	if(Battle_GetMenuChoiceButton() = 0){
		if(hp <= 0){
			Battle_CreateEnemyDust(x,y,sprite_index);
		    Battle_RemoveEnemy(_enemy_slot);
		    Battle_RewardExp(reward_exp);
		    Battle_RewardGold(reward_gold);
		    instance_destroy();
		    if(Battle_GetEnemyNumber() <= 0)BGM_Stop(5);
			Player_SetKills(Player_GetKills()+1);
		}
	}

	if(Battle_GetMenuChoiceButton() = 1){
		if(Battle_GetMenuChoiceAction() = 0){
			Dialog_Add("{define `ATK` `"+string(atk)+"`}"+Lang_GetString("battle.enemy.test.1.check"));
		}
		if(Battle_GetMenuChoiceAction() = 1){
			Battle_SetEnemySpareable(_enemy_slot,true);
			Dialog_Add(Lang_GetString("battle.enemy.test.1.talk"));
		}
		if(Battle_GetMenuChoiceAction() = 2){
			atk = max(1,atk-1);
			Dialog_Add(Lang_GetString("battle.enemy.test.1.weaken"));
		}
		if(Battle_GetMenuChoiceAction() = 3){
			atk += 1;
			Dialog_Add(Lang_GetString("battle.enemy.test.1.strengthen"));
		}
	}
}
if(Battle_GetMenuChoiceButton() = 3){
	if(Battle_GetMenuChoiceMercy() = 0){
		if(Battle_IsEnemySpareable(_enemy_slot)){
			audio_stop_sound(snd_vaporize);
			audio_play_sound(snd_vaporize,0,0);
			a = instance_create_depth(x,y,0,battle_enemy_spared);
			a.sprite_index = sprite_index;
			a.effect_yoff = -50;
			Battle_RemoveEnemy(_enemy_slot);
	        Battle_RewardExp(reward_exp);
	        Battle_RewardGold(floor((reward_gold)*(hp/hp_max)));
	        instance_destroy();
			if(Battle_GetEnemyNumber() <= 0)BGM_Stop(5);
		}
	}
}