kr_hit_this_frame = false;
if(Player_IsInBattle()){
	var km = Player_GetKr();
	var hp = Player_GetHp();
	// 不变量(对齐 c2 命中后钳制)：KR≤40、KR<HP
	if(km>40)   km = 40;
	if(km>=hp)  km = hp-1;
	if(km<0)    km = 0;
	if(km != Player_GetKr()) Player_SetKr(km);

	if(km>0 && hp>1){
		kr_time += 1;
		var _need = 60;
		if(km>=40)      _need = 2;
		else if(km>=30) _need = 4;
		else if(km>=20) _need = 10;
		else if(km>=10) _need = 30;
		// else 60 帧(KR<10)
		if(kr_time>=_need){
			kr_time = 0;
			km -= 1;
			hp -= 1;   // HP>1 才进入此分支，故最低到 1
			Player_SetKr(km);
			Player_SetHp(hp);
		}
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