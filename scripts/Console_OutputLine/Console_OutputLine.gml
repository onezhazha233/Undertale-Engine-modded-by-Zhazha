///@arg text
function Console_OutputLine(TEXT){
	if(GMU_CONSOLE_ENABLED){
		return external_call(global._gmu_console_function_output_line,TEXT);
	}else{
		return false;
	}
}
