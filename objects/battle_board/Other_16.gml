if(!New_use){
	_rdir = point_direction(x, y, 0, 0)
	_rdis = point_distance(x, y, 0, 0)
	_rx = (lengthdir_x(_rdis, (_rdir - _angle)) + x)
	_ry = (lengthdir_y(_rdis, (_rdir - _angle)) + y)
	surface_set_target(_surface2)
	draw_clear_alpha(c_black, 0)
	if(_angle%360==0){
		draw_surface_part_ext(_surface1,_surface_x,_surface_y,_surface_width,_surface_height,_surface_x,_surface_y,1,1,color,alpha);
	}
	else{
		//Get the first vertex poisition
		//setting(vertex 1)
		_point_x = x - left
	    _point_y = y - up
		//Get poisition(vertex 1)
	    event_user(0)
	    var vertex1_x = _point_x
	    var vertex1_y = _point_y
		//Get the second vertex poisition
		//setting(vertex 2)
	    _point_x = x + right
	    _point_y = y - up
		//Get poisition(vertex 2)
	    event_user(0)
	    var vertex2_x = _point_x
	    var vertex2_y = _point_y
		//Get the third vertex poisition
		//setting(vertex 3)
	    _point_x = x - left
	    _point_y = y + down
		//Get poisition(vertex 3)
	    event_user(0)
	    var vertex3_x = _point_x
	    var vertex3_y = _point_y
		//Get the fourth vertex poisition
		//setting(vertex 4)
	    _point_x = x + right
	    _point_y = y + down
		//Get poisition(vertex 4)
	    event_user(0)
	    var vertex4_x = _point_x
	    var vertex4_y = _point_y
		//Setting end
		var texture = surface_get_texture(_surface1)//Set draw vertexes target
		draw_primitive_begin_texture(pr_trianglestrip,texture)//Start draw
		//vertex 1
		draw_vertex_texture_color(vertex1_x,vertex1_y,vertex1_x/640,vertex1_y/480,color,alpha)
		//vertex 2
	    draw_vertex_texture_color(vertex2_x,vertex2_y,vertex2_x/640,vertex2_y/480,color,alpha)
		//vertex 3
	    draw_vertex_texture_color(vertex3_x,vertex3_y,vertex3_x/640,vertex3_y/480,color,alpha)
		//vertex 4
	    draw_vertex_texture_color(vertex4_x,vertex4_y,vertex4_x/640,vertex4_y/480,color,alpha)
		draw_primitive_end()//Draw end
	}
	surface_reset_target();
	surface_set_target(_surface1)
	draw_clear_alpha(c_black, 0)
	//Get the first vertex poisition
	//setting(vertex 1)
	_point_x = x - left
	_point_y = y - up
	//Get poisition(vertex 1)
	event_user(0)
	var vertex1_x = _point_x
	var vertex1_y = _point_y
	//Get the second vertex poisition
	//setting(vertex 2)
	_point_x = x + right
	_point_y = y - up
	//Get poisition(vertex 2)
	event_user(0)
	var vertex2_x = _point_x
	var vertex2_y = _point_y
	//Get the third vertex poisition
	//setting(vertex 3)
	_point_x = x - left
	_point_y = y + down
	//Get poisition(vertex 3)
	event_user(0)
	var vertex3_x = _point_x
	var vertex3_y = _point_y
	//Get the fourth vertex poisition
	//setting(vertex 4)
	_point_x = x + right
	_point_y = y + down
	//Get poisition(vertex 4)
	event_user(0)
	var vertex4_x = _point_x
	var vertex4_y = _point_y
	//Setting end
	var texture = surface_get_texture(_surface2)//Set draw vertexes target
	draw_primitive_begin_texture(pr_trianglestrip,texture)//Start draw
	//vertex 1
	draw_vertex_texture_color(vertex1_x,vertex1_y,vertex1_x/640,vertex1_y/480,color,alpha)
	//vertex 2
	draw_vertex_texture_color(vertex2_x,vertex2_y,vertex2_x/640,vertex2_y/480,color,alpha)
	//vertex 3
	draw_vertex_texture_color(vertex3_x,vertex3_y,vertex3_x/640,vertex3_y/480,color,alpha)
	//vertex 4
	draw_vertex_texture_color(vertex4_x,vertex4_y,vertex4_x/640,vertex4_y/480,color,alpha)
	draw_primitive_end()//Draw end
	//draw_surface_part_ext(_surface2, _surface_x, _surface_y, _surface_width, _surface_height, _surface_x, _surface_y, 1, 1, color, alpha)
	surface_reset_target()
	_rx = (lengthdir_x(_rdis, (_rdir + _angle)) + x)
	_ry = (lengthdir_y(_rdis, (_rdir + _angle)) + y)
	with (battle_board_cover){
	    angle *= -1;
	}
	surface_set_target(_surface4)
	gpu_set_blendenable(false)
	gpu_set_colorwriteenable(0, 0, 0, 1)
	draw_set_alpha(0)
	draw_rectangle(0, 0, 640, 480, false)
	draw_set_alpha(1)
	xx[0] = ((-left) - 5)
	yy[0] = ((-up) - 5)
	xx[1] = ((-left) - 5)
	yy[1] = (down + 5)
	xx[2] = (right + 5)
	yy[2] = ((-up) - 5)
	xx[3] = (right + 5)
	yy[3] = (down + 5)
	for (i = 0; i < 4; i++){
	    X = ((xx[i] * dcos((-_angle))) - (yy[i] * dsin((-_angle))));
	    Y = ((xx[i] * dsin((-_angle))) + (yy[i] * dcos((-_angle))));
	    xx[i] = X;
	    yy[i] = Y;
	}
	draw_primitive_begin(5)
	for (i = 0; i < 4; i++){
	    draw_vertex((x + xx[i]), (y + yy[i]));
	}
	draw_primitive_end()
	draw_set_alpha(0)
	with (battle_board_cover){
	    draw_primitive_begin(5);
		draw_sprite_ext(spr_pixel_big,0,x,y,xscale/2,yscale/2,angle*-1,c_white,0);
	    draw_primitive_end();
	}
	draw_set_alpha(1)
	gpu_set_blendenable(true)
	gpu_set_colorwriteenable(1, 1, 1, 1)
	surface_reset_target()
	
	surface_set_target(_surface3)
	gpu_set_blendenable(false)
	gpu_set_colorwriteenable(0, 0, 0, 1)
	draw_set_alpha(0)
	draw_rectangle(0, 0, 640, 480, false)
	draw_set_alpha(1)
	gpu_set_blendenable(true)
	gpu_set_colorwriteenable(1, 1, 1, 1)
	gpu_set_blendmode_ext(bm_inv_dest_alpha, bm_dest_alpha)
	gpu_set_alphatestenable(1)
	draw_sprite_ext(spr_pixel, 0, _frame_up_x, _frame_up_y, _frame_up_width, _frame_up_height, _angle, color_frame, alpha_frame)
	draw_sprite_ext(spr_pixel, 0, _frame_left_x, _frame_left_y, _frame_left_width, _frame_left_height, _angle, color_frame, alpha_frame)
	draw_sprite_ext(spr_pixel, 0, _frame_down_x, _frame_down_y, _frame_down_width, _frame_down_height, _angle, color_frame, alpha_frame)
	draw_sprite_ext(spr_pixel, 0, _frame_right_x, _frame_right_y, _frame_right_width, _frame_right_height, _angle, color_frame, alpha_frame)
	if(_angle%360==0){
		draw_surface_part_ext(_surface1,_surface_x,_surface_y,_surface_width,_surface_height,_surface_x,_surface_y,1,1,color,alpha);
	}
	else{
		//Get the first vertex poisition
		//setting(vertex 1)
		_point_x = x - left
	    _point_y = y - up
		//Get poisition(vertex 1)
	    event_user(0)
	    var vertex1_x = _point_x
	    var vertex1_y = _point_y
		//Get the second vertex poisition
		//setting(vertex 2)
	    _point_x = x + right
	    _point_y = y - up
		//Get poisition(vertex 2)
	    event_user(0)
	    var vertex2_x = _point_x
	    var vertex2_y = _point_y
		//Get the third vertex poisition
		//setting(vertex 3)
	    _point_x = x - left
	    _point_y = y + down
		//Get poisition(vertex 3)
	    event_user(0)
	    var vertex3_x = _point_x
	    var vertex3_y = _point_y
		//Get the fourth vertex poisition
		//setting(vertex 4)
	    _point_x = x + right
	    _point_y = y + down
		//Get poisition(vertex 4)
	    event_user(0)
	    var vertex4_x = _point_x
	    var vertex4_y = _point_y
		//Setting end
		var texture = surface_get_texture(_surface1)//Set draw vertexes target
		draw_primitive_begin_texture(pr_trianglestrip,texture)//Start draw
		//vertex 1
		draw_vertex_texture_color(vertex1_x,vertex1_y,vertex1_x/640,vertex1_y/480,color,alpha)
		//vertex 2
	    draw_vertex_texture_color(vertex2_x,vertex2_y,vertex2_x/640,vertex2_y/480,color,alpha)
		//vertex 3
	    draw_vertex_texture_color(vertex3_x,vertex3_y,vertex3_x/640,vertex3_y/480,color,alpha)
		//vertex 4
	    draw_vertex_texture_color(vertex4_x,vertex4_y,vertex4_x/640,vertex4_y/480,color,alpha)
		draw_primitive_end()//Draw end
	}
	with (battle_board_cover){
	    gpu_set_blendenable(false);
	    draw_set_color(c_white);
	    draw_set_alpha(1);
		draw_sprite_ext(spr_pixel_big,0,x,y,xscale/2+5,yscale/2+5,angle*-1,c_white,1);
	    gpu_set_blendenable(true);
	    angle *= -1
	}
	gpu_set_alphatestenable(0)
	gpu_set_blendmode(bm_normal)
	gpu_set_blendenable(false)
	gpu_set_colorwriteenable(0, 0, 0, 1)
	draw_set_alpha(1)
	draw_surface(_surface4, 0, 0)
	draw_set_alpha(1)
	gpu_set_blendenable(true)
	gpu_set_colorwriteenable(1, 1, 1, 1)
	surface_reset_target()
	draw_surface(_surface3, 0, 0)
}