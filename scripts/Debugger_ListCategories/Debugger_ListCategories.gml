// Debugger list categories — rules, order, and colors. Edit this file to customize.

/// Category header colors (merged with white when drawn).
function Debugger_ListCategoryColors(){
	return {
		System: c_ltgray,
		Area: c_aqua,
		Backlog: c_purple,
		Test: c_yellow,
		Other: c_white,
		Single: c_lime,
		"Party!": c_fuchsia,
		Boss: c_red,
	};
}

function Debugger_ListCategoryColor(_name){
	var colors=Debugger_ListCategoryColors();
	if(variable_struct_exists(colors,_name)){
		return colors[$ _name];
	}
	return c_teal;
}

// Room: [category, room_name_prefix] — more specific prefixes first.
function Debugger_ListRoomCategoryDefs(){
	return [
		["Area","room_area"],
		["System","room_init"],
		["System","room_logo"],
		["System","room_menu"],
		["System","room_settings"],
		["System","room_shop"],
		["System","room_battle"],
		["System","room_gameover"],
	];
}

function Debugger_ListRoomCategoryOrder(){
	return ["System","Area","Backlog","Test","Other"];
}

function Debugger_ListClassifyRoom(_room){
	var rname=room_get_name(_room);
	var defs=Debugger_ListRoomCategoryDefs();
	for(var i=0;i<array_length(defs);i++){
		var def=defs[i];
		if(string_pos(def[1],rname)==1){
			return def[0];
		}
	}
	return "Other";
}

// Encounter: [category, id_min, id_max] inclusive.
function Debugger_ListEncounterCategoryDefs(){
	return [
		["Single",1,9],
		["Party!",10,19],
		["Boss",20,999999],
	];
}

function Debugger_ListEncounterCategoryOrder(){
	return ["Single","Party!","Boss","Other"];
}

function Debugger_ListClassifyEncounter(_eid){
	if(_eid<=0){
		return "Other";
	}
	var defs=Debugger_ListEncounterCategoryDefs();
	for(var i=0;i<array_length(defs);i++){
		var def=defs[i];
		if(_eid>=def[1]&&_eid<=def[2]){
			return def[0];
		}
	}
	return "Other";
}

function Debugger_ListEncounterItemLabel(_eid){
	var label=string(_eid);
	var enemies=[];
	for(var s=0;s<3;s++){
		var e=Encounter_GetEnemy(_eid,s);
		if(e!=-1&&object_exists(e)){
			var en=object_get_name(e);
			en=string_replace(en,"battle_enemy_","");
			array_push(enemies,en);
		}
	}
	if(array_length(enemies)>0){
		label+="  ";
		for(var n=0;n<array_length(enemies);n++){
			if(n>0){
				label+="+";
			}
			label+=enemies[n];
		}
	}
	return label;
}

///@arg order @arg cat_map
function Debugger_ListRowsFromCategoryMap(_order,_cat_map){
	var rows=[];
	var colors=Debugger_ListCategoryColors();
	for(var i=0;i<array_length(_order);i++){
		var cname=_order[i];
		if(!variable_struct_exists(_cat_map,cname)){
			continue;
		}
		var col=c_teal;
		if(variable_struct_exists(colors,cname)){
			col=colors[$ cname];
		}
		array_push(rows,{kind:"header",label:cname,color:col,value:-1});
		var list=_cat_map[$ cname];
		for(var j=0;j<array_length(list);j++){
			array_push(rows,list[j]);
		}
	}
	return rows;
}

///@arg current_room
function Debugger_ListBuildRoomRows(_current_room){
	var order=Debugger_ListRoomCategoryOrder();
	var cat_map={};
	var all_rooms=[];
	var rm=room_first;
	while(room_exists(rm)){
		array_push(all_rooms,rm);
		rm=room_next(rm);
	}
	for(var i=0;i<array_length(all_rooms);i++){
		var r=all_rooms[i];
		var matched=Debugger_ListClassifyRoom(r);
		if(!variable_struct_exists(cat_map,matched)){
			cat_map[$ matched]=[];
		}
		array_push(cat_map[$ matched],{
			kind:"item",
			label:room_get_name(r),
			value:r
		});
	}
	var rows=Debugger_ListRowsFromCategoryMap(order,cat_map);
	var sel=0;
	for(var k=0;k<array_length(rows);k++){
		if(rows[k].kind=="item"&&rows[k].value==_current_room){
			sel=k;
			break;
		}
	}
	return {rows:rows,selection:sel};
}

