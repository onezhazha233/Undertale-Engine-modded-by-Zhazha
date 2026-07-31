///@arg lang_id/name
function Lang_LoadFont(LANG){

	if(!Lang_IsExists(LANG)){
		return false;
	}

	if(is_real(LANG)){
		LANG=Lang_GetName(LANG);
	}

	// 从 manifest 或全局 font/fonts.json 加载字体
	var loaded=false;
	if(variable_struct_exists(global._gmu_lang_manifest,"fonts")){
		var font_list=variable_struct_get(global._gmu_lang_manifest,"fonts");
		if(is_array(font_list)){
			var json_path=working_directory+"font/fonts.json";
			if(file_exists(json_path)){
				var str=Lang_LoadFileToString(json_path);
				if(str!=""){
					var font_defs=json_parse(str);
					if(typeof(font_defs)=="struct"){
						for(var i=0;i<array_length(font_list);i+=1){
							var fkey=font_list[i];
							if(variable_struct_exists(font_defs,fkey)){
								var def=variable_struct_get(font_defs,fkey);
								var src=variable_struct_get(def,"source");
								var size=variable_struct_get(def,"size");
								var bold=variable_struct_get(def,"bold");
								var italic=variable_struct_get(def,"italic");
								var first=variable_struct_get(def,"first");
								var last=variable_struct_get(def,"last");
								var src_path=working_directory+"font/"+src;
								if(file_exists(src_path)){
									var FONT=font_add(src_path,size,bold,italic,first,last);
									if(font_exists(FONT)){
										var old=ds_map_find_value(global._gmu_lang_font,fkey);
										if(is_string(old)) old=real(old);
										if(is_real(old)&&font_exists(old)){
											font_delete(old);
										}
										ds_map_add(global._gmu_lang_font,fkey,FONT);
										loaded=true;
									}
								}
							}
						}
					}
				}
			}
		}
	}
	if(loaded){
		return true;
	}

	// 旧版兼容：从语言目录的 font.txt + INI 加载
	if(!file_exists(GMU_LANG_PATH_BASE+LANG+"/"+GMU_LANG_PATH_FONT)){
		return false;
	}

	var LIST=Lang_LoadFileToString(GMU_LANG_PATH_BASE+LANG+"/"+GMU_LANG_PATH_FONT);
	var FILE=file_text_open_from_string(LIST);
	while(!file_text_eof(FILE)){
		var TARGET=file_text_read_string(FILE);
		file_text_readln(FILE);
		var PATH=GMU_LANG_PATH_BASE+LANG+"/"+TARGET;
		if(file_exists(PATH)){
			ini_open(PATH);
			var key=ini_read_string("font","key","");
			var src=ini_read_string("font","source","");
			var is_sprite=ini_read_real("font","is_sprite",false);
		
			var size=ini_read_real("font","size",12);
			var bold=ini_read_real("font","bold",false);
			var italic=ini_read_real("font","italic",false);
			var first=ini_read_real("font","first",32);
			var last=ini_read_real("font","last",128);
		
			var string_map=ini_read_string("font","string_map","");
			var is_proportional=ini_read_real("font","is_proportional",false);
			var separation=ini_read_real("font","separation",0);
			ini_close();
		
			if(key!=""){
				var FONT=-1;
				if(!is_sprite){
					var src_path=filename_path(PATH)+src;
					if(file_exists(src_path)){
						FONT=font_add(src_path,size,bold,italic,first,last);
					}
				}else{
					if(Lang_IsSpriteExists(src)){
						if(string_map==""){
							FONT=font_add_sprite(Lang_GetSprite(src),first,is_proportional,separation);
						}else{
							FONT=font_add_sprite_ext(Lang_GetSprite(src),string_map,is_proportional,separation);
						}
					}
				}
				if(font_exists(FONT)){
					var VALUE=ds_map_find_value(global._gmu_lang_font,key);
					if(is_real(VALUE)){
						if(font_exists(VALUE)){
							font_delete(VALUE);
						}
						ds_map_delete(global._gmu_lang_font,key);
					}
					ds_map_add(global._gmu_lang_font,key,FONT);
				}
			}
		}
	}
	file_text_close(FILE);
	return true;
}
