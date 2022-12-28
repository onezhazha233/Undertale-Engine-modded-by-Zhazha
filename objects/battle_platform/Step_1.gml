var _temp_local_var_2, _temp_local_var_3;
image_xscale = (width / 2)
image_angle = angle
sprite_index = (sticky ? spr_battle_platform_green : spr_battle_platform_purple)
if (! bounce_x)
    x = (x + move_x)
else
{
    _temp_local_var_2 = (abs(move_x) * 10)
    _temp_local_var_3 = _temp_local_var_2
    if (_temp_local_var_2 <= 0)
    {
    }
    else
    {
        while (true)
        {
			var isInside = false;
		for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
			bb = ds_list_find_value(global.borders_list,i);
			if(bb.contains(x - sprite_width/2 + (sign(move_x) * 0.1), y)) {
				isInside = true;
				break;
			}
		}
			var isInside1 = false;
		for(var i = 0; i < global.borderCount; i++) {	//遍历所有框，判断是否出框
			bb = ds_list_find_value(global.borders_list,i);
			if(bb.contains(x + sprite_width/2 + (sign(move_x) * 0.1), y)) {
				isInside1 = true;
				break;
			}
		}
            //if (! place_meeting((x + (sign(move_x) * 0.1)), y, block))
			if(isInside&&isInside1)
            {
                x = (x + (sign(move_x) * 0.1))
                _temp_local_var_3 = (_temp_local_var_3 - 1)
                if _temp_local_var_3
                    continue
            }
            else
            {
                move_x = (- move_x)
                break
            }
            break
        }
    }
}
y = (y + move_y)
if (Battle_GetState() != BATTLE_STATE.IN_TURN)
    instance_destroy()