function Prompt_FindPos(_pos) {
    for (var i=0; i<array_length(global.prompt_list); i++){
        if(global.prompt_list[i].pos==_pos){
           var _id = global.prompt_list[i].id;
           if(instance_exists(_id)){
                return _id;
           }else{
               array_delete(global.prompt_list, i, 1);
               return noone;
            }
        }
    }
    return noone;
}