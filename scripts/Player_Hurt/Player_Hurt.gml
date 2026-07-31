function Player_Hurt(DAMAGE){
	if(DAMAGE>=0){
		var HP=Flag_Get(FLAG_STATIC,"hp");
		Flag_Set(FLAG_STATIC,"hp", (HP-DAMAGE>=0 ? HP-DAMAGE : 0));
		return true;
	}else{
		return Player_Heal(-DAMAGE);
	}
}
