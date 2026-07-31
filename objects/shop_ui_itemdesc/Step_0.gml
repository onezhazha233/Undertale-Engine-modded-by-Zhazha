if(!instance_exists(shop))exit;

if((Shop_GetMenu()==SHOP_MENU.BUY||Shop_GetMenuBuy()==SHOP_BUY.CONFIRM)&&Shop_GetState()!=SHOP_STATE.DIALOG){
	if(shop._buy_choice!=4){
		_yoffset+=((0-_yoffset)*0.1835);
		if(abs(_yoffset)<1)_yoffset=0;
		var want=_prefix+Shop_GetBuyDesc(Shop_GetBuyChoice());
		var dx=448+Lang_GetLayout("shop.itemdesc.x",0);
		var dy=95+Lang_GetLayout("shop.itemdesc.y",0)+_yoffset;
		if(!instance_exists(_inst_itemdesc)||shop._itemdesc_dialog!=want){
			if(instance_exists(_inst_itemdesc))instance_destroy(_inst_itemdesc);
			shop._itemdesc_dialog=want;
			_inst_itemdesc=instance_create_depth(dx,dy,DEPTH_SHOP.DIALOG,text_typer);
			_inst_itemdesc.text=want;
			shop._inst_itemdesc=_inst_itemdesc;
		}else{
			_inst_itemdesc.x=dx;
			_inst_itemdesc.y=dy;
		}
	}else{
		_yoffset+=((162-_yoffset)*0.1835);
		if(instance_exists(_inst_itemdesc)){
			instance_destroy(_inst_itemdesc);
			_inst_itemdesc=noone;
		}
	}
}else{
	_yoffset+=((162-_yoffset)*0.1835);
	if(instance_exists(_inst_itemdesc)){
		instance_destroy(_inst_itemdesc);
		_inst_itemdesc=noone;
	}
}