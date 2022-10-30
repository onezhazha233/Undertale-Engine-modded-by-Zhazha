ds_list_clear(mainboard.listVertex);
ds_list_add(
mainboard.listVertex,
[-left,-up],[right,-up],[right,down],[-left,down]
);

mainboard.x = x
mainboard.y = y
mainboard.rot = angle
mainboard.color_frame = color_frame

global.borderCount = ds_list_size(global.borders_list)