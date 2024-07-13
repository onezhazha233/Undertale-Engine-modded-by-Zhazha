///@arg shop_id
function Shop_GetMenuDialogFromShopCustom() {
	var ID=argument[0];

	var map=global._shop;
	if(ds_map_exists(map,ID)){
		var map_e=ds_map_find_value(map,ID);
		var result=ds_map_find_value(map_e,"menu_dialog");
		return result;
	}else{
		return -1;
	}
}
