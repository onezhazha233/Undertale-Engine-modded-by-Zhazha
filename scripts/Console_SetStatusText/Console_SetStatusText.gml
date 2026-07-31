function Console_SetStatusText(SPLIT, TEXT){
	if(GMU_CONSOLE_ENABLED){
		return external_call(global._gmu_console_function_set_status_text,SPLIT, TEXT);
	}else{
		return false;
	}
}
