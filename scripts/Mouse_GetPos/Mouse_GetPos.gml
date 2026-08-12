///@desc 返回鼠标在游戏画面（非 border）中的位置，单位为游戏分辨率（640x480）
function Mouse_GetGamePos(){
	var SW=(window_get_fullscreen() ? display_get_width() : window_get_width());
	var SH=(window_get_fullscreen() ? display_get_height() : window_get_height());
	var MX=window_mouse_get_x();
	var MY=window_mouse_get_y();
	if(Border_IsEnabled()){
		// border 开启：窗口 960x540，游戏画面(应用表面)画在 (base_x+160*SF, base_y+30*SF)
		var SF=min(SW/960,SH/540);
		var base_x=(SW-960*SF)/2;
		var base_y=(SH-540*SF)/2;
		return [(MX-(base_x+160*SF))/SF,(MY-(base_y+30*SF))/SF];
	}
	else{
		// border 关闭：窗口 640x480，游戏画面画在 (base_x,base_y)
		var SF=min(SW/640,SH/480);
		var base_x=(SW-640*SF)/2;
		var base_y=(SH-480*SF)/2;
		return [(MX-base_x)/SF,(MY-base_y)/SF];
	}
}

///@desc 返回鼠标在游戏世界（房间坐标）中的位置，考虑摄像机位置与视野大小
function Mouse_GetWorldPos(){
	var _pos=Mouse_GetGamePos();
	var _gx=_pos[0];
	var _gy=_pos[1];
	if(!instance_exists(camera)){
		return _pos;
	}
	var _vw=camera_get_view_width(camera._camera);
	var _vh=camera_get_view_height(camera._camera);
	var _sx=surface_get_width(application_surface);
	var _sy=surface_get_height(application_surface);
	if(_sx<=0){ _sx=640; }
	if(_sy<=0){ _sy=480; }
	return [
		camera_get_view_x(camera._camera)+_gx*_vw/_sx,
		camera_get_view_y(camera._camera)+_gy*_vh/_sy
	];
}
