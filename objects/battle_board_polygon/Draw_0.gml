if(draw_enabled){
	Xpoly_Draw_Inflated(vertices,x,y,image_angle,image_xscale,image_yscale,org_x,org_y,frame_thickness,miter_limit,
		draw_debug_enabled,c_white)
	Xpoly_Draw(vertices,x,y,image_angle,image_xscale,image_yscale,org_x,org_y,
		draw_debug_enabled,c_black)
}