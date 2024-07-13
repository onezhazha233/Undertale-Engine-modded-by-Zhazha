///@arg id
///@arg name
function Shop_SetTalkName(){
	var ID = argument[0];
	var NAME = argument[1];
	
	shop._host_talk[|ID] = NAME;
	
	return true;
}