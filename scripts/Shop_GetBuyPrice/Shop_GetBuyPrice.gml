///@arg id
function Shop_GetBuyPrice(){
	var ID = argument[0];
	
	return (shop._host_buy[|ID][1] = undefined ? 0 : shop._host_buy[|ID][1]);
}