function Player_Heal(HEAL){
	if(HEAL<0){
		return Player_Hurt(-HEAL);
	}

	var HP=Flag_Get(FLAG_STATIC,"hp");
	var HP_MAX=Flag_Get(FLAG_STATIC,"hp_max");

	if(Player_IsKrEnabled()){
		var KR=Player_GetKr();
		if(KR>=HEAL){
			Player_SetKr(KR-HEAL);
		}else{
			Player_SetKr(0);
			Flag_Set(FLAG_STATIC,"hp", min(HP+HEAL-KR,HP_MAX));
		}
		return true;
	}

	Flag_Set(FLAG_STATIC,"hp", min(HP+HEAL,HP_MAX));
	return true;
}
