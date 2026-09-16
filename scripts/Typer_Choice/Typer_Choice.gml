///@arg index
function Typer_ChoiceHasSlot() {
	var IDX=argument[0];
	if(IDX<0||IDX>=array_length(_choice_reg))return false;
	return _choice_reg[IDX];
}

function Typer_ChoiceSoulAtCursor() {
	draw_set_font(_group_font[_font,0]);
	return [
		_char_x-string_width(" ")*_group_font_scale_x[_font,0]*_scale_x,
		_char_y+string_height(" ")/2*_group_font_scale_y[_font,0]*_scale_y
	];
}

///@arg index
function Typer_ChoiceRegister() {
	var IDX=argument[0];
	while(array_length(_choice_reg)<=IDX)array_push(_choice_reg,false);
	while(array_length(_choice_line)<=IDX)array_push(_choice_line,-1);
	_choice_reg[IDX]=true;
	_choice_line[IDX]=_line;
	_choice_count=max(_choice_count,IDX+1);
	if(Typer_ChoiceIsCompass()){
		Typer_ChoiceCollectStart(IDX);
		return;
	}
	var _pos=Typer_ChoiceSoulAtCursor();
	_choice_x[IDX]=_pos[0];
	_choice_y[IDX]=_pos[1];
}

///@arg line
///@arg shift
function Typer_ChoiceShiftLine() {
	var LINE=argument[0];
	var SHIFT=argument[1];
	if(SHIFT==0||_choice_count<=0)return;
	var I=0;
	repeat(_choice_count){
		if(Typer_ChoiceHasSlot(I)&&I<array_length(_choice_line)&&_choice_line[I]==LINE){
			_choice_x[I]+=SHIFT;
		}
		I+=1;
	}
}

function Typer_ChoiceSoulAtTextStart() {
	draw_set_font(_group_font[_font,0]);
	return [
		_align_offset_x-string_width(" ")*_group_font_scale_x[_font,0]*_scale_x,
		_align_offset_y+string_height(" ")/2*_group_font_scale_y[_font,0]*_scale_y
	];
}

function Typer_ChoiceSetCenterDefault() {
	var _dlg=instance_find(ui_dialog,0);
	if(instance_exists(_dlg)&&_dlg._inst==id){
		var _center_x=321;
		var _center_y=_dlg._top ? 86 : 396;
		var _typer_x=60;
		var _typer_y=_dlg._top ? 30 : 340;
		_choice_cx=_center_x-_typer_x;
		_choice_cy=_center_y-_typer_y;
	}else{
		var _pos=Typer_ChoiceSoulAtTextStart();
		_choice_cx=_pos[0];
		_choice_cy=_pos[1];
	}
	_choice_center_manual=true;
}

function Typer_ChoiceTargetPos() {
	if(_choice_active&&_choice<0)return [_choice_cx,_choice_cy];
	if(_choice>=0)return [_choice_x[_choice],_choice_y[_choice]];
	return [0,0];
}

function Typer_ChoiceSnapVisual() {
	var _t=Typer_ChoiceTargetPos();
	_choice_vx=_t[0];
	_choice_vy=_t[1];
}

function Typer_ChoiceActivate() {
	if(Typer_ChoiceIsCompass()){
		Typer_ChoiceCollectStop();
		Typer_ChoiceLayout();
		Typer_ChoiceCreateChildren();
	}
	if(!_choice_center_manual){
		Typer_ChoiceSetCenterDefault();
	}
	_choice_active=true;
	_choice=_choice_default;
	if(_choice>=0&&!Typer_ChoiceHasSlot(_choice)){
		_choice=-1;
		var I=0;
		repeat(_choice_count){
			if(Typer_ChoiceHasSlot(I)){
				_choice=I;
				break;
			}
			I+=1;
		}
	}
	Typer_ChoiceSnapVisual();
}

///@arg slot
function Typer_ChoiceSelect() {
	var SLOT=argument[0];
	if(!Typer_ChoiceHasSlot(SLOT))return false;
	if(_choice!=SLOT){
		_choice=SLOT;
		if(_choice_switch_snd)audio_play_sound(snd_menu_switch,0,false);
	}
	return true;
}

///@arg slots
function Typer_ChoicePickFirst() {
	var SLOTS=argument[0];
	var i=0;
	repeat(array_length(SLOTS)){
		if(Typer_ChoiceSelect(SLOTS[i]))return true;
		i+=1;
	}
	return false;
}

function Typer_ChoiceStepGrid() {
	if(_choice==-1){
		if(Input_IsPressed(INPUT.UP))Typer_ChoicePickFirst([0,1]);
		if(Input_IsPressed(INPUT.DOWN))Typer_ChoicePickFirst([2,3]);
		if(Input_IsPressed(INPUT.LEFT))Typer_ChoicePickFirst([0,2]);
		if(Input_IsPressed(INPUT.RIGHT))Typer_ChoicePickFirst([1,3]);
		return;
	}
	if(Input_IsPressed(INPUT.DOWN)||Input_IsPressed(INPUT.UP)){
		if(_choice>=0&&_choice<2)Typer_ChoiceSelect(_choice+2);
		else if(_choice>=2)Typer_ChoiceSelect(_choice-2);
	}
	if(Input_IsPressed(INPUT.LEFT)||Input_IsPressed(INPUT.RIGHT)){
		if(_choice>=0&&_choice mod 2==0)Typer_ChoiceSelect(_choice+1);
		else if(_choice>=0)Typer_ChoiceSelect(_choice-1);
	}
}

