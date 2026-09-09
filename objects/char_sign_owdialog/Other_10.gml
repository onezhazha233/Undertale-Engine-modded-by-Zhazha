if!(instance_exists(dialog)){
	with(overworld_dialog)instance_destroy();
	dialog = instance_create_depth(x,y-35,0,overworld_dialog);
	dialog.text = text;
	dialog.template = 5;
	dialog.dir=DIR.DOWN;
	dialog.wide_spike=false;
	dialog.up=20;
	dialog.down=0;
	dialog.left=44;
	dialog.right=44;
}