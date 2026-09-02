///@desc Function
function Init(){
    //text_typer args
    text="";
    _speed=0;
    _char_per_frame=1;
    _voice=0;
    _voice_single=-1;
    _voice_mode=0;
    _voice_mode_interval=6;
    _voice_mode_timer=0;
    _voice_loop_snd=-1;
    _sleep=0;
    _skip=true;
    _skipping=false;
    _paused=false;
    _instant=false;
    _space_x=0;
    _space_y=0;
    _char_frame_remain=0;
    _char_x=0;
    _char_y=0;
    _char="";
    _char_sprite=-1;
    _char_sprite_image=0;
    _char_sprite_speed=1;
    _char_sprite_offset_x=0;
    _char_sprite_offset_y=0;
    _char_proc=1;
    _voice_played=false;
    _voice_pack_config={};
    if(variable_instance_exists(id,"_list_inst")&&ds_exists(_list_inst,ds_type_list)){
        ds_list_destroy(_list_inst);
    }
    if(variable_instance_exists(id,"_list_cmd")&&ds_exists(_list_cmd,ds_type_list)){
        ds_list_destroy(_list_cmd);
    }
    if(variable_instance_exists(id,"_list_mini")&&ds_exists(_list_mini,ds_type_list)){
        var mi=0;
        repeat(ds_list_size(_list_mini)){
            var MINST=ds_list_find_value(_list_mini,mi);
            if(instance_exists(MINST)){
                instance_destroy(MINST);
            }
            mi+=1;
        }
        ds_list_destroy(_list_mini);
    }
    _list_inst=ds_list_create();
    _list_cmd=ds_list_create();
	_list_mini=ds_list_create();
    _map_macro={};
    _face=noone;
    _face_linked=-1;
    _char_linked=-1;
    _skip_space=Lang_GetLayout("skip_space",false);
    _mini_auto_layout=true;
    _mini_align=1;
    _mini_positions=[];
    _mini_pos_index=0;
	_dialog_left=60;
    _dialog_right=500;
	_surface_enabled=false;
    _surface=-1;

    _choice=-1;
    _choice_count=0;
    _choice_x[0]=0;
    _choice_y[0]=0;
    _choice_x[1]=0;
    _choice_y[1]=0;
    _choice_x[2]=0;
    _choice_y[2]=0;
    _choice_x[3]=0;
    _choice_y[3]=0;
    _choice_reg=[];
    _choice_active=false;
    _choice_none=false;
    _choice_cx=0;
    _choice_cy=0;
    _choice_center_manual=false;
    _choice_anim=false;
    _choice_vx=0;
    _choice_vy=0;
    _choice_macro="";
    _choice_switch_snd=true;
    _choice_confirm_snd=true;
    _choice_reject_snd=false;
    _choice_dir=0;

    _align_h=0;
    _align_v=0;
    _align_offset_x=0;
    _align_offset_y=0;

    _per_line_align=true;
    _line=0;
    _last_aligned_line=-1;
    _line_char_count=0;

    _position_follow=true;
    _angle_follow=true;

    _skip_enabled=false;
    _super_skip=false;
    _super_skip_mode=0;
    alarm[1]=1;

    _time=0;
    torder=[];

    _audio_pitch=1;

    _auto_destroy=false;
    _auto_destroy_delay=0;
    _auto_destroy_timer=-1;

    _callback_start={};
    _callback_end={};
		
    _segment_index=0;
    _end_callback_fired=false;
    _clearing_for_new_text=false;
    _text_measured=false;
	
	_is_mini=false;

    //text_single args
    _font=0;
    _scale_x=1;
    _scale_y=1;
    _angle=0;
    _shadow=false;
    _outline=false;
    _color_text[0]=c_white;
    _color_text[1]=c_white;
    _color_text[2]=c_white;
    _color_text[3]=c_white;
    _color_shadow[0]=make_color_rgb(49,49,79);
    _color_shadow[1]=make_color_rgb(49,49,79);
    _color_shadow[2]=make_color_rgb(15,15,115);
    _color_shadow[3]=make_color_rgb(15,15,115);
    _color_outline[0]=make_color_rgb(110,110,110);
    _color_outline[1]=make_color_rgb(110,110,110);
    _color_outline[2]=make_color_rgb(110,110,110);
    _color_outline[3]=make_color_rgb(110,110,110);
    _alpha=1;
    _alpha_text=1;
    _alpha_shadow=1;
    _alpha_outline=1;
    _shadow_x=0.5;
    _shadow_y=0.5;
    _effect=-1;
    _gui=false;

    //group init
    event_user(5);

    width=0;
    height=0;
    _measure_w=0;
    _measure_h=0;
    override_alpha_enabled=false;
    override_alpha=1;
    override_color_text_enabled=false;
    override_color_text[0]=c_white;
    override_color_text[1]=c_white;
    override_color_text[2]=c_white;
    override_color_text[3]=c_white;
}

