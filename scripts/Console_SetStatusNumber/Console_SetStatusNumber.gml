///@arg number
function Console_SetStatusNumber(NUMBER){
	if(GMU_CONSOLE_ENABLED){
		return external_call(global._gmu_console_function_set_status_number,NUMBER);
	}else{
		return false;
	}
}
