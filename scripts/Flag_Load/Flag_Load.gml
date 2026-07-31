///@arg type
function Flag_Load(TYPE){
	
	with(Flag_GetStorage(TYPE)){
		var path = Flag_GetPath(TYPE);
		var file = file_text_open_read(path);
		
		if(!file_exists(path)){
			Console_OutputLine("Attempted to load flag type "+string(TYPE)+" from non-existing file \""+path+"\"!");
			return false;
		}
		
		var json_string = "";
		while(!file_text_eof(file)){
		    json_string += file_text_read_string(file);
		    file_text_readln(file);
		}
		file_text_close(file);
		
		var content_temp = json_parse(json_string);
		content = content_temp;
	    var keys = variable_struct_get_names(content_temp);
	    for(var i=0;i<array_length(keys);i+=1){
	        var key = keys[i];
	        var value = content_temp[$key];
		
	        if(is_struct(value)){
				Set(key,new Flag_Inventory(array_length(value.content),value.type))
				Get(key).content = value.content;
				Get(key).content = Get(key).ToId();
	        }
			if(key = "room"){
				Set(key,asset_get_index(value));
			}
			if(key = "item_weapon"){
				Set(key,asset_get_index(value));
			}
			if(key = "item_armor"){
				Set(key,asset_get_index(value));
			}
	    }
	}
}
