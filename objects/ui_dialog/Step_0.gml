if(!instance_exists(_inst)){
	if(!Dialog_IsEmpty()){
		_inst=instance_create_depth(60+Lang_GetLayout("dialog.x"),(_top ? 30+Lang_GetLayout("dialog.y_top") : 340+Lang_GetLayout("dialog.y_bottom")),0,text_typer);
		_inst.text="{scale 2}{voice 0}{speed "+string(Lang_GetLayout("speed.dialog_overworld",2))+"}{space_y 2}{shadow true}{gui true}{depth "+string(DEPTH_UI.TEXT)+"}";
		_inst.text+=Dialog_Get();
		_inst.text+="{pause}{end}";
	}else{
		instance_destroy();
	}
}