function ChangeText(TEXT){
    _clearing_for_new_text=true;
    event_user(3);
    _clearing_for_new_text=false;
    Init();
    text = TEXT;
    _segment_index=0;
    _end_callback_fired=false;
    var m=Measure(text);
    _measure_w=m[0];
    _measure_h=m[1];
    _text_measured=true;
    AlignApply();
    if(_mini_auto_layout){
        _mini_positions=ScanMinis(text);
        _mini_pos_index=0;
    }
    TriggerCallback(0);
}

function AlignApply(){
    if(_per_line_align&&_align_h==1){
        _align_offset_x=-_measure_w/2;
    }else{
        switch(_align_h){
            case 1: _align_offset_x=-_measure_w/2; break;
            case 2: _align_offset_x=-_measure_w; break;
            default: _align_offset_x=0; break;
        }
    }
    switch(_align_v){
        case 1: _align_offset_y=-_measure_h/2; break;
        case 2: _align_offset_y=-_measure_h; break;
        default: _align_offset_y=0; break;
    }
    _char_x=(_per_line_align&&_align_h==1) ? 0 : _align_offset_x;
    _char_y=_align_offset_y;
}

function Measure(text, _font_start=0, _scale_x_start=1, _scale_y_start=1, _space_x_start=0, _space_y_start=0){
    var _font=_font_start;
    var _scale_x=_scale_x_start;
    var _scale_y=_scale_y_start;
    var _space_x=_space_x_start;
    var _space_y=_space_y_start;
    var _char_x=0;
    var _char_y=0;
    var max_width=0;
    var _line_height=0;
    
    var _char_proc=1;
    var text_len=string_length(text);
    
    while(_char_proc<=text_len){
        var ch=string_char_at(text,_char_proc);
        
        if(ch=="{"){
            var cmd_end=_char_proc;
            var brace_depth=1;
            while(cmd_end<text_len && brace_depth>0){
                cmd_end+=1;
                var c=string_char_at(text,cmd_end);
                if(c=="{") brace_depth+=1;
                else if(c=="}") brace_depth-=1;
            }
            var cmd_str=string_copy(text,_char_proc+1,cmd_end-_char_proc-1);
            _char_proc=cmd_end+1;
            
            var cmd_name="";
            var cmd_args="";
            var space_pos=0;
            var in_quote=false;
            var cmd_len=string_length(cmd_str);
            for(var i=1;i<=cmd_len;i+=1){
                var cc=string_char_at(cmd_str,i);
                if(cc=="\""){
                    in_quote=!in_quote;
                }
                if(!in_quote && cc==" " && space_pos==0){
                    space_pos=i;
                }
            }
            if(space_pos>0){
                cmd_name=string_copy(cmd_str,1,space_pos-1);
                cmd_args=string_copy(cmd_str,space_pos+1,cmd_len-space_pos);
            }else{
                cmd_name=cmd_str;
            }
            
            switch(cmd_name){
                case "font":
                    if(string_length(cmd_args)>0){
                        var val=real(cmd_args);
                        if(val>=0 && val<array_length(_group_font)){
                            _font=val;
                        }
                    }
                    break;
                case "scale":
                    if(string_length(cmd_args)>0){
                        _scale_x=real(cmd_args);
                        _scale_y=_scale_x;
                    }
                    break;
                case "scale_x":
                    if(string_length(cmd_args)>0){
                        _scale_x=real(cmd_args);
                    }
                    break;
                case "scale_y":
                    if(string_length(cmd_args)>0){
                        _scale_y=real(cmd_args);
                    }
                    break;
                case "space_x":
                    if(string_length(cmd_args)>0){
                        _space_x=real(cmd_args);
                    }
                    break;
                case "space_y":
                    if(string_length(cmd_args)>0){
                        _space_y=real(cmd_args);
                    }
                    break;
                case "define":
                    var def_tokens=[];
                    var def_cur="";
                    var def_bt=false;
                    var def_dlen=string_length(cmd_args);
                    for(var di=1;di<=def_dlen;di+=1){
                        var dc=string_char_at(cmd_args,di);
                        if(dc=="`"){
                            def_bt=!def_bt;
                        }else if(dc==" "&&!def_bt){
                            if(def_cur!=""){
                                array_push(def_tokens,def_cur);
                                def_cur="";
                            }
                        }else{
                            def_cur+=dc;
                        }
                    }
                    if(def_cur!=""){
                        array_push(def_tokens,def_cur);
                    }
                    if(array_length(def_tokens)>=2){
                        variable_struct_remove(_map_macro,def_tokens[0]);
                        _map_macro[$ def_tokens[0]]=def_tokens[1];
                    }
                    break;
                case "undefine":
                    var undef_cur="";
                    var undef_bt=false;
                    var undef_dlen=string_length(cmd_args);
                    for(var ui=1;ui<=undef_dlen;ui+=1){
                        var uc=string_char_at(cmd_args,ui);
                        if(uc=="`"){
                            undef_bt=!undef_bt;
                        }else if(uc==" "&&!undef_bt){
                            break;
                        }else{
                            undef_cur+=uc;
                        }
                    }
                    if(variable_struct_exists(_map_macro,undef_cur)){
                        variable_struct_remove(_map_macro,undef_cur);
                    }
                    break;
                case "insert":
                    var ins_name="";
                    var ins_i=1;
                    var ins_arg_len=string_length(cmd_args);
                    while(ins_i<=ins_arg_len && string_char_at(cmd_args,ins_i)==" "){
                        ins_i+=1;
                    }
                    while(ins_i<=ins_arg_len && string_char_at(cmd_args,ins_i)!=" "){
                        ins_name+=string_char_at(cmd_args,ins_i);
                        ins_i+=1;
                    }
                    if(variable_struct_exists(_map_macro,ins_name)){
                        var ins_text=string(_map_macro[$ ins_name]);
                        var ins_text_len=string_length(ins_text);
                        for(var ins_j=1;ins_j<=ins_text_len;ins_j+=1){
                            var ich=string_char_at(ins_text,ins_j);
                            var ifont=(ord(ich)<128) ? 0 : 1;
                            draw_set_font(_group_font[_font,ifont]);
                            var ichar_w=string_width(ich);
                            _char_x+=ichar_w*_group_font_scale_x[_font,ifont]*_scale_x;
                            max_width=max(max_width,_char_x);
                            _char_x+=(_group_font_space_x[_font,ifont]+_space_x)*_group_font_scale_x[_font,ifont]*_scale_x;
                            var iline_height=(string_height(" ")+_group_font_space_y[_font]+_space_y)*_group_font_scale_y[_font,0]*_scale_y;
                            _line_height=max(_line_height,iline_height);
                        }
                    }
                    break;
                case "sprite"://name spd=1 img=0 xoff=0 yoff=0
                    var spr_name="";
                    var arg_len=string_length(cmd_args);
                    var i=1;
                    while(i<=arg_len && string_char_at(cmd_args,i)==" "){
                        i+=1;
                    }
                    if(i<=arg_len && string_char_at(cmd_args,i)=="`"){
                        i+=1;
                        while(i<=arg_len && string_char_at(cmd_args,i)!="`"){
                            spr_name+=string_char_at(cmd_args,i);
                            i+=1;
                        }
                        i+=1;
                    }
                    var offx=0;
                    var offy=0;
                    var num_index=0;
                    while(i<=arg_len){
                        if(string_char_at(cmd_args,i)==" "){
                            i+=1;
                            continue;
                        }
                        var num_str="";
                        while(i<=arg_len && string_char_at(cmd_args,i)!=" "){
                            num_str+=string_char_at(cmd_args,i);
                            i+=1;
                        }
                        if(num_str!=""){
                            num_index+=1;
                            if(num_index==3){
                                offx=real(num_str);
                            }else if(num_index==4){
                                offy=real(num_str);
                            }
                        }
                    }
                    if(spr_name!=""){
                        var spr=asset_get_index(spr_name);
                        if(sprite_exists(spr)){
                            var font_index=0;
                            draw_set_font(_group_font[_font,font_index]);
                            var spr_w=sprite_get_width(spr);
                            var spr_h=sprite_get_height(spr);
                            var spr_xo=sprite_get_xoffset(spr);
                            var spr_yo=sprite_get_yoffset(spr);
                            var spr_right=_char_x+(spr_xo+offx+spr_w)*_group_font_scale_x[_font,font_index]*_scale_x;
                            _char_x+=(spr_w+_group_font_space_x[_font,font_index]+_space_x)*_group_font_scale_x[_font,font_index]*_scale_x;
                            max_width=max(max_width,spr_right);
                            var spr_bottom=(spr_h-spr_yo+offy)*_scale_y;
                            _line_height=max(_line_height,spr_bottom);
                        }
                    }
                    break;
                case "clear":
                    draw_set_font(_group_font[_font,0]);
                    return [max_width,_char_y+string_height(" ")*_group_font_scale_y[_font,0]*_scale_y];
            }
        }else if(ch=="&"){
            draw_set_font(_group_font[_font,0]);
            var line_height=(string_height(" ")+_group_font_space_y[_font]+_space_y)*_group_font_scale_y[_font,0]*_scale_y;
            _char_x=0;
            _char_y+=max(line_height,_line_height);
            _line_height=0;
            _char_proc+=1;
        }else if(ch=="\\"){
            _char_proc+=1;
            if(_char_proc<=text_len){
                ch=string_char_at(text,_char_proc);
                var font_index=(ord(ch)<128) ? 0 : 1;
                draw_set_font(_group_font[_font,font_index]);
                var char_w=string_width(ch);
                _char_x+=char_w*_group_font_scale_x[_font,font_index]*_scale_x;
                max_width=max(max_width,_char_x);
                _char_x+=(_group_font_space_x[_font,font_index]+_space_x)*_group_font_scale_x[_font,font_index]*_scale_x;
                var line_height=(string_height(" ")+_group_font_space_y[_font]+_space_y)*_group_font_scale_y[_font,0]*_scale_y;
                _line_height=max(_line_height,line_height);
                _char_proc+=1;
            }
        }else{
            var font_index=(ord(ch)<128) ? 0 : 1;
            draw_set_font(_group_font[_font,font_index]);
            var char_w=string_width(ch);
            _char_x+=char_w*_group_font_scale_x[_font,font_index]*_scale_x;
            max_width=max(max_width,_char_x);
            _char_x+=(_group_font_space_x[_font,font_index]+_space_x)*_group_font_scale_x[_font,font_index]*_scale_x;
            var line_height=(string_height(" ")+_group_font_space_y[_font]+_space_y)*_group_font_scale_y[_font,0]*_scale_y;
            _line_height=max(_line_height,line_height);
            _char_proc+=1;
        }
    }
    
    draw_set_font(_group_font[_font,0]);
    return [max_width,_char_y+string_height(" ")*_group_font_scale_y[_font,0]*_scale_y];
}

