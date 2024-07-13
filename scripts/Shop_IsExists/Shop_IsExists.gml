///@arg shop_id
function Shop_IsExists(){
	var SHOP=argument[0];

	var map=global._shop;

	return ds_map_exists(map,SHOP);
}