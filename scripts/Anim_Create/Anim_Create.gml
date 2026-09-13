//Legacy positional API (kept compatible). TARGET may be an instance id, an object index,
//the global struct, or an array itself - in the last case VAR_NAME carries the element
//index, e.g. Anim_Create(my_array,2,TWEEN,EASE,START,CHANGE,DURATION) animates my_array[2].
function Anim_Create(TARGET, VAR_NAME, TWEEN, EASE, START, CHANGE, DURATION, DELAY=0, CALLBACK=-1, ARG_0=0, ARG_1=0){
	var index=-1;
	if(is_array(TARGET)){
		if(is_numeric(VAR_NAME)){
			index=VAR_NAME;
			VAR_NAME="";
		}else{
			return -1;
		}
	}
	var opt={
		target:TARGET,
		var_name:VAR_NAME,
		index:index,
		tween:TWEEN,
		ease:EASE,
		start:START,
		change:CHANGE,
		duration:DURATION,
		delay:DELAY,
		speed:1,
		callback:CALLBACK,
		callback_args:[],
		on_update:undefined,
		arg0:ARG_0,
		arg1:ARG_1
	};
	return _Anim_CreateFromOpt(opt);
}

//Shared creation core. TARGET may be an instance id, an object index (one anim per existing
//matching instance), the global struct, or a bare array (then index is the element).
//Returns -1 if nothing was created, otherwise an array of anim structs.
function _Anim_CreateFromOpt(opt){
	var result=-1;
	var count=0;

	if(opt.duration<0){
		return result;
	}

	var target=opt.target;
	if(is_array(target)){
		if(_Anim_TargetValid(target,opt.var_name,opt.index)){
			result[0]=_Anim_Make(opt);
		}
	}else if(instance_exists(target)){
		var num=instance_number(target);
		for(var i=0;i<num;i++){
			var inst=instance_find(target,i);
			if(_Anim_TargetValid(inst,opt.var_name,opt.index)){
				opt.target=inst;
				result[count]=_Anim_Make(opt);
				count+=1;
			}
		}
	}else if(target==global){
		if(_Anim_TargetValid(target,opt.var_name,opt.index)){
			result[0]=_Anim_Make(opt);
		}
	}

	return result;
}

//Returns true if the animation target exists right now: a plain variable, or an array
//element (either of a bare array or of an instance/global array variable).
function _Anim_TargetValid(target,var_name,index){
	if(is_array(target)){
		return (index>=0 && index<array_length(target));
	}
	if(index>=0){
		var arr;
		if(target==global){
			if(!variable_global_exists(var_name)){
				return false;
			}
			arr=variable_global_get(var_name);
		}else{
			if(!variable_instance_exists(target,var_name)){
				return false;
			}
			arr=variable_instance_get(target,var_name);
		}
		return (is_array(arr) && index<array_length(arr));
	}
	if(target==global){
		return variable_global_exists(var_name);
	}
	return variable_instance_exists(target,var_name);
}

//Builds one anim struct, registers it and returns it. opt is copied, callers may reuse it.
function _Anim_Make(opt){
	if(!variable_global_exists("_gmu_anim_list")){
		global._gmu_anim_list=[];
	}
	var anim={
		target:opt.target,
		var_name:opt.var_name,
		index:opt.index,
		tween:opt.tween,
		ease:opt.ease,
		start:opt.start,
		change:opt.change,
		duration:opt.duration,
		delay:opt.delay,
		time:0,
		speed:opt.speed,
		callback:opt.callback,
		callback_args:opt.callback_args,
		on_update:opt.on_update,
		arg0:opt.arg0,
		arg1:opt.arg1
	};
	array_push(global._gmu_anim_list,anim);
	return anim;
}