function TriggerCallback(type){
    var map=(type==0) ? _callback_start : _callback_end;
    var key=string(_segment_index);
    if(!variable_struct_exists(map,key)) return;
    var list=map[$ key];
    var len=array_length(list);
    for(var i=0;i<len;i+=1){
        if(!is_undefined(list[i])){
            list[i]();
        }
    }
}

function AddFunc(type,index,func){
    var map=(type==0) ? _callback_start : _callback_end;
    var key=string(index);
    if(!variable_struct_exists(map,key)){
        map[$ key]=[];
    }
    var list=map[$ key];
    array_push(list,func);
}

function RemoveFunc(type,index){
    var map=(type==0) ? _callback_start : _callback_end;
    var key=string(index);
    if(variable_struct_exists(map,key)){
        variable_struct_remove(map,key);
    }
}

function VoicePack(index,config){
    var sounds=config.sounds;
    var len=array_length(sounds);
    var stop=true;
    if(variable_struct_exists(config,"stop")){
        stop=config.stop;
    }
    for(var i=0;i<len;i+=1){
        _group_voice[index,i]=sounds[i];
        _group_voice_stop[index,i]=stop;
    }
    var cfg={};
    if(variable_struct_exists(config,"mode")){
        cfg.mode=config.mode;
    }
    if(variable_struct_exists(config,"interval")){
        cfg.interval=config.interval;
    }
    if(variable_struct_exists(config,"pitch")){
        cfg.pitch=config.pitch;
    }
    _voice_pack_config[$ string(index)]=cfg;
}

