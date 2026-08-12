depth=DEPTH_UI.DEBUG;
global.debug_busy=true;

rows=[];
selection=0;
scroll=0;
scroll_target=0;
sel_y=0;
visible_rows=18;

hold_dir=0;
hold_time=0;
hold_delay=0.28;
repeat_cd=0;
list_surf=-1;

title_text="List";
search_enabled=false;
search_mode=false;
search_input="";
search_cursor_timer=0;
search_repeat_key=-1;
search_repeat_char="";
search_hold_time=0;
search_repeat_cd=0;
rows_all=[];
on_select=function(_value){};

layout_dirty=true;
layout_panel_w=0;
layout_min_w=130;
_layout_gui_h=-1;
layout_list_top=0;
layout_line_full=0;
layout_line_h=0;
layout_pad_l=10;
layout_pad_r=20;
layout_item_indent=12;
layout_search_bar_h=0;
layout_searchbar_top=6;
layout_scale=1;
line_full=0;
