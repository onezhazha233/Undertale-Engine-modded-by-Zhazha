///@arg type
function Typer_Callback() {
	var TYPE=argument[0];
	var map=(TYPE==0) ? _callback_start : _callback_end;
	var key=string(_segment_index);
	if(!variable_struct_exists(map,key))return;
	var list=map[$ key];
	var len=array_length(list);
	var i=0;
	repeat(len){
		if(!is_undefined(list[i])){
			list[i]();
		}
		i+=1;
	}
}

///@arg type
///@arg index
///@arg func
function Typer_CallbackAdd() {
	var TYPE=argument[0];
	var INDEX=argument[1];
	var FUNC=argument[2];
	var map=(TYPE==0) ? _callback_start : _callback_end;
	var key=string(INDEX);
	if(!variable_struct_exists(map,key)){
		map[$ key]=[];
	}
	var list=map[$ key];
	array_push(list,FUNC);
}

///@arg type
///@arg index
function Typer_CallbackRemove() {
	var TYPE=argument[0];
	var INDEX=argument[1];
	var map=(TYPE==0) ? _callback_start : _callback_end;
	var key=string(INDEX);
	if(variable_struct_exists(map,key)){
		variable_struct_remove(map,key);
	}
}
