if(Shop_GetMenu() = SHOP_MENU.BUY||Shop_GetMenuBuy() = SHOP_BUY.CONFIRM){
	if!(shop._buy_choice = 4){
		_yoffset += (0-_yoffset)/3;
		if(abs(_yoffset) < 1)_yoffset = 0;
		
		if(instance_exists(_inst_itemdesc)){
			_inst_itemdesc.x = 448;
			_inst_itemdesc.y = 95+_yoffset;
			if!(shop._itemdesc_dialog = _prefix + Shop_GetBuyDesc(Shop_GetBuyChoice())){
				if(instance_exists(_inst_itemdesc)){
					instance_destroy(_inst_itemdesc);
				}
				shop._itemdesc_dialog =  _prefix + Shop_GetBuyDesc(Shop_GetBuyChoice());
				shop._inst_itemdesc = instance_create_depth(448,95,0,text_typer);
				shop._inst_itemdesc.text = shop._itemdesc_dialog;
				_inst_itemdesc = shop._inst_itemdesc;
			}
		}
		else{
			shop._itemdesc_dialog = _prefix + Shop_GetBuyDesc(Shop_GetBuyChoice());
			shop._inst_itemdesc = instance_create_depth(448,98+159,0,text_typer);
			shop._inst_itemdesc.text = shop._itemdesc_dialog;
			_inst_itemdesc = shop._inst_itemdesc;
		}
	}
	else{
		_yoffset += (159-_yoffset)/3;
		if(abs(_yoffset-159) < 1)_yoffset = 159;
		
		if(instance_exists(_inst_itemdesc)){
			instance_destroy(_inst_itemdesc);
		}
	}
}
else{
	_yoffset += (159-_yoffset)/3;
	if(abs(_yoffset) < 1)_yoffset = 0;
	
	if(instance_exists(_inst_itemdesc)){
		instance_destroy(_inst_itemdesc);
	}
}