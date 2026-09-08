event_inherited();

char_id=2;

res_idle_sprite[DIR.UP]=spr_char_sans_up;
res_idle_sprite[DIR.DOWN]=spr_char_sans_down;
res_idle_sprite[DIR.LEFT]=spr_char_sans_right;
res_idle_sprite[DIR.RIGHT]=spr_char_sans_right;

res_move_sprite[DIR.UP]=spr_char_sans_up;
res_move_sprite[DIR.DOWN]=spr_char_sans_down;
res_move_sprite[DIR.LEFT]=spr_char_sans_right;
res_move_sprite[DIR.RIGHT]=spr_char_sans_right;

res_idle_flip_x[DIR.LEFT] = true;
res_move_flip_x[DIR.LEFT] = true;
res_talk_flip_x[DIR.LEFT] = true;

move_speed[DIR.UP]=1;
move_speed[DIR.DOWN]=1;
move_speed[DIR.LEFT]=1;
move_speed[DIR.RIGHT]=1;

if(Player_GetPlot("sans") = 2){
	x += 20;
	y -= 70;
}
if(Player_GetPlot("sans") >= 4){
	x = 80;
	y = 70;
	char_door.image_index = 1;
}