var f=Lang_GetFont("determination_mono",font_mars_needs_cunnilingus);
draw_set_font(f);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var scale=1;
var gui_w=display_get_gui_width();
var gui_h=display_get_gui_height();
var count=array_length(rows);
var line_full=string_height("A")+4;
var line_h=line_full*scale;

var title=title_text;
var max_tw=string_width(title);
for(var i=0;i<count;i++){
	var row=rows[i];
	var sample="";
	if(row.kind=="header"){
		sample="— "+row.label+" —";
	}else if(row.kind=="line"){
		sample=row.label;
	}else{
		sample="> "+row.label;
	}
	max_tw=max(max_tw,string_width(sample));
}

var panel_x=0;
var panel_y=0;
var panel_w=min(gui_w,ceil(max_tw*scale)+16);
var panel_bottom=gui_h;
var header_h=line_h+8;
var list_top=header_h;
var list_h=max(1,panel_bottom-list_top);
visible_rows=max(1,floor(list_h/line_h));

draw_set_color(c_black);
draw_set_alpha(0.5);
draw_rectangle(panel_x,panel_y,panel_x+panel_w,panel_bottom,false);
draw_set_alpha(1);

var tx=panel_x+4;
draw_set_color(c_ltgray);
draw_text_transformed(tx,panel_y+2,title,scale,scale,0);

var list_w_full=max(1,floor((panel_w-8)/scale));
var list_h_full=visible_rows*line_full;

if(!surface_exists(list_surf)||surface_get_width(list_surf)!=list_w_full||surface_get_height(list_surf)!=list_h_full){
	if(surface_exists(list_surf)){
		surface_free(list_surf);
	}
	list_surf=surface_create(list_w_full,list_h_full);
}

surface_set_target(list_surf);
draw_clear_alpha(c_black,0);
draw_set_font(f);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var start_i=floor(scroll);
var scroll_frac=scroll-start_i;
var draw_y=-scroll_frac*line_full;

for(var i=start_i;i<count&&i<=start_i+visible_rows+1;i++){
	if(i<0){
		continue;
	}
	var row=rows[i];
	var row_y=draw_y+(i-start_i)*line_full;
	var text="";

	if(row.kind=="header"){
		draw_set_color(c_ltgray);
		text="— "+row.label+" —";
	}else if(row.kind=="line"){
		draw_set_color(c_ltgray);
		text=row.label;
	}else if(i==selection){
		draw_set_color(c_yellow);
		text="> "+row.label;
	}else{
		draw_set_color(c_white);
		text="  "+row.label;
	}
	draw_text(0,row_y,text);
}
surface_reset_target();

draw_surface_ext(list_surf,tx,list_top,scale,scale,0,c_white,1);

draw_set_color(c_white);
draw_set_alpha(1);
