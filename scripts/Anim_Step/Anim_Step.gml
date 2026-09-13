function Anim_Step(){
	if(!variable_global_exists("_gmu_anim_list") || !is_array(global._gmu_anim_list)){
		return false;
	}
	var list=global._gmu_anim_list;
	var i=0;
	var n=array_length(list);
	while(i<n){
		var anim=list[i];
		var target=anim.target;
		if(target!=global && !instance_exists(target)){
			array_delete(list,i,1);
			n-=1;
			continue;
		}
		if(anim.delay>0){
			anim.delay-=anim.speed;
			i+=1;
			continue;
		}
		anim.time+=anim.speed;
		if(anim.time>=anim.duration){
			//Finished: write the final value and fire the callback in the same frame.
			anim.time=anim.duration;
			_Anim_SetValue(anim,anim.start+anim.change);
			array_delete(list,i,1);
			n-=1;
			_Anim_Invoke(anim,anim.callback,anim.callback_args);
		}else{
			var value=anim.start+anim.change*Anim_GetValue(anim.tween,anim.ease,anim.time/anim.duration,anim.arg0,anim.arg1);
			_Anim_SetValue(anim,value);
			if(anim.on_update!=undefined){
				_Anim_Invoke(anim,anim.on_update,anim.callback_args);
			}
			i+=1;
		}
	}
	return true;
}

//Writes the animated value: to a plain instance/global variable, or into an array element
//(a bare array reference, or the array held by an instance/global variable). Writes through
//the [@] accessor so the original array is mutated even with copy-on-write enabled.
function _Anim_SetValue(anim,value){
	var t=anim.target;
	if(is_array(t)){
		if(anim.index>=0 && anim.index<array_length(t)){
			t[@ anim.index]=value;
		}
	}else if(t==global || instance_exists(t)){
		if(anim.index>=0){
			var arr;
			if(t==global){
				arr=variable_global_get(anim.var_name);
			}else{
				arr=variable_instance_get(t,anim.var_name);
			}
			if(is_array(arr) && anim.index<array_length(arr)){
				arr[@ anim.index]=value;
				if(t==global){
					variable_global_set(anim.var_name,arr);
				}else{
					variable_instance_set(t,anim.var_name,arr);
				}
			}
		}else if(t==global){
			variable_global_set(anim.var_name,value);
		}else{
			variable_instance_set(t,anim.var_name,value);
		}
	}
}

//Calls fn as fn(anim, args[0], args[1], ...). Works with both script assets and bound
//methods; undefined/-1/noone means "no callback".
function _Anim_Invoke(anim,fn,args){
	if(fn==undefined || fn==-1 || fn==noone){
		return undefined;
	}
	if(!is_array(args)){
		args=[];
	}
	switch(array_length(args)){
		case 0:  return fn(anim);
		case 1:  return fn(anim,args[0]);
		case 2:  return fn(anim,args[0],args[1]);
		case 3:  return fn(anim,args[0],args[1],args[2]);
		default: return fn(anim,args[0],args[1],args[2],args[3]);
	}
}
