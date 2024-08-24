if!(_gold = Player_GetGold()||_item_number = 8 - Item_GetNumber()){
	instance_destroy(_inst_gold);
	instance_destroy(_inst_space);
	_gold = Player_GetGold();
	_item_number = Item_GetNumber();
	_inst_gold = instance_create_depth(436,220+_top*-38,0,text_typer);
	_inst_space = instance_create_depth(436,260+_top*-38,0,text_typer);
	_inst_gold.text = _prefix + "$ - " + string(_gold) + "G";
	_inst_space.text =  _prefix + Lang_GetString("ui.buy.space")+" - " + string(_item_number) + "/8";
}

if!(instance_exists(ui_dialog)){
	instance_destroy();
}