function ScanMinis(text){
    var positions=[];
    var len=string_length(text);
    var i=1;
    var scan_scale_x=_scale_x;
    var scan_dialog_right=_dialog_right;
    var scan_dialog_left=_dialog_left;
    var scan_mini_align=_mini_align;
    while(i<=len){
        if(string_char_at(text,i)=="{"){
            if(i+5<=len && string_copy(text,i+1,5)=="clear"){
                var check=i+6;
                while(check<=len && string_char_at(text,check)==" ") check+=1;
                if(check<=len && string_char_at(text,check)=="}"){
                    break;
                }
            }
            var cmd_start=i+1;
            var cmd_end=cmd_start;
            var brace_depth=1;
            while(cmd_end<=len && brace_depth>0){
                if(string_char_at(text,cmd_end)=="{") brace_depth+=1;
                else if(string_char_at(text,cmd_end)=="}") brace_depth-=1;
                if(brace_depth>0) cmd_end+=1;
            }
            var cmd_str=string_copy(text,cmd_start,cmd_end-cmd_start);
            var space_pos=0;
            var in_quote=false;
            var cmd_len=string_length(cmd_str);
            var si=1;
            while(si<=cmd_len){
                var cc=string_char_at(cmd_str,si);
                if(cc=="`"){
                    in_quote=!in_quote;
                }
                if(!in_quote && cc==" " && space_pos==0){
                    space_pos=si;
                }
                si+=1;
            }
            var cmd_name="";
            if(space_pos>0){
                cmd_name=string_copy(cmd_str,1,space_pos-1);
            }else{
                cmd_name=cmd_str;
            }
            if(cmd_name=="scale" || cmd_name=="scale_x"){
                var cmd_args=string_copy(cmd_str,space_pos+1,cmd_len-space_pos);
                if(string_length(cmd_args)>0){
                    scan_scale_x=real(cmd_args);
                }
            }
            if(cmd_name=="dialog_left"){
                var cmd_args=string_copy(cmd_str,space_pos+1,cmd_len-space_pos);
                if(string_length(cmd_args)>0){
                    scan_dialog_left=real(cmd_args);
                }
            }
            if(cmd_name=="dialog_right"){
                var cmd_args=string_copy(cmd_str,space_pos+1,cmd_len-space_pos);
                if(string_length(cmd_args)>0){
                    scan_dialog_right=real(cmd_args);
                }
            }
            if(cmd_name=="mini_align"){
                var cmd_args=string_copy(cmd_str,space_pos+1,cmd_len-space_pos);
                if(string_length(cmd_args)>0){
                    scan_mini_align=real(cmd_args);
                }
            }
            if(cmd_name=="mini"){
                var args_str=string_copy(cmd_str,space_pos+1,cmd_len-space_pos);
                var args=[];
                var current_arg="";
                var in_quote2=false;
                var arg_len=string_length(args_str);
                var ai=1;
                while(ai<=arg_len){
                    var ch=string_char_at(args_str,ai);
                    if(ch=="`"){
                        in_quote2=!in_quote2;
                        ai+=1;
                        continue;
                    }
                    if(ch==" " && !in_quote2){
                        if(current_arg!=""){
                            array_push(args,current_arg);
                            current_arg="";
                        }
                        ai+=1;
                        continue;
                    }
                    current_arg+=ch;
                    ai+=1;
                }
                if(current_arg!=""){
                    array_push(args,current_arg);
                }
                if(array_length(args)>=1){
                    var mtxt=args[0];
                    var mface=(array_length(args)>=2) ? real(args[1]) : -1;
                    var mfont=(array_length(args)>=4) ? real(args[3]) : _font;
                    if(mfont<0||mfont>=array_length(_group_font))mfont=_font;
                    var mox=(array_length(args)>=5) ? real(args[4]) : 0;
                    var mscale=scan_scale_x*0.5;
                    var mw=0;
                    if(mtxt!=""){
                        var mm=Measure(mtxt,mfont,mscale,mscale,0,0);
                        mw=mm[0];
                    }
                    var has_face=(mface>=0 && mface<array_length(_group_face));
                    var effective_w=mw+(has_face ? 60*mscale : 0)+30*mscale;
                    array_push(positions,{mw: mw, ew: effective_w, mox: mox});
                }
            }
            i=cmd_end;
        }
        i+=1;
    }
    var count=array_length(positions);
    if(count==0) return [];
	var left_edge=x+scan_dialog_left;
    var right_edge=x+scan_dialog_right;
    var result=[];
    for(var j=0;j<count;j+=1){
        var mx;
        if(scan_mini_align==0){
            mx=left_edge+positions[j].mox;
            for(var k=j-1;k>=0;k-=1){
                mx+=positions[k].ew;
            }
        }else{
            mx=right_edge+positions[j].mox-positions[j].mw;
            for(var k=j+1;k<count;k+=1){
                mx-=positions[k].ew;
            }
        }
        array_push(result,mx+30*mscale*(scan_mini_align==1));
    }
    return result;
}
	
