///@arg name
function Shop_AddTalk(){
	var NAME = argument[0];
	
	ds_list_add(shop._host_talk,NAME);
	
	return true;
}