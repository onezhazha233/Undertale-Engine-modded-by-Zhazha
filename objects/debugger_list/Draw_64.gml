Debugger_ListUpdateLayout(id);

var f=Lang_GetFont("determination_mono",font_mars_needs_cunnilingus);
draw_set_font(f);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var scale=layout_scale;
var gui_w=display_get_gui_width();
var gui_h=display_get_gui_height();
var count=array_length(rows);
var line_full=layout_line_full;
var line_h=layout_line_h;
var pad_l=layout_pad_l;
var pad_r=layout_pad_r;
var item_indent=layout_item_indent;
var title=search_enabled?"Search":title_text;

var panel_x=0;
var panel_y=0;
var panel_w=layout_panel_w;
var searchbar_top=layout_searchbar_top;
var search_bar_h=layout_search_bar_h;
var header_h=layout_list_top;
var list_top=header_h;
var panel_bottom=gui_h;

draw_set_color(c_black);
draw_set_alpha(0.5);
draw_rectangle(panel_x,panel_y,panel_x+panel_w,panel_bottom,false);
draw_set_alpha(1);

var tx=panel_x+pad_l;
var bar_w=panel_w-pad_l-pad_r;

var list_w_full=max(1,floor((panel_w-pad_l-pad_r)/scale));
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

var sel_text="";
var sel_tw=0;
var sel_th=line_full;

for(var i=start_i;i<count&&i<=start_i+visible_rows+1;i++){
	if(i<0){
		continue;
	}
	var row=rows[i];
	var row_y=draw_y+(i-start_i)*line_full;
	var text="";

	if(row.kind=="header"){
		var hcol=Debugger_ListCategoryColor(row.label);
		if(variable_struct_exists(row,"color")){
			hcol=row.color;
		}
		Debugger_ListDrawHeader(0,row_y,row.label,scale,hcol);
	}else if(row.kind=="line"){
		draw_set_color(c_ltgray);
		text=row.label;
		draw_text(0,row_y,text);
	}else{
		text=row.label;
		var ix=item_indent;
		if(i==selection){
			sel_text=text;
			sel_tw=string_width(text);
		}
		if(search_enabled&&search_input!=""){
			var pos=string_pos(string_lower(search_input),string_lower(text));
			if(pos>0){
				var pre=string_copy(text,1,pos-1);
				var match_w=string_width(string_copy(text,pos,string_length(search_input)));
				var mx=ix+string_width(pre);
				draw_set_color(c_white);
				draw_set_alpha(0.2);
				draw_rectangle(mx,row_y-1,mx+match_w,row_y+line_full-3,false);
				draw_set_alpha(1);
			}
		}
		draw_set_color(c_white);
		draw_text(ix,row_y,text);
	}
}

if(sel_text!=""&&rows[selection].kind=="item"&&!search_mode){
	var ix=item_indent;
	draw_set_color(c_white);
	draw_set_alpha(0.7);
	draw_rectangle(ix-2,sel_y-1,ix+sel_tw+4,sel_y+sel_th-3,false);
	draw_set_alpha(1);
}
surface_reset_target();

draw_surface_ext(list_surf,tx,list_top,scale,scale,0,c_white,1);

if(search_enabled){
	var bar_text=search_input;
	var placeholder=(string_length(bar_text)==0);
	if(placeholder){
		bar_text="Search...";
	}
	var searchbar_height=search_bar_h;
	var search_ix=tx+item_indent;
	var box_x=tx;
	var searchbar_width=bar_w;
	var search_box_inset=4;
	var box_outer_y=panel_y+searchbar_top;
	var box_y=box_outer_y+search_box_inset;
	var box_h=searchbar_height-search_box_inset*2;
	var text_h=string_height("A");
	var text_y=box_y+(box_h-text_h)*0.5;

	draw_set_color(c_dkgray);
	draw_set_alpha(0.5);
	draw_rectangle(box_x,box_y,box_x+searchbar_width,box_y+box_h,false);
	draw_set_alpha(1);

	if(search_mode){
		draw_set_color(c_white);
		draw_rectangle(box_x,box_y,box_x+searchbar_width,box_y+box_h,true);
	}

	draw_set_color(placeholder?c_gray:c_white);
	draw_text(search_ix,text_y,bar_text);

	if(search_mode&&((search_cursor_timer div 10) mod 2)==0){
		var cx=search_ix+(placeholder?0:string_width(bar_text)+1);
		var cy1=text_y+1;
		var cy2=text_y+text_h-2;
		draw_rectangle(cx,cy1,cx+1,cy2,false);
	}
}else{
	draw_set_color(c_ltgray);
	draw_text_transformed(tx,panel_y+2,title,scale,scale,0);
}

draw_set_color(c_white);
draw_set_alpha(1);
