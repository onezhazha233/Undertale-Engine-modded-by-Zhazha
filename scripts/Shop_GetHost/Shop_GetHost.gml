///@arg shop_id
function Shop_GetHost(){
	var ID=argument[0];

	var map=global._shop;
	if(ds_map_exists(map,ID)){
		var map_e=ds_map_find_value(map,ID);
		var result=ds_map_find_value(map_e,"host");
		return (is_real(result) ? result : -1);
	}else{
		return -1;
	}
}