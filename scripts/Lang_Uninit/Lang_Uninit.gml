function Lang_Uninit() {
	ds_list_destroy(global._gmu_lang_list);
	ds_map_destroy(global._gmu_lang_manifest);
	ds_map_destroy(global._gmu_lang_root);
	ds_map_destroy(global._gmu_lang_string);

	Lang_ClearSprite();
	ds_map_destroy(global._gmu_lang_sprite);

	Lang_ClearAudio();
	ds_map_destroy(global._gmu_lang_audio);

	Lang_ClearFont();
	ds_map_destroy(global._gmu_lang_font);
}
