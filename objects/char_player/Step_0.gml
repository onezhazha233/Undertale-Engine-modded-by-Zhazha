can_move=(moveable&&_moveable_dialog&&_moveable_menu&&
_moveable_save&&_moveable_warp&&_moveable_encounter&&
_moveable_box&&_moveable_shop);

if(can_move){
	move[DIR.UP]=0;
	move[DIR.DOWN]=0;
	move[DIR.LEFT]=0;
	move[DIR.RIGHT]=0;
	dir_locked=false;

	var _held_up=Input_IsHeld(INPUT.UP);
	var _held_down=Input_IsHeld(INPUT.DOWN);
	var _held_left=Input_IsHeld(INPUT.LEFT);
	var _held_right=Input_IsHeld(INPUT.RIGHT);
	
	var _mspeed=(move_speed[DIR.UP]);

	if(_held_left&&_held_right){
		_held_right=false;
	}
	var _special_dir=(_held_up&&_held_down);

	var _target_x=x;
	var _target_y=y;
	var _move_down=_held_down;

	if(_held_up){
		if(!(_held_right&&dir==DIR.RIGHT)&&!(_held_left&&dir==DIR.LEFT)){
			dir=DIR.UP;
		}
		_move_down=false;
		_target_y-=_mspeed;
	}
	if(_move_down){
		_target_y+=_mspeed;
		if(!(_held_right&&dir==DIR.RIGHT)&&!(_held_left&&dir==DIR.LEFT)){
			dir=DIR.DOWN;
		}
	}
	if(_held_left){
		_target_x-=_mspeed;
		if(!_special_dir&&!(_held_up&&dir==DIR.UP)&&!(_move_down&&dir==DIR.DOWN)){
			dir=DIR.LEFT;
		}
	}
	if(_held_right){
		_target_x+=_mspeed;
		if(!_special_dir&&!(_held_up&&dir==DIR.UP)&&!(_move_down&&dir==DIR.DOWN)){
			dir=DIR.RIGHT;
		}
	}

	var UP=instance_place(x,y-1,block);
	var DOWN=instance_place(x,y+1,block);
	var LEFT=instance_place(x-1,y,block);
	var RIGHT=instance_place(x+1,y,block);

	if(_held_up&&_held_left&&UP&&UP.block_enabled&&LEFT&&LEFT.block_enabled){
		_target_x=x;
		_target_y=y;
	}
	if(_held_up&&_held_right&&UP&&UP.block_enabled&&RIGHT&&RIGHT.block_enabled){
		_target_x=x;
		_target_y=y;
	}
	if(_held_down&&_held_left&&DOWN&&DOWN.block_enabled&&LEFT&&LEFT.block_enabled){
		_target_x=x;
		_target_y=y;
	}
	if(_held_down&&_held_right&&DOWN&&DOWN.block_enabled&&RIGHT&&RIGHT.block_enabled){
		_target_x=x;
		_target_y=y;
	}

	if(_target_x!=x||_target_y!=y){
		var _collision_right=false;
		var _collision_left=false;
		var _collision_up=false;
		var _collision_down=false;
		if(collision){
			ds_list_clear(_collision_list);
			var count=instance_place_list(x+_mspeed,y,block,_collision_list,false);
			var ci=0;
			repeat(count){
				if(_collision_list[|ci].block_enabled){
					_collision_right=true;
					break;
				}
				ci+=1;
			}
			ds_list_clear(_collision_list);
			count=instance_place_list(x-_mspeed,y,block,_collision_list,false);
			ci=0;
			repeat(count){
				if(_collision_list[|ci].block_enabled){
					_collision_left=true;
					break;
				}
				ci+=1;
			}
			ds_list_clear(_collision_list);
			count=instance_place_list(x,y-_mspeed,block,_collision_list,false);
			ci=0;
			repeat(count){
				if(_collision_list[|ci].block_enabled){
					_collision_up=true;
					break;
				}
				ci+=1;
			}
			ds_list_clear(_collision_list);
			count=instance_place_list(x,y+_mspeed,block,_collision_list,false);
			ci=0;
			repeat(count){
				if(_collision_list[|ci].block_enabled){
					_collision_down=true;
					break;
				}
				ci+=1;
			}
		}
		var _target_blocked=false;
		if(collision){
			ds_list_clear(_collision_list);
			var target_count=instance_place_list(_target_x,_target_y,block,_collision_list,false);
			var ti=0;
			repeat(target_count){
				if(_collision_list[|ti].block_enabled){
					_target_blocked=true;
					break;
				}
				ti+=1;
			}
		}
		if(_target_blocked){
			if(_move_down&&_collision_down){
				if(_held_right&&!_collision_right&&!_special_dir){
					dir=DIR.RIGHT;
					_target_y=y;
				}else if(_held_left&&!_collision_left&&!_special_dir){
					dir=DIR.LEFT;
					_target_y=y;
				}
			}else if((_held_left&&_collision_left)||(_held_right&&_collision_right)){
				if(_move_down&&!_collision_down){
					dir=DIR.DOWN;
					_target_x=x;
				}else if(_held_up&&!_collision_up){
					dir=DIR.UP;
					_target_x=x;
				}
			}else if(_held_up&&_collision_up){
				if(_held_right&&!_collision_right&&!_special_dir){
					dir=DIR.RIGHT;
					_target_y=y;
				}else if(_held_left&&!_collision_left&&!_special_dir){
					dir=DIR.LEFT;
					_target_y=y;
				}
			}else{
				if(Char_BlockAt(_target_x-x,0)){
					_target_x=x;
				}
				if(Char_BlockAt(0,_target_y-y)){
					_target_y=y;
				}
			}
		}
	}

	if(_target_x>x){
		move[DIR.RIGHT]=1;
	}else if(_target_x<x){
		move[DIR.LEFT]=1;
	}
	if(_target_y>y){
		move[DIR.DOWN]=1;
	}else if(_target_y<y){
		move[DIR.UP]=1;
	}

	var _on_tl=place_meeting(x,y,block_corner_topleft);
	var _on_tr=place_meeting(x,y,block_corner_topright);
	var _on_bl=place_meeting(x,y,block_corner_bottomleft);
	var _on_br=place_meeting(x,y,block_corner_bottomright);
	var _corner_slide=false;
	if(_on_tl+_on_tr+_on_bl+_on_br==1){
		if(_on_tl&&!(_held_up&&_held_left&&UP&&UP.block_enabled&&LEFT&&LEFT.block_enabled)){
			if(_held_up){
				move[DIR.RIGHT]=1;
				_corner_slide=true;
			}
			if(_held_left){
				move[DIR.DOWN]=1;
				_corner_slide=true;
			}
		}else if(_on_tr&&!(_held_up&&_held_right&&UP&&UP.block_enabled&&RIGHT&&RIGHT.block_enabled)){
			if(_held_up){
				move[DIR.LEFT]=1;
				_corner_slide=true;
			}
			if(_held_right){
				move[DIR.DOWN]=1;
				_corner_slide=true;
			}
		}else if(_on_bl&&!(_held_down&&_held_left&&DOWN&&DOWN.block_enabled&&LEFT&&LEFT.block_enabled)){
			if(_held_down){
				move[DIR.RIGHT]=1;
				_corner_slide=true;
			}
			if(_held_left){
				move[DIR.UP]=1;
				_corner_slide=true;
			}
		}else if(_on_br&&!(_held_down&&_held_right&&DOWN&&DOWN.block_enabled&&RIGHT&&RIGHT.block_enabled)){
			if(_held_down){
				move[DIR.LEFT]=1;
				_corner_slide=true;
			}
			if(_held_right){
				move[DIR.UP]=1;
				_corner_slide=true;
			}
		}
	}

	if(Input_IsPressed(INPUT.CONFIRM)){
		var inst_list=ds_list_create();
		var bW = bbox_right - bbox_left;
		var bH = bbox_bottom - bbox_top;
		if(dir==DIR.UP){
			inst=collision_rectangle_list(x-bW/3,y-bH*2,x+bW/3,y,char,true,true,inst_list,true);
		}
		if(dir==DIR.DOWN){
			inst=collision_rectangle_list(x-bW/3,y,x+bW/3,y+bH*1.5,char,true,true,inst_list,true);
		}
		if(dir==DIR.LEFT){
			inst=collision_rectangle_list(x-bW,y-bH/3*2,x,y+bH/3,char,true,true,inst_list,true);
		}
		if(dir==DIR.RIGHT){
			inst=collision_rectangle_list(x,y-bH/3*2,x+bW,y+bH/3,char,true,true,inst_list,true);
		}
		if(ds_list_size(inst_list)>0&&instance_exists(inst_list[|0])){
			with(inst_list[|0]){
				event_user(0);
			}
		}
		ds_list_destroy(inst_list);
	}
	if(!instance_exists(ui_dialog)){
		if(Input_IsPressed(INPUT.MENU)){
			instance_create_depth(0,0,0,ui_menu);
		}
	}
	if(_corner_slide){
		dir_locked=true;
	}else{
		dir_locked=(move[dir]>0);
	}
}else{
	dir_locked=false;
}

event_inherited();