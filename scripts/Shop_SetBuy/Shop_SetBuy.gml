///@arg id
///@arg name
///@arg gold
///@arg desc
///@arg buyable
function Shop_SetBuy(){
	var ID = argument[0];
	var NAME = argument[1];
	var GOLD = argument[2];
	var DESC = argument[3];
	var BUYABLE = true;
	if(argument_count >= 5){
		BUYABLE = argument[4];
	}
	
	shop._host_buy[|ID] = [NAME,GOLD,DESC,BUYABLE];
	
	return true;
}