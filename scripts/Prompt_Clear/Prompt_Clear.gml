function Prompt_PlayFadeOut(_id,_time){
	if(!instance_exists(_id)){
		return;
	}
	if(instance_exists(_id._inst)){
		Anim_Destroy(_id._inst,"override_alpha");
		Anim_Destroy(_id._inst,"x");
		Anim_Create(_id._inst,"override_alpha",0,0,_id._inst.override_alpha,-_id._inst.override_alpha,_time);
		var _dx=Prompt_IsRightPos(_id._pos) ? 80 : -80;
		Anim_Create(_id._inst,"x",ANIM_TWEEN.CUBIC,ANIM_EASE.IN,_id._inst.x,_dx,_time);
	}
	_id.alarm[0]=_time;
}

function Prompt_Clear(pos,instant,fade_out_time=20){
	var _id=Prompt_FindPos(pos);
	if(!instance_exists(_id)){
		return;
	}
	
	if(instant){
		instance_destroy(_id);
		Prompt_RemoveList(_id);
	}else{
		Prompt_PlayFadeOut(_id,fade_out_time);
	}
}

function Prompt_ClearAll(instant,fade_out_time=20){
	if(instant){
		for(var i=0; i<array_length(global.prompt_list); i++){
			var _id=global.prompt_list[i].id;
			if(instance_exists(_id))instance_destroy(_id);
		}
		global.prompt_list=[];
	}else{
		var _list_copy=[];
		var _len=array_length(global.prompt_list);
		for(var i=0; i<_len; i++)_list_copy[i]=global.prompt_list[i];
		for(var i=0; i<_len; i++){
			var _id=_list_copy[i].id;
			if(instance_exists(_id)){
				Prompt_PlayFadeOut(_id,fade_out_time);
			}
		}
	}
}
