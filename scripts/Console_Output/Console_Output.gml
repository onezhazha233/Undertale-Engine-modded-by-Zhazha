///@arg text
function Console_Output(TEXT){
	if(GMU_CONSOLE_ENABLED){
		return external_call(global._gmu_console_function_output,TEXT);
	}else{
		return false;
	}
}
