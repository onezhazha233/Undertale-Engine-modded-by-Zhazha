if(!instance_exists(_inst)){
	var _pos_arr=Prompt_GetPos(_pos);
	var _x=_pos_arr[0];
	var _y=_pos_arr[1];
	_anchor_y=_y;
	
	var _align="";
	switch(_pos){
		case PROMPT_POS.BOT_RIGHT:
		case PROMPT_POS.MID_RIGHT:
		case PROMPT_POS.TOP_RIGHT:
			_align="{halign 2}";
			break;
	}

	var _start_x=_x;
	if(fade_in_time>0){
		_start_x=Prompt_IsRightPos(_pos) ? _x+80 : _x-80;
	}

	_inst=instance_create_depth(_start_x,_y,0,text_typer);
	_inst.text=_align+_prefix+_text;
	_inst.override_alpha_enabled=true;
	
	if(fade_in_time>0){
		_inst.override_alpha=0;
		Anim_Create(_inst,"override_alpha",0,0,0,1,fade_in_time);
		Anim_Create(_inst,"x",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,_start_x,_x-_start_x,fade_in_time);
	}else{
		_inst.override_alpha=1;
	}
}

global.prompt_surface_clear=true;

if(!hold_enabled||!instance_exists(_inst)){
	if(instance_exists(_inst)){
		_inst.override_color_text_enabled=true;
		_inst.override_color_text[0]=c_white;
		_inst.override_color_text[1]=c_white;
		_inst.override_color_text[2]=c_white;
		_inst.override_color_text[3]=c_white;
	}
	exit;
}

var _rate=1/hold_duration;
var _decay=4/hold_duration;

if(Input_IsHeld(hold_input)){
	if(!_hold_latched){
		_hold_progress=min(1,_hold_progress+_rate);
		_hold_alpha=min(1,_hold_alpha+1/hold_ring_fade_in);
		if(_hold_progress>=1){
			_hold_latched=true;
			_hold_alpha=1;
			_hold_pending=true;
		}
	}else{
		_hold_progress=1;
		_hold_alpha=1;
	}
}else{
	if(_hold_latched){
		_hold_latched=false;
		_hold_progress=0;
		_hold_alpha=0;
		_hold_pending=false;
	}else{
		if(_hold_progress>0){
			_hold_progress=max(0,_hold_progress-_decay);
		}
		if(_hold_alpha>0){
			_hold_alpha=max(0,_hold_alpha-_decay);
		}
	}
}

if(_hold_progress>0){
	var _tint=_hold_latched?1:_hold_progress;
	var _col=merge_color(c_white,hold_color_end,_tint);
	_inst.override_color_text_enabled=true;
	_inst.override_color_text[0]=_col;
	_inst.override_color_text[1]=_col;
	_inst.override_color_text[2]=_col;
	_inst.override_color_text[3]=_col;
}else{
	_inst.override_color_text_enabled=true;
	_inst.override_color_text[0]=c_white;
	_inst.override_color_text[1]=c_white;
	_inst.override_color_text[2]=c_white;
	_inst.override_color_text[3]=c_white;
}
