function Flag_CustomBindings(){
	with(Flag_GetStorage(FLAG_BINDINGS)){
		Set("up",[vk_up, gp_padu]);
		Set("down", [vk_down, gp_padd]);
		Set("left", [vk_left, gp_padl]);
		Set("right", [vk_right, gp_padr]);
		Set("confirm", [vk_enter, gp_face1]);
		Set("cancel", [vk_shift, gp_face2]);
		Set("menu", [vk_control, gp_face3]);
	}
}