function Debugger_ListBuildEncounterRows(){
	var order=Debugger_ListEncounterCategoryOrder();
	var cat_map={};
	var ids=[];
	var key=ds_map_find_first(global._encounter);
	while(!is_undefined(key)){
		array_push(ids,key);
		key=ds_map_find_next(global._encounter,key);
	}
	array_sort(ids,true);
	for(var i=0;i<array_length(ids);i++){
		var eid=ids[i];
		var matched=Debugger_ListClassifyEncounter(eid);
		if(!variable_struct_exists(cat_map,matched)){
			cat_map[$ matched]=[];
		}
		array_push(cat_map[$ matched],{
			kind:"item",
			label:Debugger_ListEncounterItemLabel(eid),
			value:eid
		});
	}
	var rows=Debugger_ListRowsFromCategoryMap(order,cat_map);
	return {rows:rows,selection:0};
}

function Debugger_ListFindFirstItem(_rows){
	for(var i=0;i<array_length(_rows);i++){
		if(_rows[i].kind=="item"){
			return i;
		}
	}
	return 0;
}

function Debugger_ListRowMatchesSearch(_label,_query){
	if(_query==""){
		return true;
	}
	return string_pos(string_lower(_query),string_lower(_label))>0;
}

///@arg ch
function Debugger_ListSanitizeSearchChar(_ch){
	var o=ord(_ch);
	if(o>=ord("a")&&o<=ord("z")){
		return _ch;
	}
	if(o>=ord("A")&&o<=ord("Z")){
		return _ch;
	}
	if(o>=ord("0")&&o<=ord("9")){
		return _ch;
	}
	if(_ch=="_"){
		return _ch;
	}
	return "#";
}

///@arg str
function Debugger_ListSanitizeSearchInput(_str){
	var out="";
	for(var i=1;i<=string_length(_str);i++){
		out+=Debugger_ListSanitizeSearchChar(string_char_at(_str,i));
	}
	return out;
}

///@arg all_rows @arg query
function Debugger_ListFilterRows(_all_rows,_query){
	if(_query==""){
		return _all_rows;
	}
	var out=[];
	var current_header=undefined;
	var header_added=false;
	for(var i=0;i<array_length(_all_rows);i++){
		var row=_all_rows[i];
		if(row.kind=="header"){
			current_header=row;
			header_added=false;
		}else if(row.kind=="item"){
			if(Debugger_ListRowMatchesSearch(row.label,_query)){
				if(!is_undefined(current_header)&&!header_added){
					array_push(out,current_header);
					header_added=true;
				}
				array_push(out,row);
			}
		}else{
			array_push(out,row);
		}
	}
	return out;
}

function Debugger_ListIsSearchKeyBlacklisted(_key){
	if(_key==9||_key==16||_key==17||_key==162){
		return true;
	}
	if(_key==18||_key==164||_key==160||_key==13||_key==8){
		return true;
	}
	if(_key==144||_key==37||_key==39||_key==38||_key==40){
		return true;
	}
	if(_key==34||_key==33||_key==27||_key==32){
		return true;
	}
	if(_key==45||_key==46||_key==93){
		return true;
	}
	if(_key>=112&&_key<=123){
		return true;
	}
	return false;
}

///@arg inst
function Debugger_ListResetNav(_inst){
	if(array_length(_inst.rows)<=0){
		_inst.selection=0;
		_inst.scroll_target=0;
		_inst.scroll=0;
		_inst.sel_y=0;
		return;
	}
	while(_inst.selection<array_length(_inst.rows)&&_inst.rows[_inst.selection].kind!="item"){
		_inst.selection+=1;
	}
	if(_inst.selection>=array_length(_inst.rows)){
		_inst.selection=Debugger_ListFindFirstItem(_inst.rows);
	}
	_inst.scroll_target=0;
	_inst.scroll=0;
	_inst.sel_y=0;
}

///@arg inst
function Debugger_ListApplySearchFilter(_inst){
	if(!_inst.search_enabled){
		return;
	}
	_inst.rows=Debugger_ListFilterRows(_inst.rows_all,_inst.search_input);
	_inst.selection=Debugger_ListFindFirstItem(_inst.rows);
	Debugger_ListResetNav(_inst);
	_inst.layout_dirty=true;
}

