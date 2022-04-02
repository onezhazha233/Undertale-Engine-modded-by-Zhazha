/// @description Insert description here
// You can write your code in this editor
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
            if (! place_meeting((x + (sign(move_x) * 0.1)), y, block))
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