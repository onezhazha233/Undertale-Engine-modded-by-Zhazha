event_inherited();

title_text="Encounter List";
on_select=function(_value){
	Encounter_Start(_value);
};

var ids=[];
var key=ds_map_find_first(global._encounter);
while(!is_undefined(key)){
	array_push(ids,key);
	key=ds_map_find_next(global._encounter,key);
}
array_sort(ids,true);

var cat_map={};
var cat_order=[];

for(var i=0;i<array_length(ids);i++){
	var eid=ids[i];
	var cat="Other";
	if(eid<=0){
		cat="Other";
	}else if(eid>=1&&eid<10){
		cat="Single";
	}else if(eid>=10&&eid<20){
		cat="Party!";
	}else if(eid>=20){
		cat="Boss";
	}
	if(!variable_struct_exists(cat_map,cat)){
		cat_map[$ cat]=[];
		array_push(cat_order,cat);
	}
	array_push(cat_map[$ cat],eid);
}

for(var i=0;i<array_length(cat_order);i++){
	var cname=cat_order[i];
	array_push(rows,{kind:"header",label:cname,value:-1});
	var list=cat_map[$ cname];
	for(var j=0;j<array_length(list);j++){
		var eid=list[j];
		var label=string(eid);
		var enemies=[];
		for(var s=0;s<3;s++){
			var e=Encounter_GetEnemy(eid,s);
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
		array_push(rows,{kind:"item",label:label,value:eid});
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
