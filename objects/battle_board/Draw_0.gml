if(array_length(objs)>=1){
	//Please Always draw blacks first,and then strokes.
	draw_blacks();
	draw_surf_content();
	draw_frames();
}

//内容表面在“绘制之后”再清空，避免把本帧其他对象写入的内容冲掉
if(surface_exists(surf_content)){
	surface_set_target(surf_content);
	draw_clear_alpha(c_black,0);
	surface_reset_target();
}