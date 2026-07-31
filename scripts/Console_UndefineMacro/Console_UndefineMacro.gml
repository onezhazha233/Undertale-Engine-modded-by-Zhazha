///@arg key
function Console_UndefineMacro(KEY){
	if(GMU_CONSOLE_ENABLED){
	
		var map=global._gmu_console_map_macro;
		if(ds_map_exists(map,KEY)){
			ds_map_delete(map,KEY);
			return true;
		}else{
			return false;
		}
	}else{
		return false;
	}
}
