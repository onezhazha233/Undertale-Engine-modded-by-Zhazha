function Console_SetStatusRatio(SPLIT, RATIO){
	if(GMU_CONSOLE_ENABLED){
		return external_call(global._gmu_console_function_set_status_ratio,SPLIT, RATIO);
	}else{
		return false;
	}
}
