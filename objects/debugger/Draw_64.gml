draw_set_font(font_crypt_of_tomorrow);
draw_set_color(c_white);
draw_set_alpha(0.3);
draw_set_halign(fa_right)
draw_set_valign(fa_bottom)
draw_text_transformed(640,480,string(GAME_VERSION),2,2,0);
draw_set_halign(fa_left)
draw_set_valign(fa_top)

draw_set_color(c_white);
draw_set_alpha(1);

if(!global.debug){
	exit;
}

var show_chord=armed;
var show_feedback=feedback_time>0&&feedback!="";
if(!show_chord&&!show_feedback){
	exit;
}

draw_set_font(Lang_GetFont("determination_mono",font_mars_needs_cunnilingus));
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var label="";
var hold_need=hold_default;
var draw_bar=false;

if(show_chord){
	if(cur_key!=""){
		label="TAB+"+string_upper(cur_key);
		if(variable_struct_exists(commands,cur_key)){
			var cmd=commands[$ cur_key];
			label+="\n"+cmd.name;
			if(variable_struct_exists(cmd,"tip")&&is_method(cmd.tip)){
				label+="\n"+cmd.tip();
			}
			if(variable_struct_exists(cmd,"hold")){
				hold_need=cmd.hold;
			}
			draw_bar=charge>0;
		}
	}else{
		label="TAB";
	}
}else if(show_feedback){
	label=feedback;
}

if(hold_need<=0){
	hold_need=0.01;
}

var scale=1;
var tw=string_width(label)*scale;
var th=string_height(label)*scale;
var xx=floor(display_get_gui_width()/2-tw/2);
var yy=4;

var alpha=1;
if(show_feedback&&!show_chord){
	alpha=clamp(feedback_time/feedback_duration,0,1);
}

draw_set_color(c_black);
draw_set_alpha(0.5*alpha);
draw_rectangle(xx,yy,xx+tw,yy+th,false);
draw_set_alpha(alpha);

draw_set_color(show_feedback&&!show_chord?c_yellow:c_white);
draw_text_transformed(xx,yy,label,scale,scale,0);

if(draw_bar){
	var bar_y=yy+th+1;
	var ratio=clamp(charge/hold_need,0,1);
	draw_set_color(c_white);
	draw_set_alpha(1);
	draw_rectangle(xx,bar_y,xx+tw*ratio,bar_y+4,false);
}

draw_set_color(c_white);
draw_set_alpha(1);
