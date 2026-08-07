event_inherited();

title_text="Room List";
on_select=function(_value){
	if(room_exists(_value)){
		room_goto(_value);
	}
};

// more specific prefixes first; display order in cat_order_pref
var cat_defs=[
	["Area","room_area"],
	["System","room_init"],
	["System","room_logo"],
	["System","room_menu"],
	["System","room_settings"],
	["System","room_shop"],
	["System","room_battle"],
	["System","room_gameover"],
];
var cat_order_pref=["System","Area","Other"];

var all_rooms=[];
var rm=room_first;
while(room_exists(rm)){
	array_push(all_rooms,rm);
	rm=room_next(rm);
}

var cat_map={};

for(var i=0;i<array_length(all_rooms);i++){
	var r=all_rooms[i];
	var rname=room_get_name(r);
	var matched="Other";
	for(var c=0;c<array_length(cat_defs);c++){
		var def=cat_defs[c];
		if(string_pos(def[1],rname)==1){
			matched=def[0];
			break;
		}
	}
	if(!variable_struct_exists(cat_map,matched)){
		cat_map[$ matched]=[];
	}
	array_push(cat_map[$ matched],r);
}

for(var i=0;i<array_length(cat_order_pref);i++){
	var cname=cat_order_pref[i];
	if(!variable_struct_exists(cat_map,cname)){
		continue;
	}
	array_push(rows,{kind:"header",label:cname,value:-1});
	var list=cat_map[$ cname];
	for(var j=0;j<array_length(list);j++){
		var rr=list[j];
		array_push(rows,{
			kind:"item",
			label:room_get_name(rr),
			value:rr
		});
		if(rr==room){
			selection=array_length(rows)-1;
		}
	}
}

if(array_length(rows)<=0){
	instance_destroy();
	exit;
}

while(selection<array_length(rows)&&rows[selection].kind!="item"){
	selection+=1;
}
if(selection>=array_length(rows)){
	selection=0;
	while(selection<array_length(rows)&&rows[selection].kind!="item"){
		selection+=1;
	}
}

scroll_target=0;
scroll=0;
if(selection>0){
	scroll_target=max(0,selection-floor(visible_rows/2));
	scroll=scroll_target;
}
