if(_state==0){
	Flag_Clear(FLAG_INFO);
	Flag_Load(FLAG_INFO);
	
	var _bx=108+6;
	var _by=118+6;
	
	_inst_name=instance_create_depth(_bx+26+Lang_GetLayout("save.info_text_x.0"),_by+16+Lang_GetLayout("save.info_text_y"),0,text_typer);
	_inst_name.text=_prefix+Flag_Get(FLAG_INFO,"name", Lang_GetString("ui.save.name.empty"));
	
	_inst_lv=instance_create_depth(_bx+180+Lang_GetLayout("save.info_text_x.1"),_by+16,0,text_typer);
	_inst_lv.text=_prefix+"LV "+string(Flag_Get(FLAG_INFO,"lv"));
	
	_inst_time=instance_create_depth(_bx+338+Lang_GetLayout("save.info_text_x.2"),_by+16,0,text_typer);
	var time=Flag_Get(FLAG_INFO,"time");
	var minute=time div 60;
	var second=time mod 60;
	_inst_time.text=_prefix+string(minute)+":"+(second<10 ? "0" : "")+string(second);
	
	_inst_room=instance_create_depth(_bx+26,_by+56,0,text_typer);
	_inst_room.text=_prefix+Player_GetRoomName(Flag_Get(FLAG_INFO,"room", -1));
	
	_inst_save=instance_create_depth(_bx+56+Lang_GetLayout("save.save_x"),_by+116,0,text_typer);
	_inst_save.text=_prefix+Lang_GetString("ui.save.save");
	
	_inst_return=instance_create_depth(_bx+236+Lang_GetLayout("save.return_x"),_by+116,0,text_typer);
	_inst_return.text=_prefix+Lang_GetString("ui.save.return");
}
if(_state==1){
	Player_Save(Flag_GetSlot());
	
	audio_play_sound(snd_save,0,false);
	
	if(instance_exists(_inst_name)){
		instance_destroy(_inst_name);
	}
	if(instance_exists(_inst_lv)){
		instance_destroy(_inst_lv);
	}
	if(instance_exists(_inst_time)){
		instance_destroy(_inst_time);
	}
	if(instance_exists(_inst_room)){
		instance_destroy(_inst_room);
	}
	if(instance_exists(_inst_save)){
		instance_destroy(_inst_save);
	}
	if(instance_exists(_inst_return)){
		instance_destroy(_inst_return);
	}
	
	_inst_name=instance_create_depth(108+6+26,118+6+16,0,text_typer);
	_inst_name.text=_prefix+"{color `yellow`}"+Flag_Get(FLAG_INFO,"name", Lang_GetString("ui.save.name.empty"));
	
	_inst_lv=instance_create_depth(108+6+180,118+6+16,0,text_typer);
	_inst_lv.text=_prefix+"{color `yellow`}"+"LV "+string(Flag_Get(FLAG_INFO,"lv"));
	
	_inst_time=instance_create_depth(108+6+338,118+6+16,0,text_typer);
	var time=Flag_Get(FLAG_INFO,"time");
	var minute=time div 60;
	var second=time mod 60;
	_inst_time.text=_prefix+"{color `yellow`}"+string(minute)+":"+(second<10 ? "0" : "")+string(second);
	
	_inst_room=instance_create_depth(108+6+26,118+6+56,0,text_typer);
	_inst_room.text=_prefix+"{color `yellow`}"+Player_GetRoomName(Flag_Get(FLAG_INFO,"room", -1));
	
	_inst_save=instance_create_depth(108+6+56,118+6+116,0,text_typer);
	_inst_save.text=_prefix+"{color `yellow`}"+Lang_GetString("ui.save.saved");
}