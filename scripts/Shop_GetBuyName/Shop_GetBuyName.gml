///@arg id
function Shop_GetBuyName(){
	var ID = argument[0];
	
	return (shop._host_buy[|ID][0] = undefined ? "" : shop._host_buy[|ID][0]);
}