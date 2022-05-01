/// @description Newcreate
global.borders = [];
global.borderCount = array_length(global.borders);

mainboard = instance_create_depth(x,y,0,battle_board_extra);
ds_list_add(
	mainboard.listVertex,
	[-283,-65],[283,-65],[283,65],[-283,65]
	);
mainboard.updateDivide();

global.borders = [mainboard];
global.borders_list = ds_list_create()
ds_list_add(global.borders_list,mainboard)
mainboard.color_frame = color_frame
mainboard.color_bg = color_bg
mainboard.rot = angle