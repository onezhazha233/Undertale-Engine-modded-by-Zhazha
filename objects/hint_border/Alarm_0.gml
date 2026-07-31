if(Border_IsDynamic(Flag_Get(FLAG_SETTINGS,"border"))){
	if(sprite_exists(sprite)){
		if(border._sprite!=sprite){
			Border_SetSprite(sprite);
		}
	}else if(border._sprite!=-1){
		Border_SetSprite(-1);
	}
}