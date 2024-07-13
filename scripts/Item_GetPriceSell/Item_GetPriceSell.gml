///@arg item_id
function Item_GetPriceSell() {
	var ITEM=argument[0];

	if(Item_IsValid(ITEM)){
		var INST=instance_create_depth(0,0,0,ITEM);
		var PRICE=INST._price_sell;
		instance_destroy(INST);
		return PRICE;
	}else{
		return "";
	}
}