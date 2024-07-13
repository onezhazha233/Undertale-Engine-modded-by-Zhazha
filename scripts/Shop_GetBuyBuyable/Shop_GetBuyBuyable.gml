///@arg id
function Shop_GetBuyBuyable(){
	var ID = argument[0];
	
	return (shop._host_buy[|ID][3] = undefined ? SHOP_BUYABLE.BUYABLE : shop._host_buy[|ID][3]);
}