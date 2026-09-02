event_inherited();

draw_text(0,0,soul_touching_ceiling);
draw_text(0,20,jump_state);
draw_text(0,40,on_board);
draw_text(0,60,move);
draw_text(0,80,global.is_moving);


if(keyboard_check_pressed(ord("Q"))){
	dir+=90;
	dir=dir mod 360;
}