///@arg inst @arg built
function Debugger_ListApplyBuilt(_inst,_built){
	_inst.rows_all=_built.rows;
	_inst.rows=_built.rows;
	_inst.selection=_built.selection;
	if(array_length(_inst.rows)<=0){
		instance_destroy(_inst);
		exit;
	}
	Debugger_ListResetNav(_inst);
	_inst.layout_dirty=true;
	if(_inst.selection>0){
		_inst.scroll_target=max(0,_inst.selection-floor(_inst.visible_rows/2));
		_inst.scroll=_inst.scroll_target;
		var f=Lang_GetFont("determination_mono",font_mars_needs_cunnilingus);
		draw_set_font(f);
		_inst.sel_y=(_inst.selection-_inst.scroll)*(string_height("A")+4);
	}
}

///@arg inst
function Debugger_ListUpdateLayout(_inst){
	var gui_h=display_get_gui_height();
	if(!_inst.layout_dirty&&_inst._layout_gui_h==gui_h&&_inst.layout_panel_w>0){
		return;
	}
	var f=Lang_GetFont("determination_mono",font_mars_needs_cunnilingus);
	draw_set_font(f);
	var scale=1;
	var pad_l=10;
	var pad_r=20;
	var item_indent=12;
	var line_full=string_height("A")+4;
	var line_h=line_full*scale;
	var count=array_length(_inst.rows);
	var title=_inst.search_enabled?"Search":_inst.title_text;
	var max_tw=string_width(title);
	var item_rows=0;
	for(var i=0;i<count;i++){
		var row=_inst.rows[i];
		var sample="";
		if(row.kind=="item"){
			sample=row.label;
			item_rows+=1;
			max_tw=max(max_tw,item_indent+string_width(sample));
		}else{
			sample=row.label;
			max_tw=max(max_tw,string_width(sample));
		}
	}
	if(_inst.search_enabled&&item_rows==0){
		var q=_inst.search_input;
		if(string_length(q)==0){
			q="Search";
		}
		max_tw=max(string_width("Search"),item_indent+string_width(q)+8);
	}
	var gui_w=display_get_gui_width();
	var searchbar_top=6;
	var search_bar_h=line_full+4;
	var header_h=_inst.search_enabled?searchbar_top+search_bar_h+4:line_h+8;
	var list_top=header_h;
	var panel_bottom=gui_h;
	var list_h=max(1,panel_bottom-list_top);
	_inst.layout_panel_w=min(gui_w,ceil(max_tw*scale)+pad_l+pad_r);
	_inst.layout_list_top=list_top;
	_inst.layout_line_full=line_full;
	_inst.layout_line_h=line_h;
	_inst.layout_pad_l=pad_l;
	_inst.layout_pad_r=pad_r;
	_inst.layout_item_indent=item_indent;
	_inst.layout_search_bar_h=search_bar_h;
	_inst.layout_searchbar_top=searchbar_top;
	_inst.layout_scale=scale;
	_inst.visible_rows=max(1,floor(list_h/line_h));
	_inst._layout_gui_h=gui_h;
	_inst.layout_dirty=false;
}

