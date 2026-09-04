function Player_Hurt(DAMAGE){
	if(DAMAGE>=0){
		var HP=Flag_Get(FLAG_STATIC,"hp");
		Flag_Set(FLAG_STATIC,"hp", (HP-DAMAGE>=0 ? HP-DAMAGE : 0));
		// 直接伤害后维持不变量 KR<HP（对齐 c2 命中后钳制），避免伤害把 KR 顶出范围
		HP=Flag_Get(FLAG_STATIC,"hp");
		if(Flag_Get(FLAG_STATIC,"kr")>=HP){
			Player_SetKr(HP-1>=0 ? HP-1 : 0);
		}
		return true;
	}else{
		return Player_Heal(-DAMAGE);
	}
}
