function Typer_Align() {
	switch(_halign){
		case 1: _align_offset_x=-_measure_w/2; break;
		case 2: _align_offset_x=-_measure_w; break;
		default: _align_offset_x=0; break;
	}
	switch(_valign){
		case 1: _align_offset_y=-_measure_h/2; break;
		case 2: _align_offset_y=-_measure_h; break;
		default: _align_offset_y=0; break;
	}
	_char_x=_per_line_align ? 0 : _align_offset_x;
	_char_y=_align_offset_y;
}

///@arg text
///@arg font*
///@arg scale_x*
///@arg scale_y*
///@arg space_x*
///@arg space_y*
function Typer_Measure() {
	var mtext=argument[0];
	var mfont=(argument_count>1) ? argument[1] : 0;
	var mscale_x=(argument_count>2) ? argument[2] : 1;
	var mscale_y=(argument_count>3) ? argument[3] : 1;
	var mspace_x=(argument_count>4) ? argument[4] : 0;
	var mspace_y=(argument_count>5) ? argument[5] : 0;
	var mx=0;
	var my=0;
	var max_width=0;
	var line_height=0;
	var proc=1;
	var text_len=string_length(mtext);
	var space_y_font=0;

	while(proc<=text_len){
		var ch=string_char_at(mtext,proc);
		if(ch=="{"){
			var cmd_end=proc;
			var brace_depth=1;
			while(cmd_end<text_len&&brace_depth>0){
				cmd_end+=1;
				var c=string_char_at(mtext,cmd_end);
				if(c=="{")brace_depth+=1;
				else if(c=="}")brace_depth-=1;
			}
			var cmd_str=string_copy(mtext,proc+1,cmd_end-proc-1);
			proc=cmd_end+1;

			var cmd_name="";
			var cmd_args="";
			var space_pos=0;
			var in_quote=false;
			var cmd_len=string_length(cmd_str);
			var i=1;
			repeat(cmd_len){
				var cc=string_char_at(cmd_str,i);
				if(cc=="`"||cc=="\"")in_quote=!in_quote;
				if(!in_quote&&cc==" "&&space_pos==0)space_pos=i;
				i+=1;
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
						if(val>=0&&val<array_height_2d(_group_font))mfont=val;
					}
					break;
				case "scale":
					if(string_length(cmd_args)>0){
						mscale_x=real(cmd_args);
						mscale_y=mscale_x;
					}
					break;
				case "scale_x":
					if(string_length(cmd_args)>0)mscale_x=real(cmd_args);
					break;
				case "scale_y":
					if(string_length(cmd_args)>0)mscale_y=real(cmd_args);
					break;
				case "space_x":
					if(string_length(cmd_args)>0)mspace_x=real(cmd_args);
					break;
				case "space_y":
					if(string_length(cmd_args)>0)mspace_y=real(cmd_args);
					break;
				case "sprite":
					var spr=-1;
					var offx=0;
					var offy=0;
					var arg_len=string_length(cmd_args);
					var si=1;
					while(si<=arg_len&&string_char_at(cmd_args,si)==" ")si+=1;
					if(si<=arg_len&&string_char_at(cmd_args,si)=="`"){
						si+=1;
						var spr_name="";
						while(si<=arg_len&&string_char_at(cmd_args,si)!="`"){
							spr_name+=string_char_at(cmd_args,si);
							si+=1;
						}
						if(spr_name!="")spr=asset_get_index(spr_name);
						if(si<=arg_len&&string_char_at(cmd_args,si)=="`")si+=1;
					}else{
						var id_str="";
						while(si<=arg_len&&string_char_at(cmd_args,si)!=" "){
							id_str+=string_char_at(cmd_args,si);
							si+=1;
						}
						if(id_str!=""){
							var spr_id=real(id_str);
							if(sprite_exists(spr_id))spr=spr_id;
						}
					}
					var num_index=0;
					while(si<=arg_len){
						if(string_char_at(cmd_args,si)==" "){
							si+=1;
							continue;
						}
						var num_str="";
						while(si<=arg_len&&string_char_at(cmd_args,si)!=" "){
							num_str+=string_char_at(cmd_args,si);
							si+=1;
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
					if(sprite_exists(spr)){
						var next_ch=(proc<=text_len) ? string_char_at(mtext,proc) : "";
						var chars=(variable_instance_exists(id,"_group_font_chars") ? _group_font_chars[mfont,0] : undefined);
						var sp=Typer_CharSpacing(chars,"",next_ch);
						var scx=_group_font_scale_x[mfont,0]*mscale_x;
						var next_face=(next_ch!=""&&ord(next_ch)<128)?0:1;
						var space_face=Typer_FaceSpaceX(_group_font_space_x[mfont,0],_group_font_space_x[mfont,next_face],"",next_ch);
						mx+=sp[0]*scx;
						mx+=(sprite_get_width(spr)+offx+space_face+mspace_x+sp[2])*scx;
						mx+=sp[1]*scx;
						max_width=max(max_width,mx);
						draw_set_font(_group_font[mfont,0]);
						space_y_font=_group_font_space_y[mfont];
						var line_h=(string_height(" ")+space_y_font+mspace_y)*_group_font_scale_y[mfont,0]*mscale_y;
						line_h=max(line_h,(sprite_get_height(spr)-sprite_get_yoffset(spr)+offy)*mscale_y);
						line_height=max(line_height,line_h);
					}
					break;
				case "clear":
					draw_set_font(_group_font[mfont,0]);
					space_y_font=_group_font_space_y[mfont];
					var line_height_clear=(string_height(" ")+space_y_font+mspace_y)*_group_font_scale_y[mfont,0]*mscale_y;
					return [max_width,my+max(line_height_clear,line_height)];
			}
		}else if(ch=="\n"||ch=="&"){
			draw_set_font(_group_font[mfont,0]);
			space_y_font=_group_font_space_y[mfont];
			var line_height_nl=(string_height(" ")+space_y_font+mspace_y)*_group_font_scale_y[mfont,0]*mscale_y;
			mx=0;
			my+=max(line_height_nl,line_height);
			line_height=0;
			proc+=1;
		}else if(ch=="\\"){
			proc+=1;
			if(proc<=text_len){
				ch=string_char_at(mtext,proc);
				var font_index_esc=(ord(ch)<128) ? 0 : 1;
				draw_set_font(_group_font[mfont,font_index_esc]);
				var next_esc=(proc+1<=text_len) ? string_char_at(mtext,proc+1) : "";
				var chars_esc=(variable_instance_exists(id,"_group_font_chars") ? _group_font_chars[mfont,font_index_esc] : undefined);
				var sp_esc=Typer_CharSpacing(chars_esc,ch,next_esc);
				var scx_esc=_group_font_scale_x[mfont,font_index_esc]*mscale_x;
				var next_face_esc=(next_esc!=""&&ord(next_esc)<128)?0:1;
				var space_esc=Typer_FaceSpaceX(_group_font_space_x[mfont,font_index_esc],_group_font_space_x[mfont,next_face_esc],ch,next_esc);
				mx+=sp_esc[0]*scx_esc;
				mx+=(string_width(ch)+space_esc+mspace_x+sp_esc[2])*scx_esc;
				mx+=sp_esc[1]*scx_esc;
				max_width=max(max_width,mx);
				draw_set_font(_group_font[mfont,0]);
				space_y_font=_group_font_space_y[mfont];
				line_height=max(line_height,(string_height(" ")+space_y_font+mspace_y)*_group_font_scale_y[mfont,0]*mscale_y);
				proc+=1;
			}
		}else{
			var font_index=(ord(ch)<128) ? 0 : 1;
			draw_set_font(_group_font[mfont,font_index]);
			var next_ch=(proc+1<=text_len) ? string_char_at(mtext,proc+1) : "";
			var chars=(variable_instance_exists(id,"_group_font_chars") ? _group_font_chars[mfont,font_index] : undefined);
			var sp=Typer_CharSpacing(chars,ch,next_ch);
			var scx=_group_font_scale_x[mfont,font_index]*mscale_x;
			var next_face=(next_ch!=""&&ord(next_ch)<128)?0:1;
			var space_face=Typer_FaceSpaceX(_group_font_space_x[mfont,font_index],_group_font_space_x[mfont,next_face],ch,next_ch);
			mx+=sp[0]*scx;
			mx+=(string_width(ch)+space_face+mspace_x+sp[2])*scx;
			mx+=sp[1]*scx;
			max_width=max(max_width,mx);
			draw_set_font(_group_font[mfont,0]);
			space_y_font=_group_font_space_y[mfont];
			line_height=max(line_height,(string_height(" ")+space_y_font+mspace_y)*_group_font_scale_y[mfont,0]*mscale_y);
			proc+=1;
		}
	}

	if(line_height<=0){
		return [max_width,my];
	}
	draw_set_font(_group_font[mfont,0]);
	space_y_font=_group_font_space_y[mfont];
	var line_height_end=(string_height(" ")+space_y_font+mspace_y)*_group_font_scale_y[mfont,0]*mscale_y;
	return [max_width,my+max(line_height_end,line_height)];
}

///@arg text
function Typer_MiniScan() {
	var TEXT=argument[0];
	var positions=[];
	var len=string_length(TEXT);
	var i=1;
	var scan_scale_x=_scale_x;
	var scan_mini_right=_mini_right;
	var scan_mini_left=_mini_left;
	var scan_mini_align=_mini_align;
	while(i<=len){
		if(string_char_at(TEXT,i)=="{"){
			if(i+5<=len&&string_copy(TEXT,i+1,5)=="clear"){
				var check=i+6;
				while(check<=len&&string_char_at(TEXT,check)==" ")check+=1;
				if(check<=len&&string_char_at(TEXT,check)=="}"){
					break;
				}
			}
			var cmd_start=i+1;
			var cmd_end=cmd_start;
			var brace_depth=1;
			while(cmd_end<=len&&brace_depth>0){
				if(string_char_at(TEXT,cmd_end)=="{")brace_depth+=1;
				else if(string_char_at(TEXT,cmd_end)=="}")brace_depth-=1;
				if(brace_depth>0)cmd_end+=1;
			}
			var cmd_str=string_copy(TEXT,cmd_start,cmd_end-cmd_start);
			var space_pos=0;
			var in_quote=false;
			var cmd_len=string_length(cmd_str);
			var si=1;
			while(si<=cmd_len){
				var cc=string_char_at(cmd_str,si);
				if(cc=="`"){
					in_quote=!in_quote;
				}
				if(!in_quote&&cc==" "&&space_pos==0){
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
			if(cmd_name=="scale"||cmd_name=="scale_x"){
				var cmd_args=string_copy(cmd_str,space_pos+1,cmd_len-space_pos);
				if(string_length(cmd_args)>0){
					scan_scale_x=real(cmd_args);
				}
			}
			if(cmd_name=="mini_left"){
				var cmd_args_dl=string_copy(cmd_str,space_pos+1,cmd_len-space_pos);
				if(string_length(cmd_args_dl)>0){
					scan_mini_left=real(cmd_args_dl);
				}
			}
			if(cmd_name=="mini_right"){
				var cmd_args_dr=string_copy(cmd_str,space_pos+1,cmd_len-space_pos);
				if(string_length(cmd_args_dr)>0){
					scan_mini_right=real(cmd_args_dr);
				}
			}
			if(cmd_name=="mini_align"){
				var cmd_args_ma=string_copy(cmd_str,space_pos+1,cmd_len-space_pos);
				if(string_length(cmd_args_ma)>0){
					scan_mini_align=real(cmd_args_ma);
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
					if(ch==" "&&!in_quote2){
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
					if(mfont<0||mfont>=array_height_2d(_group_font))mfont=_font;
					var mox=(array_length(args)>=5) ? real(args[4]) : 0;
					var mscale=scan_scale_x*0.5;
					var mw=0;
					if(mtxt!=""){
						var mm=Typer_Measure(mtxt,mfont,mscale,mscale,0,0);
						mw=mm[0];
					}
					var has_face=(mface>=0&&mface<array_length_1d(_group_face));
					var effective_w=mw+(has_face ? 60*mscale : 0)+30*mscale;
					array_push(positions,{mw:mw,ew:effective_w,mox:mox});
				}
			}
			i=cmd_end;
		}
		i+=1;
	}
	var count=array_length(positions);
	if(count==0)return [];
	var left_edge=x+scan_mini_left;
	var right_edge=x+scan_mini_right;
	var half=scan_scale_x*0.5;
	var result=[];
	var j=0;
	repeat(count){
		var mx;
		if(scan_mini_align==0){
			mx=left_edge+positions[j].mox;
			var k=j-1;
			while(k>=0){
				mx+=positions[k].ew;
				k-=1;
			}
		}else{
			mx=right_edge+positions[j].mox-positions[j].mw;
			var k2=j+1;
			while(k2<count){
				mx-=positions[k2].ew;
				k2+=1;
			}
		}
		array_push(result,mx+30*half*(scan_mini_align==1));
		j+=1;
	}
	return result;
}