function Typer_ChoiceStepLinear() {
	var _len=max(_choice_count,2);
	var _fwd=(_choice_dir==0)?INPUT.RIGHT:INPUT.DOWN;
	var _back=(_choice_dir==0)?INPUT.LEFT:INPUT.UP;
	if(Input_IsPressed(_fwd)){
		if(_choice==-1)Typer_ChoiceSelect(0);
		else Typer_ChoiceSelect((_choice+1) mod _len);
	}
	if(Input_IsPressed(_back)){
		if(_choice==-1)Typer_ChoiceSelect(_len-1);
		else Typer_ChoiceSelect((_choice-1+_len) mod _len);
	}
}

function Typer_ChoiceStepCompass() {
	// slot index = compass seat: 0 up 1 left 2 right 3 down
	if(Input_IsPressed(INPUT.UP))Typer_ChoiceSelect(0);
	if(Input_IsPressed(INPUT.LEFT))Typer_ChoiceSelect(1);
	if(Input_IsPressed(INPUT.RIGHT))Typer_ChoiceSelect(2);
	if(Input_IsPressed(INPUT.DOWN))Typer_ChoiceSelect(3);
}

function Typer_ChoiceStep() {
	if(!_choice_active)return;
	if(_choice_dir==3){
		Typer_ChoiceStepCompass();
	}else if(_choice_dir==2){
		Typer_ChoiceStepGrid();
	}else if(_choice_dir==0||_choice_dir==1){
		Typer_ChoiceStepLinear();
	}
	if(Input_IsPressed(INPUT.CONFIRM)&&_choice>=0){
		if(is_string(_choice_macro)&&_choice_macro!=""){
			variable_struct_remove(_macro,_choice_macro);
			_macro[$ _choice_macro]=_choice;
		}
		Flag_Set(FLAG_TEMP,"text_typer_choice",_choice);
		_choice_active=false;
		_choice=-1;
		_paused=false;
		if(_choice_confirm_snd)audio_play_sound(snd_menu_confirm,0,false);
	}
	if(_choice_anim){
		var _t=Typer_ChoiceTargetPos();
		_choice_vx=lerp(_choice_vx,_t[0],0.6);
		_choice_vy=lerp(_choice_vy,_t[1],0.6);
	}
}

function Typer_ChoiceDraw() {
	if(!_choice_active)return;
	var _pos=_choice_anim?[_choice_vx,_choice_vy]:Typer_ChoiceTargetPos();
	draw_sprite_ext(spr_battle_soul_red,0,x+_pos[0],y+_pos[1],1,1,_angle,c_white,1);
}

function Typer_ChoiceIsCompass() {
	return _choice_dir==3;
}

///@arg name
function Typer_ChoiceCmdIsControl() {
	var NAME=argument[0];
	return NAME=="choice"||NAME=="choice_end"||NAME=="choice_default"||NAME=="choice_anim"||NAME=="choice_center"||NAME=="choice_dir"||NAME=="choice_switch_snd"||NAME=="choice_confirm_snd";
}

///@arg text
function Typer_ChoiceTrim() {
	var T=argument[0];
	while(string_length(T)>0){
		var C=string_char_at(T,1);
		if(C==" "||C=="　"||C=="\n"||C=="\r"||C=="&"){
			T=string_delete(T,1,1);
		}else break;
	}
	while(string_length(T)>0){
		var C=string_char_at(T,string_length(T));
		if(C==" "||C=="　"||C=="\n"||C=="\r"||C=="&"){
			T=string_delete(T,string_length(T),1);
		}else break;
	}
	return T;
}

function Typer_ChoiceCollectFlush() {
	if(_choice_collect_idx<0)return;
	while(array_length(_choice_option_texts)<=_choice_collect_idx)array_push(_choice_option_texts,"");
	_choice_option_texts[_choice_collect_idx]=Typer_ChoiceTrim(_choice_collect_text);
	_choice_collect_text="";
}

///@arg index
function Typer_ChoiceCollectStart() {
	var IDX=argument[0];
	Typer_ChoiceCollectFlush();
	_choice_skip_render=true;
	_choice_collect_idx=IDX;
	_choice_collect_text="";
}

function Typer_ChoiceCollectStop() {
	Typer_ChoiceCollectFlush();
	_choice_skip_render=false;
	_choice_collect_idx=-1;
	_choice_collect_text="";
}

