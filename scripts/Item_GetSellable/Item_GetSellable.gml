///@arg item_id
function Item_GetSellable(ITEM){

	if(Item_IsValid(ITEM)){
		var INST=instance_create_depth(0,0,0,ITEM);
		var PRICE=INST._sellable;
		instance_destroy(INST);
		return PRICE;
	}else{
		return "";
	}
}