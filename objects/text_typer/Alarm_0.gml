_auto_end = true
var allAutoDestroy = true;

for(var i=0;i<instance_number(text_typer);i++){
    if(!instance_find(text_typer,i)._auto_end){
        allAutoDestroy = false;
        break;
    }
}

if(allAutoDestroy){
    with(text_typer)instance_destroy();
}