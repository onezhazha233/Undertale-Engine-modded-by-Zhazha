///@arg name
///@arg gold
///@arg description
///@arg *buyable
function Shop_AddBuy(){
	var NAME = argument[0];
	var GOLD = argument[1];
	var DESC = argument[2];
	var BUYABLE = SHOP_BUYABLE.BUYABLE;
	if(argument_count >= 4){
		BUYABLE = argument[3];
	}
	
	ds_list_add(shop._host_buy,[NAME,GOLD,DESC,BUYABLE]);
	
	return true;
}