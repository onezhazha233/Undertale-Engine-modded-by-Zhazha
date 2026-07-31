function Player_SetHpMax(HP_MAX){
	Flag_Set(FLAG_STATIC,"hp_max", HP_MAX);
	return HP_MAX;
}
