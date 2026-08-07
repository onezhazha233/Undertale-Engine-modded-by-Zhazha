function Prompt_Add(text,pos,fade_time){
    var _old_id=Prompt_FindPos(pos);
    if(instance_exists(_old_id)){
		show_message("instance exists here!");
		instance_destroy(_old_id);
		Prompt_RemoveList(_old_id);
    }
    
    var _pos_arr=Prompt_GetPos(pos);
    var _x=_pos_arr[0];
    var _y=_pos_arr[1];
    
    var _inst=instance_create_depth(_x,_y,0,ui_prompt);
    _inst._text=text;
    _inst._pos=pos;
	_inst.fade_in_time=fade_time;
    
    var _entry ={
        pos: pos,
        id: _inst
    };
    array_push(global.prompt_list, _entry);
    
    return _inst;
}