function SetSurface(surf){
	_surface_enabled = true;
	_surface = surf;
}

function CharSpacing(CHARS,CH,NEXT="") {
	var BEFORE=0;
	var AFTER=0;
	var AFTER_SAME=0;
	var WIDTH_ADD=0;

	if(!is_struct(CHARS)){
		return [0,0,0];
	}

	if(is_array(CHARS.offsets_default)&&array_length(CHARS.offsets_default)>=3){
		AFTER=CHARS.offsets_default[0];
		BEFORE=CHARS.offsets_default[1];
		AFTER_SAME=CHARS.offsets_default[2];
	}

	if(variable_struct_exists(CHARS,"offsets")){
		var OFF=CHARS.offsets;
		var O=undefined;
		if(variable_struct_exists(OFF,CH)){
			O=OFF[$ CH];
		}else{
			var ORD_KEY="#"+string(ord(CH));
			if(variable_struct_exists(OFF,ORD_KEY)){
				O=OFF[$ ORD_KEY];
			}
		}
		if(is_array(O)&&array_length(O)>=3){
			AFTER=O[0];
			BEFORE=O[1];
			AFTER_SAME=O[2];
		}
	}

	if(NEXT!=""&&NEXT==CH){
		AFTER=AFTER_SAME;
	}

	if(variable_struct_exists(CHARS,"widths")&&variable_struct_exists(CHARS.widths,CH)){
		WIDTH_ADD=CHARS.widths[$ CH];
	}

	return [BEFORE,AFTER,WIDTH_ADD];
}

