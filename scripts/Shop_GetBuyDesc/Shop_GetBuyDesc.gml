///@arg id
function Shop_GetBuyDesc(){
	var ID = argument[0];
	
	return (shop._host_buy[|ID] = undefined ? "" : shop._host_buy[|ID][2]);
}