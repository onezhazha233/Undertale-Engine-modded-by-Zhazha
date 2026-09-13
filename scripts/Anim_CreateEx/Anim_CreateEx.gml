//Struct-driven creation. Every field is optional except target/start/change/duration.
//opt = {
//    target       : instance id, object index, global, or a bare array
//    var_name     : string, variable to animate (unused when target is a bare array)
//    index        : >=0 animates target's array element instead of a plain variable
//                   (target.var_name[index], or target[index] for a bare array); default -1
//    start/change : value range (final value = start+change)
//    duration     : frames (after delay); 0 fires the callback once after the delay
//    tween/ease   : ANIM_TWEEN.* / ANIM_EASE.* (default LINEAR / IN)
//    delay        : frames before the anim starts (default 0)
//    speed        : playback speed multiplier (default 1)
//    callback     : called once on completion as callback(anim, callback_args...)
//    callback_args: array of extra values passed after the anim struct (default [])
//    on_update    : called every animated frame as on_update(anim, callback_args...)
//    arg0/arg1    : easing parameters (BACK overshoot / ELASTIC amplitude+period)
//}
//Returns -1 if nothing was created, otherwise an array of the created anim structs.
//The returned structs stay live: their fields can be read/written, and the anim can be
//cancelled at any time with Anim_Destroy(animStruct).
function Anim_CreateEx(opt){
	var o={
		target:_Anim_Opt(opt,"target",noone),
		var_name:_Anim_Opt(opt,"var_name",""),
		index:_Anim_Opt(opt,"index",-1),
		start:_Anim_Opt(opt,"start",0),
		change:_Anim_Opt(opt,"change",0),
		duration:_Anim_Opt(opt,"duration",0),
		tween:_Anim_Opt(opt,"tween",ANIM_TWEEN.LINEAR),
		ease:_Anim_Opt(opt,"ease",ANIM_EASE.IN),
		delay:_Anim_Opt(opt,"delay",0),
		speed:_Anim_Opt(opt,"speed",1),
		callback:_Anim_Opt(opt,"callback",-1),
		callback_args:_Anim_Opt(opt,"callback_args",[]),
		on_update:_Anim_Opt(opt,"on_update",undefined),
		arg0:_Anim_Opt(opt,"arg0",0),
		arg1:_Anim_Opt(opt,"arg1",0)
	};
	return _Anim_CreateFromOpt(o);
}

//Reads an option with a default so callers may omit any field.
function _Anim_Opt(opt,name,def){
	if(variable_struct_exists(opt,name)){
		return variable_struct_get(opt,name);
	}
	return def;
}
