depth=DEPTH_BATTLE.BOARD;

x=BATTLE_BOARD.X;
y=BATTLE_BOARD.Y;

up=BATTLE_BOARD.UP;
down=BATTLE_BOARD.DOWN;
left=BATTLE_BOARD.LEFT;
right=BATTLE_BOARD.RIGHT;

objs = []

surf_outset_a = -1;
surf_outset_b = -1;
surf_helper = -1;
surf_pending_blacks = -1;
surf_content = -1;

draw_debug_enabled = false
frame_thickness = 5.0;
miter_limit = 6.0;

color_frame = c_white;
color_bg = c_black;
alpha_frame = 1;
alpha_bg = 1;

angle = 0;

event_user(0)

function draw_frames(){
	surface_set_target(surf_outset_a);
	draw_clear_alpha(c_white,0)
	draw_set_alpha(1)
	var cur_obj = objs[0];
	Xpoly_Draw_Inflated(cur_obj.vertices,
			cur_obj.x,cur_obj.y,
			cur_obj.image_angle,
			cur_obj.image_xscale,cur_obj.image_yscale,
			cur_obj.org_x,cur_obj.org_y,frame_thickness,miter_limit,
		draw_debug_enabled,c_white)
	surface_reset_target();

	for(var i=1;i<array_length(objs);i++){
		var cur_obj = objs[i];
		var op = cur_obj.type;
		
		surface_set_target(surf_outset_b);
		draw_clear_alpha(c_white,0)
		draw_set_alpha(1)
		var new_frame_thickness = op == BATTLE_BOARD_TYPE.SUBTRACT ? -frame_thickness : frame_thickness
		Xpoly_Draw_Inflated(cur_obj.vertices,
			cur_obj.x,cur_obj.y,
			cur_obj.image_angle,
			cur_obj.image_xscale,cur_obj.image_yscale,
			cur_obj.org_x,cur_obj.org_y,new_frame_thickness,miter_limit,
			draw_debug_enabled,c_white)
		surface_reset_target();
		Xpoly_Surface_Boolean(surf_outset_a,surf_outset_b,surf_helper,cur_obj.type)
	}
	
	//cut out blacks from inflated polygons, and draw.
	Xpoly_Surface_Boolean(surf_outset_a,surf_pending_blacks,surf_helper,BATTLE_BOARD_TYPE.SUBTRACT)
	draw_surface_ext(surf_outset_a,0,0,1,1,0,color_frame,alpha_frame);
}

//在战斗框框内显示内容表面：用战斗框形状(alpha)做 bm 混合，扣掉框外，再画到屏幕
function draw_surf_content(){
	if(!surface_exists(surf_content)) return;
	if(!surface_exists(surf_pending_blacks)) return;
	//bm_zero,bm_src_alpha: surf_content.alpha *= 战斗框alpha，框外(alpha=0)变透明
	surface_set_target(surf_content);
	gpu_set_blendmode_ext(bm_zero,bm_src_alpha);
	draw_surface(surf_pending_blacks,0,0);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	//画到屏幕（黑色底板之上，之后 draw_frames 的白色描边会盖在上面）
	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
	draw_surface(surf_content,0,0);
	gpu_set_blendmode(bm_normal);
}

function draw_blacks(){
	surface_set_target(surf_outset_a);
	draw_clear_alpha(c_white,0)
	draw_set_alpha(1)
	var cur_obj = objs[0];
	Xpoly_Draw(cur_obj.vertices,
			cur_obj.x,cur_obj.y,
			cur_obj.image_angle,
			cur_obj.image_xscale,cur_obj.image_yscale,
			cur_obj.org_x,cur_obj.org_y,
		draw_debug_enabled,c_white)
	surface_reset_target();
	

	for(var i=1;i<array_length(objs);i++){
		var cur_obj = objs[i];
		
		surface_set_target(surf_outset_b);
		draw_clear_alpha(c_white,0)
		draw_set_alpha(1)
		Xpoly_Draw(cur_obj.vertices,
			cur_obj.x,cur_obj.y,
			cur_obj.image_angle,
			cur_obj.image_xscale,cur_obj.image_yscale,
			cur_obj.org_x,cur_obj.org_y,
			draw_debug_enabled,c_white)
		surface_reset_target();
		Xpoly_Surface_Boolean(surf_outset_a,surf_outset_b,surf_helper,cur_obj.type)
	}
	//store blacks into @surf_outset_a,so that when drawing strokes,the inside regions can be cutout.
	surface_set_target(surf_pending_blacks)
	draw_clear_alpha(c_white,0)
	draw_surface_ext(surf_outset_a,0,0,1,1,0,c_white,1);
	surface_reset_target();
	
	//draws
	draw_surface_ext(surf_pending_blacks,0,0,1,1,0,color_bg,alpha_bg);
}