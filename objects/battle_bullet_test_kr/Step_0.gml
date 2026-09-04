// 持续擦弹 KR：60fps 逐帧平滑结算，DPS 与原版一致(原每 2 帧一次≈30/s)。
// 用小数累加器把伤害分摊到帧：偶数伤害每帧减半(平滑)、奇数伤害自动峰谷(1/0 交替)。
// 每帧都检测接触(不漏 1 帧擦弹)；首次接触立即给 innate + 直接伤害。
// 目标速率：直接伤害 dmg/2 每帧(原每2帧扣dmg)；持续 KR +0.5 每帧(原每2帧+1)。
var _touch = place_meeting(x,y,battle_soul);
if(_touch){
	// 同帧合并：本帧已有子弹结算过伤害(KR)则跳过，确保“第一帧=原血量-1”
	if(battle_misc.kr_hit_this_frame){
		// 被合并，本发不计(不推标志/不加累加器)
	}else{
		battle_misc.kr_hit_this_frame = true;
		var _hitted = false;
		if(!_kr_innate_done){
			_kr_innate_done = true;
			Player_Hurt(dmg);      // 首帧直接伤害
			Player_HurtKr(kr);     // 首次 +innate
			_hitted = true;
		}
		_dmg_acc += dmg * 0.5;   // 分摊到 60fps
		_kr_acc  += 0.5;
		while(_dmg_acc>=1){ _dmg_acc -= 1; Player_Hurt(1); _hitted = true; }
		while(_kr_acc >=1){ _kr_acc  -= 1; Player_HurtKr(1); }
		if(_hitted){
			audio_stop_sound(snd_hurt);
			audio_play_sound(snd_hurt,0,0);
		}
	}
}else{
	_kr_innate_done = false;
	_dmg_acc = 0;
	_kr_acc  = 0;
}