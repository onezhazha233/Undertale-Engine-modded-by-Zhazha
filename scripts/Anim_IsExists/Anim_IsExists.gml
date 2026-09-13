//Returns true if matching animations are registered. TARGET may be an anim struct (or an
//array of them), an instance id, an object index, or global; VAR_NAME filters by name.
function Anim_IsExists(TARGET, VAR_NAME=""){
	if(is_array(TARGET)){
		for(var i=0;i<array_length(TARGET);i++){
			if(_Anim_IsRegistered(TARGET[i],VAR_NAME)){
				return true;
			}
		}
		return false;
	}
	if(is_struct(TARGET) && TARGET!=global){
		return _Anim_IsRegistered(TARGET,VAR_NAME);
	}

	if(!variable_global_exists("_gmu_anim_list") || !is_array(global._gmu_anim_list)){
		return false;
	}
	var list=global._gmu_anim_list;
	for(var i=0;i<array_length(list);i++){
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
			return true;
		}
	}
	return false;
}

function _Anim_IsRegistered(anim, VAR_NAME=""){
	if(!is_struct(anim) || anim==global){
		return false;
	}
	if(VAR_NAME!="" && anim.var_name!=VAR_NAME){
		return false;
	}
	if(!variable_global_exists("_gmu_anim_list") || !is_array(global._gmu_anim_list)){
		return false;
	}
	var list=global._gmu_anim_list;
	for(var i=0;i<array_length(list);i++){
		if(list[i]==anim){
			return true;
		}
	}
	return false;
}