// 返回字符的纵向偏移量（正数=向下，负数=向上）
// offsets_y 数组格式: [字, 下偏移, 上偏移]
//   下偏移    - 向下偏移量（正=向下）
//   上偏移    - 向上偏移量（正=向上），与“下偏移”叠加后取净偏移
// 说明：同一字符无论是否连续出现，偏移量均一致（= 下偏移 - 上偏移）
function CharOffsetY(CHARS,CH) {
	var DOWN=0;
	var UP=0;

	if(!is_struct(CHARS)){
		return 0;
	}

	if(is_array(CHARS.offsets_y_default)&&array_length(CHARS.offsets_y_default)>=2){
		DOWN=CHARS.offsets_y_default[0];
		UP=CHARS.offsets_y_default[1];
	}

	if(variable_struct_exists(CHARS,"offsets_y")){
		var OFF=CHARS.offsets_y;
		var O=undefined;
		if(variable_struct_exists(OFF,CH)){
			O=OFF[$ CH];
		}else{
			var ORD_KEY="#"+string(ord(CH));
			if(variable_struct_exists(OFF,ORD_KEY)){
				O=OFF[$ ORD_KEY];
			}
		}
		if(is_array(O)&&array_length(O)>=2){
			DOWN=O[0];
			UP=O[1];
		}
	}

	// 纵向偏移只取决于字符自身（下偏移-上偏移），不随相邻字符改变，
	// 因此同一字符连续出现时偏移量始终一致。
	return DOWN-UP;
}

