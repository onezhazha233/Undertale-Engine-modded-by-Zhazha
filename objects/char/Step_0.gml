var proc=0;
var _did_move=false;

repeat(4){
	if(move[proc]>0){
		if(!dir_locked){
			dir=proc;
		}
		var move_x=0;
		var move_y=0;
		if(proc==DIR.UP || proc==DIR.DOWN){
			move_y=0.05*(proc==DIR.UP ? -1 : 1);
		}else if(proc==DIR.LEFT || proc==DIR.RIGHT){
			move_x=0.05*(proc==DIR.LEFT ? -1 : 1);
		}
		var _step_spd=(move_speed[proc]);
		repeat(_step_spd*20){
			var cmove=true;
			if(collision){
				var list=_collision_list;
				ds_list_clear(list);
				var num=instance_place_list(x+move_x,y+move_y,block,list,false);
				var procl=0;
				repeat(num){
					var inst=list[|procl];
					if(instance_exists(inst)){
						if(inst.block_enabled){
							cmove=false;
							break;
						}
					}
					procl+=1;
				}
			}
			if(cmove){
				x+=move_x;
				y+=move_y;
				_did_move=true;
			}else{
				break;
			}
		}
		move[proc]-=1;
	}
	proc+=90;
}

var _show_move=_did_move;
var refresh=((dir!=_dir_previous || talking!=_talking_previous || _show_move!=_move_any_previous) && !res_override);

if(refresh){
	if(_show_move){
		var _move_spr=res_move_sprite[dir];
		var _move_img=res_move_image[dir];
		var _move_spd=res_move_speed[dir];
		var _move_flip=res_move_flip_x[dir];
		sprite_index=_move_spr;
		image_index=_move_img;
		image_speed=_move_spd;
		image_xscale*=((_move_flip&&sign(image_xscale)==1)||(!_move_flip&&sign(image_xscale)==-1) ? -1 : 1);
	}else if(talking){
		sprite_index=res_talk_sprite[dir];
		image_index=res_talk_image[dir];
		image_speed=res_talk_speed[dir];
		image_xscale*=((res_talk_flip_x[dir]&&sign(image_xscale)==1)||(!res_talk_flip_x[dir]&&sign(image_xscale)==-1) ? -1 : 1);
	}else{
		sprite_index=res_idle_sprite[dir];
		image_index=res_idle_image[dir];
		image_speed=res_idle_speed[dir];
		image_xscale*=((res_idle_flip_x[dir]&&sign(image_xscale)==1)||(!res_idle_flip_x[dir]&&sign(image_xscale)==-1) ? -1 : 1);
	}
}

_talking_previous=talking;
_dir_previous=dir;
_move_any_previous=_show_move;