function Typer_ChoiceDestroyChildren() {
	if(!variable_instance_exists(id,"_list_choice")||!ds_exists(_list_choice,ds_type_list))return;
	var I=0;
	repeat(ds_list_size(_list_choice)){
		var INST=ds_list_find_value(_list_choice,I);
		if(instance_exists(INST)){
			instance_destroy(INST);
		}
		I+=1;
	}
	ds_list_clear(_list_choice);
}

function Typer_ChoiceLayout() {
	// fixed seats by slot index: 0 up 1 left 2 right 3 down
	_choice_layout_positions=[];
	var LEFT_X=40;
	var RIGHT_X=640-x*2-40;
	var TOP_Y=0;
	var CENTER_Y=0;
	var DLG=instance_find(ui_dialog,0);
	if(instance_exists(DLG)&&DLG._inst==id){
		TOP_Y=(DLG._top ? 30+Lang_GetLayout("dialog.y_top") : 340+Lang_GetLayout("dialog.y_bottom"))-y;
		CENTER_Y=(DLG._top ? 86 : 396)-y;
	}else{
		CENTER_Y=height/2;
	}
	draw_set_font(_group_font[_font,0]);
	var LINE_H=(string_height(" ")+_group_font_space_y[_font]+_space_y)*_group_font_scale_y[_font,0]*_scale_y;
	var BOTTOM_Y=LINE_H*3;
	_choice_layout_positions[0]={ha:1,va:0,x:320-x,y:TOP_Y};
	_choice_layout_positions[1]={ha:0,va:1,x:LEFT_X,y:CENTER_Y};
	_choice_layout_positions[2]={ha:2,va:1,x:RIGHT_X,y:CENTER_Y};
	_choice_layout_positions[3]={ha:1,va:2,x:320-x,y:BOTTOM_Y};
}

function Typer_ChoiceCreateChildren() {
	if(!variable_instance_exists(id,"_list_choice")||!ds_exists(_list_choice,ds_type_list)){
		_list_choice=ds_list_create();
	}
	Typer_ChoiceDestroyChildren();
	if(array_length(_choice_layout_positions)<4)return;
	var I=0;
	repeat(4){
		if(Typer_ChoiceHasSlot(I)){
			var LAYOUT=_choice_layout_positions[I];
			if(!is_undefined(LAYOUT)){
				var OPT="";
				if(I<array_length(_choice_option_texts)&&is_string(_choice_option_texts[I])){
					OPT=_choice_option_texts[I];
				}
				var PREFIX="{instant true}{skippable false}{voice -1}";
				PREFIX+="{shadow "+(_shadow ? "true" : "false")+"}";
				PREFIX+="{per_line_align true}";
				PREFIX+="{gui "+(_gui ? "true" : "false")+"}";
				PREFIX+="{depth "+string(depth)+"}";
				PREFIX+="{font "+string(_font)+"}";
				PREFIX+="{scale "+string(_scale_x)+"}";
				PREFIX+="{space_x "+string(_space_x)+"}";
				PREFIX+="{space_y "+string(_space_y)+"}";
				PREFIX+="{halign "+string(LAYOUT.ha)+"}";
				PREFIX+="{valign "+string(LAYOUT.va)+"}";
				var CHILD=instance_create_depth(x+LAYOUT.x,y+LAYOUT.y,depth,text_typer);
				CHILD._is_mini=true;
				CHILD.override_alpha_enabled=true;
				CHILD.override_alpha=1;
				CHILD._instant=true;
				CHILD._skippable=false;
				CHILD._voice=-1;
				CHILD._font=_font;
				CHILD._scale_x=_scale_x;
				CHILD._scale_y=_scale_y;
				CHILD._gui=_gui;
				CHILD._shadow=_shadow;
				CHILD._space_x=_space_x;
				CHILD._space_y=_space_y;
				CHILD._per_line_align=true;
				CHILD._halign=LAYOUT.ha;
				CHILD._valign=LAYOUT.va;
				CHILD.text=PREFIX+OPT;
				ds_list_add(_list_choice,CHILD);
				var M=Typer_Measure(OPT,_font,_scale_x,_scale_y,_space_x,_space_y);
				var TW=M[0];
				var TH=M[1];
				var LEFT_OFF=0;
				switch(LAYOUT.ha){
					case 1: LEFT_OFF=-TW/2; break;
					case 2: LEFT_OFF=-TW; break;
				}
				draw_set_font(_group_font[_font,0]);
				var PAD=(_group_font_space_y[_font]+_space_y)*_group_font_scale_y[_font,0]*_scale_y;
				var VIS=max(TH-PAD,string_height(" ")*_group_font_scale_y[_font,0]*_scale_y);
				var ALIGN_Y=0;
				switch(LAYOUT.va){
					case 1: ALIGN_Y=-TH/2; break;
					case 2: ALIGN_Y=-TH; break;
				}
				var GAP=string_width(" ")*_group_font_scale_x[_font,0]*_scale_x;
				_choice_x[I]=LAYOUT.x+LEFT_OFF-GAP;
				_choice_y[I]=LAYOUT.y+ALIGN_Y+VIS/2;
			}
		}
		I+=1;
	}
}
