///@arg KR  本次接触要叠加的 Karma(KR) 值
// 由 KR 子弹在每帧接触魂时调用。对齐 Undertale “初始 KR + 持续接触 KR”模型(#4/#5)：
//   首帧接触传 innate(如骨=6)：KR+=innate；之后持续接触每帧传 1：KR+=1。
// 无视无敌帧(global._inv)——贴住就持续危险，节奏由调用方每帧驱动。
// 叠加后钳制：KR 上限 40、恒 < HP。
function Player_HurtKr(KR){
	var HP  = Player_GetHp();
	var _kr = Player_GetKr() + max(KR,0);
	if(_kr>40)  _kr = 40;    // KR 上限 40
	if(_kr>=HP) _kr = HP-1;  // KR < HP(HP 很低时钳为 0)
	if(_kr<0)   _kr = 0;
	Player_SetKr(_kr);
	return true;
}
