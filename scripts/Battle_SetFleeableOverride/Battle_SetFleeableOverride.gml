function Battle_SetFleeableOverride(FLEEABLE){
	battle._menu_fleeable_override=FLEEABLE;
	//默认为-1，为-1时正常计算逃跑概率，否则强制设置逃跑概率
	return true;
}