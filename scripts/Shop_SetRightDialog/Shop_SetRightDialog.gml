///@arg text
function Shop_SetRightDialog(){
	var TEXT = argument[0];
	
	if(instance_exists(shop._inst_right_dialog)){
		instance_destroy(shop._inst_right_dialog);
	}
	
	shop._inst_right_dialog = instance_create_depth(450,260,0,text_typer);
	shop._inst_right_dialog.text = "{font 0}{space_y 4}{scale 2}{speed 2}{shadow true}{gui false}{depth "+string(DEPTH_SHOP.DIALOG)+"}"+TEXT;

	return true;
}