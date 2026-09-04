// Karma(KR) 结算 —— 完全移植 c2-sans-fight-master(Bad Time Simulator) 的 KR 系统。
// c2 用 KR_T 累加 dt：档位 KR>=40/30/20/10 时每 1/2/5/15/30 帧(30fps)各扣 1 HP 与 1 KR；
// 本工程 60fps，帧计时放大 2 倍 → 2/4/10/30/60 帧。对齐 c2：无 kr_enabled/kr_inv/prev_hp 停顿。
// 特性：KR≤40 且 KR<HP；仅 KR>0 且 HP>1 时累积计时并扣血；HP 下限 1(KR 扣不死玩家)。
// 每帧初重置同帧合并标志(供 KR 子弹同帧合并判断)
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
		kr_t += 1;
		var _need = 60;
		if(km>=40)      _need = 2;
		else if(km>=30) _need = 4;
		else if(km>=20) _need = 10;
		else if(km>=10) _need = 30;
		// else 60 帧(KR<10)
		if(kr_t>=_need){
			kr_t = 0;
			km -= 1;
			hp -= 1;   // HP>1 才进入此分支，故最低到 1
			Player_SetKr(km);
			Player_SetHp(hp);
		}
	}else{
		kr_t = 0;
	}
}else{
	kr_t = 0;
}