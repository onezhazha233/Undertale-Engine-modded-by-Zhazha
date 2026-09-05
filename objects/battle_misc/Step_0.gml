kr_hit_this_frame = false;
if(Player_IsInBattle()){
	var kr = Player_GetKr();
	var hp = Player_GetHp();

	if(kr>40)   kr = 40;
	if(kr>=hp)  kr = hp-1;
	if(kr<0)    kr = 0;
	if(kr != Player_GetKr()) Player_SetKr(kr);

	if(kr>0 && hp>1){
		kr_time += 1;
		var _need = 60 + kr_delay * 20;
		if(kr>=40)      _need = 2 + kr_delay * 2;
		else if(kr>=30) _need = 4 + kr_delay * 4;
		else if(kr>=20) _need = 10 + kr_delay * 6;
		else if(kr>=10) _need = 30 + kr_delay * 10;
		if(kr_time>=_need && kr_prev_hp == hp){
			kr_time = 0;
			kr -= 1;
			hp -= 1;
			Player_SetKr(kr);
			Player_SetHp(hp);
			kr_delay = 0;
			var _inv = Player_GetInvTotal();
			if(_inv >= 90)  kr_delay = choose(0, 1);
			if(_inv >= 120) kr_delay = choose(0, 1, 1);
			if(_inv >= 150) kr_delay = 1;
		}
		kr_prev_hp = hp;
	}else{
		kr_time = 0;
	}
}else{
	kr_time = 0;
}
var _armor = Item_GetArmor();
if(/*_armor == item_stained_apron || */_armor == item_temy_armor){
	if(Battle_GetState() == BATTLE_STATE.MENU){
		if(heal_state_prev != BATTLE_STATE.MENU){
			heal_cycle += 1;
			heal_done = false;
		}
		if(heal_cycle % 2 == 1 && !heal_done){
			heal_done = true;
			var _hp = Player_GetHp();
			if(_hp < Player_GetHpMax()){
				Player_Heal(1);
				audio_play_sound(snd_item_heal,0,0);
			}
		}
	}
	heal_state_prev = Battle_GetState();
}