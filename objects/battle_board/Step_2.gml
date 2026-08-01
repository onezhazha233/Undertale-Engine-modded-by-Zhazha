global.borders = [noone]
for(i=0;i<ds_list_size(global.borders_list);i+=1){
	ds_list_delete(global.borders_list,ds_list_find_index(global.borders_list,noone));
	global.borders[i] = ds_list_find_value(global.borders_list,i);
}
global.borderCount = array_length(global.borders)