event_inherited();

draw_text(0,0,soul_touching_ceiling)
draw_text(0,20,jump_state)
draw_text(0,40,on_board)
draw_text(0,60,move)

xx = lengthdir_x(1,dir);
	yy = lengthdir_y(1,dir);

draw_line(x,y,x+xx*20,y+yy*20);

if(keyboard_check_pressed(ord("Q"))){
	dir += 90;
	dir = dir mod 360;
}