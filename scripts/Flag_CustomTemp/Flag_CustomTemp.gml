function Flag_CustomTemp(){
	with(Flag_GetStorage(FLAG_TEMP)){
		Set("save_slot",0);
		Set("encounter",0);
		Set("battle_room_return",-1);
		Set("gameover_soul_position",[320,320]);
		Set("trigger_warp_landmark",-1);
		Set("trigger_warp_dir",-1);
		Set("text_typer_choice",-1);
		Set("frame_skip",0);
		Set("shop",0);
		Set("shop_room_return",room_test_main);
		Set("old_persistent_room",0);
	}
}