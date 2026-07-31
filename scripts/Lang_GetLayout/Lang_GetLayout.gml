///@arg path
///@arg default*
function Lang_GetLayout(PATH, DEFAULT=0) {
	var MAN=Lang_GetManifest(Language());
	if(!is_struct(MAN)){
		return DEFAULT;
	}
	if(!variable_struct_exists(MAN,"layout")){
		return DEFAULT;
	}

	var obj=variable_struct_get(MAN,"layout");
	var parts=string_split(PATH,".");
	var len=array_length(parts);
	for(var i=0;i<len;i+=1){
		var key=parts[i];
		// 支持数组索引：如果 obj 是数组且 key 是数字
		if(is_array(obj)){
			var idx=real(key);
			if(idx>=0&&idx<array_length(obj)){
				obj=obj[idx];
				continue;
			}
			return DEFAULT;
		}
		if(!variable_struct_exists(obj,key)){
			return DEFAULT;
		}
		obj=variable_struct_get(obj,key);
	}

	return (is_real(obj)||is_string(obj)||is_bool(obj)) ? obj : DEFAULT;
}
