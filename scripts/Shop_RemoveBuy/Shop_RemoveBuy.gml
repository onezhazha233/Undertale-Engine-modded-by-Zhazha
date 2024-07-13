///@arg id
function Shop_RemoveBuy(){
	var ID = argument[0];
	
	ds_list_delete(shop._host_buy,ID);
	
	return true;
}