auto_destroy = 1
var allAutoDestroy = true;

for (i=0;i<instance_number(text_typer);i++) {
    var obj = instance_find(text_typer,i);

    if(obj.auto_destroy != 1) {
        allAutoDestroy = false;
        break;
    }
}

if(allAutoDestroy = 1) {
    with(text_typer)instance_destroy();
}