///@arg inst
/// Returns true when Step should exit early (search mode).
function Debugger_ListStepSearch(_inst){
	if(!_inst.search_enabled){
		return false;
	}
	var count=array_length(_inst.rows);
	if(_inst.search_mode){
		_inst.scroll=lerp(_inst.scroll,0,0.3);
		_inst.scroll_target=0;
		_inst.sel_y=lerp(_inst.sel_y,0,0.35);

		if(keyboard_check_pressed(vk_down)||keyboard_check_pressed(vk_enter)){
			_inst.search_mode=false;
			_inst.search_repeat_key=-1;
			count=array_length(_inst.rows);
			if(count>0){
				_inst.selection=Debugger_ListFindFirstItem(_inst.rows);
				Debugger_ListResetNav(_inst);
			}
		}

		var search_key_hit=false;
		if(keyboard_check_pressed(vk_backspace)){
			_inst.search_repeat_key=vk_backspace;
			_inst.search_repeat_char="";
			_inst.search_hold_time=0;
			_inst.search_repeat_cd=0;
			search_key_hit=true;
			if(string_length(_inst.search_input)>0){
				_inst.search_input=string_delete(_inst.search_input,string_length(_inst.search_input),1);
				_inst.search_cursor_timer=0;
				Debugger_ListApplySearchFilter(_inst);
			}
		}else if(keyboard_check_pressed(vk_anykey)&&!Debugger_ListIsSearchKeyBlacklisted(keyboard_key)){
			if(keyboard_string!=""){
				var sanitized=Debugger_ListSanitizeSearchInput(keyboard_string);
				if(string_length(sanitized)>0){
					_inst.search_repeat_key=keyboard_key;
					_inst.search_repeat_char=string_char_at(sanitized,string_length(sanitized));
					_inst.search_hold_time=0;
					_inst.search_repeat_cd=0;
					search_key_hit=true;
					_inst.search_input+=sanitized;
					_inst.search_cursor_timer=0;
					Debugger_ListApplySearchFilter(_inst);
				}
				keyboard_string="";
			}
		}

		if(!search_key_hit&&_inst.search_repeat_key!=-1&&keyboard_check(_inst.search_repeat_key)){
			_inst.search_hold_time+=delta_time/1000000;
			if(_inst.search_hold_time>=_inst.hold_delay){
				_inst.search_repeat_cd-=delta_time/1000000;
				if(_inst.search_repeat_cd<=0){
					if(_inst.search_repeat_key==vk_backspace){
						if(string_length(_inst.search_input)>0){
							_inst.search_input=string_delete(_inst.search_input,string_length(_inst.search_input),1);
							_inst.search_cursor_timer=0;
							Debugger_ListApplySearchFilter(_inst);
						}
					}else if(_inst.search_repeat_char!=""){
						_inst.search_input+=_inst.search_repeat_char;
						_inst.search_cursor_timer=0;
						Debugger_ListApplySearchFilter(_inst);
					}
					_inst.search_repeat_cd=max(0.035,0.11-(_inst.search_hold_time-_inst.hold_delay)*0.04);
				}
			}
		}else if(!search_key_hit&&!keyboard_check(_inst.search_repeat_key)){
			_inst.search_repeat_key=-1;
			_inst.search_hold_time=0;
			_inst.search_repeat_cd=0;
		}

		if(keyboard_check_pressed(vk_anykey)&&string_length(_inst.search_input)==0){
			Debugger_ListApplySearchFilter(_inst);
		}

		_inst.search_cursor_timer+=1;
	}else{
		var first_item=Debugger_ListFindFirstItem(_inst.rows);
		if(keyboard_check_pressed(vk_up)&&_inst.selection==first_item){
			_inst.search_mode=true;
			_inst.search_cursor_timer=0;
			keyboard_string="";
		}

		if(keyboard_check_pressed(vk_anykey)&&!Debugger_ListIsSearchKeyBlacklisted(keyboard_key)&&keyboard_string!=""){
			var sanitized=Debugger_ListSanitizeSearchInput(keyboard_string);
			if(string_length(sanitized)>0){
				_inst.search_mode=true;
				_inst.search_input=sanitized;
				_inst.search_repeat_key=keyboard_key;
				_inst.search_repeat_char=string_char_at(sanitized,string_length(sanitized));
				_inst.search_cursor_timer=0;
				keyboard_string="";
				Debugger_ListApplySearchFilter(_inst);
			}
		}
	}

	if(_inst.search_mode){
		if(keyboard_check_pressed(vk_escape)||keyboard_check_pressed(ord("X"))){
			instance_destroy(_inst);
		}
		return true;
	}
	return false;
}

