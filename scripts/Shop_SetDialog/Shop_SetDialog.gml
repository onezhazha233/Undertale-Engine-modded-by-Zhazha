///@arg text*
///@arg choice*
///@arg line2*
function Shop_SetDialog() {
	var TEXT="";
	var CHOICE=false;
	var LINE2=false;
	if(argument_count>=1){
		TEXT=argument[0];
	}
	if(argument_count>=2){
		CHOICE=argument[1];
	}
	if(argument_count>=3){
		LINE2=argument[2];
	}

	//销毁原实例
	if(instance_exists(shop._inst_dialog[LINE2])){
		instance_destroy(shop._inst_dialog[LINE2]);
	}

	if(TEXT!=""){
		//创建实例
		var tx=40;
		var ty=260;
		if(CHOICE){
			tx+=21;
		}
		if(LINE2){
			tx+=281;
		}
		shop._inst_dialog[LINE2]=instance_create_depth(tx,ty,0,text_typer);
	
		//更改文字
		var text_prefix=(CHOICE=1 ? "{font 1}" : "")+"{space_y 4}{scale 2}{speed 2}{shadow true}{gui false}{depth "+string(DEPTH_SHOP.DIALOG)+"}";
		if(CHOICE){
			text_prefix+="{instant true}{choice_switch_direction 1}";
		}
		with(shop)_inst_dialog[LINE2].text=text_prefix+TEXT;
		return shop._inst_dialog[LINE2];
	}else{
		return noone;
	}
}
