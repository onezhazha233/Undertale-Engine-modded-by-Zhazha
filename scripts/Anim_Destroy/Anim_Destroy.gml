//Removes running animations. TARGET may be:
//- an anim struct (as returned by Anim_Create/Anim_CreateEx) or an array of them
//- an instance id or object index: kills every anim of that instance/object
//- global: kills every global-variable anim
//VAR_NAME filters by variable name ("" = all), SKIP jumps the variable to its final value.
//Killed anims do NOT fire their completion callback.
function Anim_Destroy(TARGET, VAR_NAME="", SKIP=false){
	var result=false;

	if(is_array(TARGET)){
		for(var i=0;i<array_length(TARGET);i++){
			if(_Anim_Remove(TARGET[i],VAR_NAME,SKIP)){
				result=true;
			}
		}
		return result;
	}
	if(is_struct(TARGET) && TARGET!=global){
		return _Anim_Remove(TARGET,VAR_NAME,SKIP);
	}

	if(!variable_global_exists("_gmu_anim_list") || !is_array(global._gmu_anim_list)){
		return false;
	}
	var list=global._gmu_anim_list;
	for(var i=array_length(list)-1;i>=0;i--){
		var anim=list[i];
		var t=anim.target;
		var match=false;
		if(is_array(t) || is_array(TARGET)){
			match=(is_array(t) && is_array(TARGET) && t==TARGET);
		}else if(t==global){
			match=(TARGET==global);
		}else{
			match=(t==TARGET) || (TARGET!=global && instance_exists(t) && t.object_index==TARGET);
		}
		if(match && (VAR_NAME=="" || anim.var_name==VAR_NAME)){
			if(SKIP){
				_Anim_SkipToEnd(anim);
			}
			array_delete(list,i,1);
			result=true;
		}
	}
	return result;
}

//Removes one specific anim struct from the registry; returns false if it is not running.
function _Anim_Remove(anim, VAR_NAME="", SKIP=false){
	if(!is_struct(anim) || anim==global){
		return false;
	}
	if(!variable_global_exists("_gmu_anim_list") || !is_array(global._gmu_anim_list)){
		return false;
	}
	var list=global._gmu_anim_list;
	for(var i=0;i<array_length(list);i++){
		if(list[i]==anim){
			if(VAR_NAME!="" && anim.var_name!=VAR_NAME){
				return false;
			}
			if(SKIP){
				_Anim_SkipToEnd(anim);
			}
			array_delete(list,i,1);
			return true;
		}
	}
	return false;
}

//Jumps the animated target to its final value (start+change); guarded by _Anim_SetValue.
function _Anim_SkipToEnd(anim){
	_Anim_SetValue(anim,anim.start+anim.change);
}
