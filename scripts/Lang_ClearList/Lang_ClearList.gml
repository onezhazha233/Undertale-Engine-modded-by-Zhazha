function Lang_ClearList() {
	ds_list_clear(global._gmu_lang_list);
	ds_map_clear(global._gmu_lang_manifest);
	ds_map_clear(global._gmu_lang_root);
	return true;
}