///@arg inst
function Debugger_ListStepNav(_inst){
	var count=array_length(_inst.rows);
	if(count<=0){
		if(keyboard_check_pressed(vk_escape)||keyboard_check_pressed(ord("X"))){
			instance_destroy(_inst);
		}
		exit;
	}

	var moved=false;
	var dir=0;

	if(keyboard_check_pressed(vk_up)){
		dir=-1;
		_inst.hold_dir=-1;
		_inst.hold_time=0;
		_inst.repeat_cd=0;
		moved=true;
	}else if(keyboard_check_pressed(vk_down)){
		dir=1;
		_inst.hold_dir=1;
		_inst.hold_time=0;
		_inst.repeat_cd=0;
		moved=true;
	}

	var holding_up=keyboard_check(vk_up);
	var holding_down=keyboard_check(vk_down);
	if(holding_up||holding_down){
		_inst.hold_dir=holding_up?-1:1;
		_inst.hold_time+=delta_time/1000000;
		if(_inst.hold_time>=_inst.hold_delay){
			_inst.repeat_cd-=delta_time/1000000;
			if(_inst.repeat_cd<=0){
				dir=_inst.hold_dir;
				moved=true;
				_inst.repeat_cd=max(0.035,0.11-(_inst.hold_time-_inst.hold_delay)*0.04);
			}
		}
	}else{
		_inst.hold_dir=0;
		_inst.hold_time=0;
		_inst.repeat_cd=0;
	}

	if(moved&&dir!=0){
		var next=_inst.selection;
		var guard=0;
		do{
			next+=dir;
			if(next<0){
				next=count-1;
			}else if(next>=count){
				next=0;
			}
			guard+=1;
		}until(_inst.rows[next].kind=="item"||guard>count);
		_inst.selection=next;
	}

	if(keyboard_check_pressed(vk_left)||keyboard_check_pressed(vk_right)){
		var cdir=keyboard_check_pressed(vk_left)?-1:1;
		var i=_inst.selection;
		var guard=0;
		var seen_header=false;
		do{
			i+=cdir;
			if(i<0){
				i=count-1;
			}else if(i>=count){
				i=0;
			}
			if(_inst.rows[i].kind=="header"){
				seen_header=true;
			}else if(seen_header&&_inst.rows[i].kind=="item"){
				_inst.selection=i;
				break;
			}
			guard+=1;
		}until(guard>count);
	}

	var max_scroll=max(0,count-_inst.visible_rows);
	var edge_pad=5;
	if(_inst.visible_rows<=edge_pad*2+1){
		edge_pad=max(1,floor((_inst.visible_rows-1)/2));
	}
	var view_top=_inst.scroll_target+edge_pad;
	var view_bottom=_inst.scroll_target+_inst.visible_rows-1-edge_pad;
	if(_inst.selection<view_top){
		_inst.scroll_target=_inst.selection-edge_pad;
	}else if(_inst.selection>view_bottom){
		_inst.scroll_target=_inst.selection-(_inst.visible_rows-1-edge_pad);
	}
	_inst.scroll_target=clamp(_inst.scroll_target,0,max_scroll);

	_inst.scroll=lerp(_inst.scroll,_inst.scroll_target,0.4);
	if(abs(_inst.scroll-_inst.scroll_target)<0.03){
		_inst.scroll=_inst.scroll_target;
	}

	draw_set_font(Lang_GetFont("determination_mono",font_mars_needs_cunnilingus));
	var line_full=string_height("A")+4;
	_inst.line_full=line_full;
	var sel_target_y=(_inst.selection-_inst.scroll)*line_full;
	_inst.sel_y=lerp(_inst.sel_y,sel_target_y,0.35);
	if(abs(_inst.sel_y-sel_target_y)<0.5){
		_inst.sel_y=sel_target_y;
	}

	if(keyboard_check_pressed(vk_enter)||keyboard_check_pressed(ord("Z"))){
		var row=_inst.rows[_inst.selection];
		if(row.kind=="item"){
			_inst.on_select(row.value);
			instance_destroy(_inst);
		}
		exit;
	}

	if(keyboard_check_pressed(vk_escape)||keyboard_check_pressed(ord("X"))){
		instance_destroy(_inst);
	}
}

///@arg config
function Debugger_ListOpen(_config){
	if(instance_exists(debugger_list)){
		return noone;
	}
	var inst=instance_create_depth(0,0,DEPTH_UI.DEBUG,debugger_list);
	if(variable_struct_exists(_config,"search_enabled")){
		inst.search_enabled=_config.search_enabled;
	}
	if(variable_struct_exists(_config,"title_text")){
		inst.title_text=_config.title_text;
	}
	if(variable_struct_exists(_config,"on_select")){
		inst.on_select=_config.on_select;
	}
	var built=undefined;
	if(variable_struct_exists(_config,"build_arg")){
		built=_config.build_fn(_config.build_arg);
	}else{
		built=_config.build_fn();
	}
	Debugger_ListApplyBuilt(inst,built);
	return inst;
}

function Debugger_ListOpenRoom(){
	return Debugger_ListOpen({
		search_enabled:true,
		on_select:function(_value){
			if(room_exists(_value)){
				room_goto(_value);
			}
		},
		build_fn:Debugger_ListBuildRoomRows,
		build_arg:room,
	});
}

function Debugger_ListOpenEncounter(){
	return Debugger_ListOpen({
		search_enabled:true,
		on_select:function(_value){
			Encounter_Start(_value);
		},
		build_fn:Debugger_ListBuildEncounterRows,
	});
}
