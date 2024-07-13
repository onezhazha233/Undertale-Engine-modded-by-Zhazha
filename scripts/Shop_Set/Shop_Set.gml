///@arg id
///@arg host
///@arg menu_dialog
///@arg bgm
function Shop_Set(){
	var ID=argument[0];
	var HOST=argument[1];
	var MENU_DIALOG=argument[2];
	var BGM=argument[3];

	if(ID>=0){
		var map=global._shop;
		var map_e=-1;
		if(ds_map_exists(map,ID)){
			map_e=ds_map_find_value(map,ID);
			ds_map_clear(map_e);
		}else{
			map_e=ds_map_create();
			ds_map_add(map,ID,map_e);
		}
		ds_map_add(map_e,"host",HOST);
		ds_map_add(map_e,"menu_dialog",MENU_DIALOG);
		ds_map_add(map_e,"bgm",BGM);
		return true;
	}else{
		return false;
	}
}