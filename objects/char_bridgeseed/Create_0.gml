event_inherited();

res_override = true

image_speed = 0
block_enabled = false

state = 0//0为在地上 1为捡起 2为在水里移动 3为停止 4为开花中 5为已开花

number = -1

Check = function(){
	if(place_meeting(x+lengthdir_x(1,direction),y+lengthdir_y(1,direction),bg_bridgeseed_stop)||place_meeting(x+lengthdir_x(1,direction),y+lengthdir_y(1,direction),char_bridgeseed)){
		speed = 0;
		state = 3;
		alldone = 0;
		with(char_bridgeseed){
			if(state = 3){
				other.alldone += 1;
			}
		}
		if(alldone = 4){
			// 检测是否有连续4个桥花排成一条直线
			var _found = false;
			var _gap = 20; // 桥花精灵尺寸为20x20，相邻中心间距20px
			
			with (char_bridgeseed) {
				if (!_found && state == 3) {
					// 检测水平方向（左右）
					var _hcount = 1;
					// 向右检测
					for (var i = 1; i <= 3; i++) {
						var _inst = instance_position(x + _gap * i, y, char_bridgeseed);
						if (_inst != noone && _inst.state == 3) _hcount++;
						else break;
					}
					// 向左检测
					for (var i = 1; i <= 3; i++) {
						var _inst = instance_position(x - _gap * i, y, char_bridgeseed);
						if (_inst != noone && _inst.state == 3) _hcount++;
						else break;
					}
					
					if (_hcount >= 4) {
						_found = true;
					}
					
					// 检测垂直方向（上下）
					if (!_found) {
						var _vcount = 1;
						// 向下检测
						for (var i = 1; i <= 3; i++) {
							var _inst = instance_position(x, y + _gap * i, char_bridgeseed);
							if (_inst != noone && _inst.state == 3) _vcount++;
							else break;
						}
						// 向上检测
						for (var i = 1; i <= 3; i++) {
							var _inst = instance_position(x, y - _gap * i, char_bridgeseed);
							if (_inst != noone && _inst.state == 3) _vcount++;
							else break;
						}
						
						if (_vcount >= 4) {
							_found = true;
						}
					}
				}
			}
			
			// 如果找到直线，将所有state=3的桥花设为state=4
			if (_found) {
				with (char_bridgeseed) {
					if (state == 3) {
						state = 4;
						Anim_Create(id,"image_index",0,0,0,6,60);
						Anim_Create(id,"state",0,0,state,1,0,60);
					}
				}
			}
		}
	}
}