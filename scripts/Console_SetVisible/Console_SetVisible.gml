///@arg visible
function Console_SetVisible(VISIBLE){
	if(GMU_CONSOLE_ENABLED){
		return external_call(global._gmu_console_function_set_visible,VISIBLE);
	}else{
		return false;
	}
}
