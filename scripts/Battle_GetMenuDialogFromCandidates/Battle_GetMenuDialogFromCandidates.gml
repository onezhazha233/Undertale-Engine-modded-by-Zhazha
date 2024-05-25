function Battle_GetMenuDialogFromCandidates(){
	var LIST = battle._menu_dialog_candidates;
	
	return ds_list_find_value(LIST,irandom(ds_list_size(LIST)-1));
}