function ChoiceParseBool(_val){
	if(is_bool(_val))return _val;
	if(is_string(_val))return string_lower(_val)=="true";
	if(is_real(_val))return _val!=0;
	return false;
}

function ChoiceHasSlot(_idx){
	if(_idx<0||_idx>=array_length(_choice_reg))return false;
	return _choice_reg[_idx];
}

function ChoiceSoulAtCursor(){
	draw_set_font(_group_font[_font,0]);
	return [
		_char_x-string_width(" ")*_group_font_scale_x[_font,0]*_scale_x,
		_char_y+string_height(" ")/2*_group_font_scale_y[_font,0]*_scale_y
	];
}

function ChoiceRegister(_idx){
	var _pos=ChoiceSoulAtCursor();
	while(array_length(_choice_reg)<=_idx)array_push(_choice_reg,false);
	_choice_x[_idx]=_pos[0];
	_choice_y[_idx]=_pos[1];
	_choice_reg[_idx]=true;
	_choice_count=max(_choice_count,_idx+1);
}

function ChoiceSetCenterFromCursor(){
	var _pos=ChoiceSoulAtCursor();
	_choice_cx=_pos[0];
	_choice_cy=_pos[1];
	_choice_center_manual=true;
}

function ChoiceCalcCenter(){
	if(_choice_center_manual)return;
	var _minx,_miny,_maxx,_maxy,_has=false;
	for(var _i=0;_i<_choice_count;_i++){
		if(!ChoiceHasSlot(_i))continue;
		var _cx=_choice_x[_i];
		var _cy=_choice_y[_i];
		if(!_has){
			_minx=_cx;
			_miny=_cy;
			_maxx=_cx;
			_maxy=_cy;
			_has=true;
		}else{
			_minx=min(_minx,_cx);
			_miny=min(_miny,_cy);
			_maxx=max(_maxx,_cx);
			_maxy=max(_maxy,_cy);
		}
	}
	if(!_has){
		_choice_cx=0;
		_choice_cy=0;
		return;
	}
	_choice_cx=(_minx+_maxx)*0.5;
	_choice_cy=(_miny+_maxy)*0.5;
}

function ChoiceTargetPos(){
	if(_choice_active&&_choice_none&&_choice<0)return [_choice_cx,_choice_cy];
	if(_choice>=0)return [_choice_x[_choice],_choice_y[_choice]];
	return [0,0];
}

function ChoiceSnapVisual(){
	var _t=ChoiceTargetPos();
	_choice_vx=_t[0];
	_choice_vy=_t[1];
}

function ChoiceActivate(){
	ChoiceCalcCenter();
	_choice_active=true;
	_choice=(_choice_none)?-1:0;
	ChoiceSnapVisual();
}

function ChoiceTrySelect(_slot){
	if(!ChoiceHasSlot(_slot))return false;
	if(_choice!=_slot){
		_choice=_slot;
		if(_choice_switch_snd)audio_play_sound(snd_menu_switch,0,false);
	}
	return true;
}

