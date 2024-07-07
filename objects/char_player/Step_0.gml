var can_move=(moveable&&_moveable_dialog&&_moveable_menu&&_moveable_save&&_moveable_warp&&_moveable_encounter&&_moveable_box);
if(can_move){
	var UP=instance_place(x,y-0.05,block);
	var DOWN=instance_place(x,y+0.05,block);
	var LEFT=instance_place(x-0.05,y,block);
	var RIGHT=instance_place(x+0.05,y,block);
	if(Input_IsHeld(INPUT.UP)){
		if(UP&&UP.block_enabled=true){
			if(Input_IsHeld(INPUT.LEFT)||Input_IsHeld(INPUT.RIGHT)){
				move[DIR.UP]=0;
			}else{
				move[DIR.UP]=0;
				dir=DIR.UP;
				sprite_index=res_move_sprite[DIR.UP];
			}
		}else{
			move[DIR.UP]=2;
	    }
	}else if(Input_IsHeld(INPUT.DOWN)){
		if(DOWN&&DOWN.block_enabled=true){
			if(Input_IsHeld(INPUT.LEFT)||Input_IsHeld(INPUT.RIGHT)){
				move[DIR.DOWN]=0;
			}else{
				move[DIR.DOWN]=0;
				dir=DIR.DOWN;
				sprite_index=res_move_sprite[DIR.DOWN];
			}
		}else{
			move[DIR.DOWN]=2;
	    }
	}
	if(Input_IsHeld(INPUT.LEFT)){
		if(LEFT&&LEFT.block_enabled=true){
			if(Input_IsHeld(INPUT.UP)||Input_IsHeld(INPUT.DOWN)){
				move[DIR.LEFT]=0;
			}else{
				move[DIR.LEFT]=0;
				dir=DIR.LEFT;
				sprite_index=res_move_sprite[DIR.LEFT];
			}
		}else{
			move[DIR.LEFT]=2;
	    }
	}else if(Input_IsHeld(INPUT.RIGHT)){
		if(RIGHT&&RIGHT.block_enabled=true){
			if(Input_IsHeld(INPUT.UP)||Input_IsHeld(INPUT.DOWN)){
				move[DIR.RIGHT]=0;
			}else{
				move[DIR.RIGHT]=0;
				dir=DIR.RIGHT;
				sprite_index=res_move_sprite[DIR.RIGHT];
			}
		}else{
			move[DIR.RIGHT]=2;
	    }
	}
	/*if(Input_IsHeld(INPUT.UP)){
		move[DIR.UP]=2;
	}else if(Input_IsHeld(INPUT.DOWN)){
		move[DIR.DOWN]=2;
	}
	if(Input_IsHeld(INPUT.LEFT)){
		move[DIR.LEFT]=2;
	}else if(Input_IsHeld(INPUT.RIGHT)){
		move[DIR.RIGHT]=2;
	}*/
	if(Input_IsPressed(INPUT.CONFIRM)){
		var inst=noone;
		if(dir==DIR.UP){
			inst=collision_rectangle(x-sprite_width/2+4,y-5,x+sprite_width/2-4,y-sprite_height+5,char,false,true);
		}
		if(dir==DIR.DOWN){
			inst=collision_rectangle(x-sprite_width/2+4,y-sprite_height+20,x+sprite_width/2-4,y+15,char,false,true);
		}
		if(dir==DIR.LEFT){
			inst=collision_rectangle(x,y-sprite_height+19,x+sprite_width/2-15,y,char,false,true);
		}
		if(dir==DIR.RIGHT){
			inst=collision_rectangle(x,y-sprite_height+19,x+sprite_width/2+15,y,char,false,true);
		}
		if(instance_exists(inst)){
			with(inst){
				event_user(0);
			}
		}
	}
	if(!instance_exists(ui_dialog)){
		if(Input_IsPressed(INPUT.MENU)){
			instance_create_depth(0,0,0,ui_menu);
		}
	}
}

event_inherited();