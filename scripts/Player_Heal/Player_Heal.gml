function Player_Heal(HEAL){
	if(HEAL>=0){
		var HP=Flag_Get(FLAG_STATIC,"hp");
		var HP_MAX=Flag_Get(FLAG_STATIC,"hp_max");
		Flag_Set(FLAG_STATIC,"hp", (HP+HEAL<=HP_MAX ? HP+HEAL : HP_MAX));
		return true;
	}else{
		return Player_Hurt(-HEAL);
	}
}
