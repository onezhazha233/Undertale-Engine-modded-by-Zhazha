function Prompt_RemoveList(_id){
    for(var i=0; i<array_length(global.prompt_list); i++){
        if(global.prompt_list[i].id==_id){
           array_delete(global.prompt_list, i, 1);
           return true;
        }
    }
    return false;
}