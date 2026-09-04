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
			Player_SetKrEnabled(false);
			Player_SetKr(0);
			Player_SetHpMax(20);
			Player_SetHp(20);
		}
	}

	if(Battle_GetMenuChoiceButton() = 1){
		if(Battle_GetMenuChoiceAction() = 0){
			Dialog_Add(Lang_GetString("battle.enemy.krtest.check"));
		}
		if(Battle_GetMenuChoiceAction() = 1){
			audio_play_sound(snd_item_heal,0,0);
			Player_Heal(30);
			Dialog_Add(Lang_GetString("battle.enemy.krtest.heal"));
		}
		if(Battle_GetMenuChoiceAction() = 2){
			Player_SetKr(0);
			Dialog_Add(Lang_GetString("battle.enemy.krtest.pray"));
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
	if(Battle_GetMenuChoiceMercy() = 1){
		Player_SetKrEnabled(false);
		Player_SetKr(0);
		Player_SetHpMax(20);
		Player_SetHp(20);
	}
}