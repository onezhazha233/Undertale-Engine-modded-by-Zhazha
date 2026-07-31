function Flag_Storage() constructor{
	content ={};
	function Set(name,value){
		content[$name] = value;
	}
	function Get(name,default_value=0){
		return ((variable_struct_exists(content,name)&&content[$name]!=undefined) ? content[$name] : default_value);
	}
	function ToString(){
		var content_temp ={};
	    var keys = variable_struct_get_names(content);
	    for(var i=0;i<array_length(keys);i+=1){
	        var key = keys[i];
	        var value = content[$key];
		
	        if(is_struct(value)){
	            value = value.ToString();
	        }
			if(key = "room"){
				value = room_get_name(value);
			}
			if(key = "item_weapon"){
				value = object_get_name(value);
			}
			if(key = "item_armor"){
				value = object_get_name(value);
			}
			
	        content_temp[$key] = value;
	    }
		
		return json_format(json_stringify(content_temp));
	}
	function Clear(){
		content ={};
	}
}