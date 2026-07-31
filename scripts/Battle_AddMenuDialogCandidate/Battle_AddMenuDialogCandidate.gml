///@arg text
function Battle_AddMenuDialogCandidate(TEXT){
	if(Battle_IsMenuDialogCandidateEnabled()){
		ds_list_add(battle._menu_dialog_candidates,TEXT);
		return true;
	}
	else{
		return false;
	}
}