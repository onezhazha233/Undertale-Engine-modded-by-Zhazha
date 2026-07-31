if(Input_IsPressed(INPUT.DOWN)){
	if(_choice<3){
		_choice+=1;
		event_user(2);
	}
}else if(Input_IsPressed(INPUT.UP)){
	if(_choice>0){
		_choice-=1;
		event_user(2);
	}
}else if(Input_IsPressed(INPUT.CONFIRM)){
	if(_choice==0){
		room_goto(room_menu);
	}
}

if(_choice==1){
	if(Input_IsPressed(INPUT.RIGHT)||Input_IsPressed(INPUT.LEFT)){
		alarm[0]=1;
		var ID=Lang_GetID(Language());
		if(ID==-1) ID=0;
		ID=(ID+1)%Lang_GetNumber();
		Flag_Set(FLAG_SETTINGS,"language",ID);
		Flag_Save(FLAG_SETTINGS);
	}
}else if(_choice==2){
	var b=Flag_Get(FLAG_SETTINGS,"border");
	if(Input_IsPressed(INPUT.LEFT)&&b>0){
		alarm[0]=1;
		Flag_Set(FLAG_SETTINGS,"border",b-1);
		Flag_Save(FLAG_SETTINGS);
		Border_SetEnabled((b-1)>0?1:0);
		if(Border_IsDynamic(b-1)){
			with(hint_border){
				if(sprite_exists(sprite)){
					if(border._sprite!=sprite){
						Border_SetSprite(sprite,false);
					}
				}else if(border._sprite!=-1){
					Border_SetSprite(-1,false);
				}
			}
		}
	}else if(Input_IsPressed(INPUT.RIGHT)&&b<Border_GetCount()-1){
		alarm[0]=1;
		Flag_Set(FLAG_SETTINGS,"border",b+1);
		Flag_Save(FLAG_SETTINGS);
		Border_SetEnabled((b+1)>0?1:0);
		if(Border_IsDynamic(b+1)){
			with(hint_border){
				if(sprite_exists(sprite)){
					if(border._sprite!=sprite){
						Border_SetSprite(sprite,false);
					}
				}else if(border._sprite!=-1){
					Border_SetSprite(-1,false);
				}
			}
		}
	}
}else if(_choice==3){
	var arr=global.window_scales;
	var cur=Flag_Get(FLAG_SETTINGS,"window_scale",1);
	var idx=0;
	for(var i=0;i<array_length(arr);i+=1){
		if(arr[i]==cur){ idx=i; break; }
	}
	if(Input_IsPressed(INPUT.LEFT)&&idx>0){
		alarm[0]=1;
		idx-=1;
		var _val=arr[idx];
		var _str=string(_val);
		var _dot=string_pos(".",_str);
		if(_dot>0){
			while(string_char_at(_str,string_length(_str))=="0"){
				_str=string_copy(_str,1,string_length(_str)-1);
			}
			if(string_char_at(_str,string_length(_str))=="."){
				_str=string_copy(_str,1,string_length(_str)-1);
			}
		}
		Flag_Set(FLAG_SETTINGS,"window_scale",_val);
		Flag_Save(FLAG_SETTINGS);
		var _bw=border._enabled ? 960 : 640;
		var _bh=border._enabled ? 540 : 480;
		window_set_size(floor(_bw*_val),floor(_bh*_val));
		if(instance_exists(border)){
			border.alarm[0]=1;
		}
	}else if(Input_IsPressed(INPUT.RIGHT)&&idx<array_length(arr)-1){
		alarm[0]=1;
		idx+=1;
		var _val=arr[idx];
		var _str=string(_val);
		var _dot=string_pos(".",_str);
		if(_dot>0){
			while(string_char_at(_str,string_length(_str))=="0"){
				_str=string_copy(_str,1,string_length(_str)-1);
			}
			if(string_char_at(_str,string_length(_str))=="."){
				_str=string_copy(_str,1,string_length(_str)-1);
			}
		}
		Flag_Set(FLAG_SETTINGS,"window_scale",_val);
		Flag_Save(FLAG_SETTINGS);
		var _bw=border._enabled ? 960 : 640;
		var _bh=border._enabled ? 540 : 480;
		window_set_size(floor(_bw*_val),floor(_bh*_val));
		if(instance_exists(border)){
			border.alarm[0]=1;
		}
	}
}
