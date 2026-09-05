if(_input_acceptable){
	for(var i=0;i<_num_targets;i++){
		var t=_targets[i];
		if(t.active&&!t.hit){
			t.x+=_target_speed;
		}
	}

	var target=_targets[_current_target];

	if(target.active&&!target.hit){
		if(target.fading){
			target.alpha-=0.1;
			if(target.alpha<=0){
				target.alpha=0;
				target.hit=true;
				target.score=0;

				_current_target++;
				if(_current_target>=_num_targets){
					_finish_all_targets();
				}
			}
		}

		if(!target.hit&&!target.fading&&target.x>battle_board.x){
			target.fading=true;
		}

		if(Input_IsPressed(INPUT.CONFIRM)&&!target.hit){
			target.hit=true;
			target.fading=false;

			var dist=abs(target.x-battle_board.x);
			var _sc=0;
			var frame=0;

			for(var j=0;j<array_length(_score_table);j++){
				if(dist<_score_table[j][0]){
					_sc=_score_table[j][1];
					frame=_score_table[j][2];
					break;
				}
			}

			if(frame==2){
				audio_play_sound(snd_shoe_hit_1,0,false);
			}else if(frame==1){
				audio_play_sound(snd_shoe_hit_0,0,false);
			}

			target.score=_sc;
			target.fadebar_frame=frame;
			target.fadebar_alpha=1.0;
			target.fadebar_scale=1.0;
			if(frame==2){
				target.fadebar_image_speed=0.5;
				target.fadebar_image_index=2;
			}

			_total_score+=_sc;

			_current_target++;
			if(_current_target>=_num_targets){
				_finish_all_targets();
			}
		}
	}
}

for(var k=0;k<_num_targets;k++){
	var ft=_targets[k];
	if(ft.fadebar_alpha>0){
		ft.fadebar_alpha-=0.05;
		ft.fadebar_scale+=0.05;
		if(ft.fadebar_image_speed>0){
			ft.fadebar_image_index+=ft.fadebar_image_speed;
		}
	}
}