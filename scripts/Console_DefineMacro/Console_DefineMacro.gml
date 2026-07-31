function Console_DefineMacro(KEY, VALUE){
	if(GMU_CONSOLE_ENABLED){

		if(is_string(KEY)&&(is_real(VALUE)||is_string(VALUE))){
			if(!Console_IsRealString(KEY)){
				var map=global._gmu_console_map_macro;
				if(!ds_map_exists(map,KEY)){
					ds_map_add(map,KEY,VALUE);
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		}else{
			return false;
		}
	}else{
		return false;
	}
}
