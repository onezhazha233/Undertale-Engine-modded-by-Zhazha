function Lang_Init() {
	//GMU_Lang v1.7.1

	global._gmu_lang_path="./locale/";
	global._gmu_lang_list=ds_list_create();
	global._gmu_lang_root=ds_map_create();
	global._gmu_lang_manifest=ds_map_create();
	global._gmu_lang_string=ds_map_create();
	global._gmu_lang_sprite=ds_map_create();
	global._gmu_lang_audio=ds_map_create();
	global._gmu_lang_font=ds_map_create();
	global._gmu_lang_loading=false;

	font_add_enable_aa(false);

	// 加载字体注册表
	var REG_PATH=GMU_LANG_PATH_FONT+GMU_LANG_FONT_REGISTRY;
	if(file_exists(REG_PATH)){
		var REG_OBJ=json_parse(Lang_LoadFileToString(REG_PATH));
		if(is_struct(REG_OBJ)){
			global._gmu_font_registry=REG_OBJ;
		}
	}
}
