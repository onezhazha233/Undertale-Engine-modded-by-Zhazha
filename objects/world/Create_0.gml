depth=DEPTH_UI.WORLD
_time=0;
_frame_skip=0;

// 计算可用的窗口缩放比例
var _sw = display_get_width();
var _sh = display_get_height();
var _base_w = 960;
var _base_h = 540;
var _max_scale = min(
	floor(_sw / _base_w * 2) / 2,
	floor(_sh / _base_h * 2) / 2
);
global.window_scales = [];
for(var _s = 1; _s <= _max_scale; _s += 0.5){
	array_push(global.window_scales, _s);
}

global.debug = true
global.debug_show_blocks = true