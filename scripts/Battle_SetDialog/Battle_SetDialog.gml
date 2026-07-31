function Battle_SetDialog(TEXT="", CHOICE=false, LINE2=false){

	//销毁原实例
	if(instance_exists(battle._dialog[LINE2])){
		instance_destroy(battle._dialog[LINE2]);
	}

	if(TEXT!=""){
		//创建实例
		var tx=battle_board.x-battle_board.left-5+28+Lang_GetLayout("battle.dialog.base_x");
		var ty=battle_board.y-battle_board.up-5+20+Lang_GetLayout("battle.dialog.base_y");
		if(CHOICE){
			tx+=40
		}
		if(LINE2){
			tx+=256;
		}
		battle._dialog[LINE2]=instance_create_depth(tx,ty,0,text_typer);
	
		//更改文字
		var text_prefix="{scale 2}{voice 1}{speed "+string(Lang_GetLayout("speed.dialog_battle",2))+"}{shadow true}{gui false}{depth "+string(DEPTH_BATTLE.UI_HIGH)+"}";
		if(CHOICE){
			text_prefix+="{instant true}";
		}
		battle._dialog[LINE2].text=text_prefix+TEXT;
		return battle._dialog[LINE2];
	}else{
		return noone;
	}
}