function ChoicePickFirst(_slots){
	for(var _i=0;_i<array_length(_slots);_i++){
		if(ChoiceTrySelect(_slots[_i]))return true;
	}
	return false;
}

function ChoiceStepGrid(){
	if(_choice_none){
		if(Input_IsPressed(INPUT.UP)){
			if(_choice==-1)ChoicePickFirst([0,1]);
			else if(_choice>=2)ChoiceTrySelect(_choice-2);
		}
		if(Input_IsPressed(INPUT.DOWN)){
			if(_choice==-1)ChoicePickFirst([2,3]);
			else if(_choice<2)ChoiceTrySelect(_choice+2);
		}
		if(Input_IsPressed(INPUT.LEFT)){
			if(_choice==-1)ChoicePickFirst([0,2]);
			else if(_choice mod 2==1)ChoiceTrySelect(_choice-1);
		}
		if(Input_IsPressed(INPUT.RIGHT)){
			if(_choice==-1)ChoicePickFirst([1,3]);
			else if(_choice mod 2==0)ChoiceTrySelect(_choice+1);
		}
		return;
	}
	if(Input_IsPressed(INPUT.DOWN)||Input_IsPressed(INPUT.UP)){
		if(_choice>=0&&_choice<2)ChoiceTrySelect(_choice+2);
		else if(_choice>=2)ChoiceTrySelect(_choice-2);
	}
	if(Input_IsPressed(INPUT.LEFT)||Input_IsPressed(INPUT.RIGHT)){
		if(_choice>=0&&_choice mod 2==0)ChoiceTrySelect(_choice+1);
		else if(_choice>=0)ChoiceTrySelect(_choice-1);
	}
}

function ChoiceStepLinear(){
	var _len=max(_choice_count,2);
	var _fwd=(_choice_dir==0)?INPUT.RIGHT:INPUT.DOWN;
	var _back=(_choice_dir==0)?INPUT.LEFT:INPUT.UP;
	if(Input_IsPressed(_fwd)){
		if(_choice_none&&_choice==-1)ChoiceTrySelect(0);
		else ChoiceTrySelect((_choice+1) mod _len);
	}
	if(Input_IsPressed(_back)){
		if(_choice_none&&_choice==-1)ChoiceTrySelect(_len-1);
		else ChoiceTrySelect((_choice-1+_len) mod _len);
	}
}

function ChoiceStep(){
	if(!_choice_active)return;
	if(_choice_dir==3){
		if(Input_IsPressed(INPUT.UP))ChoiceTrySelect(0);
		if(Input_IsPressed(INPUT.LEFT))ChoiceTrySelect(1);
		if(Input_IsPressed(INPUT.RIGHT))ChoiceTrySelect(2);
		if(Input_IsPressed(INPUT.DOWN))ChoiceTrySelect(3);
	}else if(_choice_dir==2){
		ChoiceStepGrid();
	}else if(_choice_dir==0||_choice_dir==1){
		ChoiceStepLinear();
	}
	if(Input_IsPressed(INPUT.CONFIRM)&&_choice>=0){
		if(is_string(_choice_macro)&&_choice_macro!=""){
			variable_struct_remove(_map_macro,_choice_macro);
			_map_macro[$ _choice_macro]=_choice;
		}
		Flag_Set(FLAG_TEMP,"text_typer_choice",_choice);
		_choice_active=false;
		_choice=-1;
		_paused=false;
		if(_choice_confirm_snd)audio_play_sound(snd_menu_confirm,0,false);
	}
	if(_choice_anim){
		var _t=ChoiceTargetPos();
		_choice_vx=lerp(_choice_vx,_t[0],0.6);
		_choice_vy=lerp(_choice_vy,_t[1],0.6);
	}
}

function ChoiceDraw(){
	if(!_choice_active)return;
	var _pos=_choice_anim?[_choice_vx,_choice_vy]:ChoiceTargetPos();
	if(_angle!=0){
		draw_sprite_ext(spr_battle_soul_red,0,x+_pos[0],y+_pos[1],1,1,_angle,c_white,1);
	}else{
		draw_sprite(spr_battle_soul_red,0,x+_pos[0],y+_pos[1]);
	}
}