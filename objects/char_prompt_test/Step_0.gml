event_inherited();

if(controlling && !dying && Prompt_CheckHold(PROMPT_POS.BOT_RIGHT)){
	Leave();
}

if(paused){
	pause_blink_timer--;
	if(pause_blink_timer <= 0){
		pause_blink_timer = 30;
		pause_blink_on = !pause_blink_on;
	}
	if(instance_exists(pause_typer)){
		pause_typer.override_alpha = pause_blink_on ? 1 : 0.2;
	}
}

var _ix = 0, _iy = 0;
if(control_delay > 0) control_delay--;
if(controlling && !dying && control_delay <= 0 && !paused){
	_ix = Input_IsHeld(INPUT.RIGHT) - Input_IsHeld(INPUT.LEFT);
	_iy = Input_IsHeld(INPUT.DOWN) - Input_IsHeld(INPUT.UP);

	hspd = clamp(hspd + _ix * 0.3, -4, 4);
	vspd = clamp(vspd + _iy * 0.3, -4, 4);

	if(fire_cooldown > 0) fire_cooldown--;
	if(Input_IsHeld(INPUT.CONFIRM) && fire_cooldown <= 0){
		var _bspd = 4;
		array_push(bullets, {
			x: arrow_x,
			y: arrow_y,
			hspd: lengthdir_x(_bspd, arrow_angle),
			vspd: lengthdir_y(_bspd, arrow_angle),
			angle: arrow_angle,
			spin: 8
		});
		fire_cooldown = 8;
	}

	spawn_timer--;
	if(spawn_timer <= 0){
		spawn_timer = irandom_range(90, 180);
		var _radius = irandom_range(8, 18);
		var _side = irandom(3);
		var _ax = 0, _ay = 0;
		switch(_side){
			case 0: _ax = random(200); _ay = -_radius - 2; break;
			case 1: _ax = 200 + _radius + 2; _ay = random(150); break;
			case 2: _ax = random(200); _ay = 150 + _radius + 2; break;
			case 3: _ax = -_radius - 2; _ay = random(150); break;
		}
		var _dir = point_direction(_ax, _ay, 100 + random_range(-40, 40), 75 + random_range(-30, 30));
		var _spd = 0.4 + random(0.5);
		array_push(asteroids, {
			x: _ax, y: _ay,
			hspd: lengthdir_x(_spd, _dir),
			vspd: lengthdir_y(_spd, _dir),
			radius: _radius,
			hp: floor(_radius / 3)
		});
	}
}

if(!dying && !paused){
	var _speed = point_distance(0, 0, hspd, vspd);
	if(_speed > 0.2){
		var _target_angle = point_direction(0, 0, hspd, vspd);
		arrow_angle += angle_difference(_target_angle, arrow_angle) / 3;
	}

	arrow_x += hspd;
	arrow_y += vspd;

	var _min_x = 10, _max_x = 187;
	var _min_y = 8,  _max_y = 142;
	if(arrow_x < _min_x){ arrow_x = _min_x; hspd = max(hspd, 0); }
	if(arrow_x > _max_x){ arrow_x = _max_x; hspd = min(hspd, 0); }
	if(arrow_y < _min_y){ arrow_y = _min_y; vspd = max(vspd, 0); }
	if(arrow_y > _max_y){ arrow_y = _max_y; vspd = min(vspd, 0); }

	if(_ix == 0 && hspd != 0){
		hspd -= sign(hspd) * 0.3;
		if(abs(hspd) < 0.3) hspd = 0;
	}
	if(_iy == 0 && vspd != 0){
		vspd -= sign(vspd) * 0.3;
		if(abs(vspd) < 0.3) vspd = 0;
	}
}

if(!dying && !paused){
	for(var i = 0; i < array_length(asteroids); i++){
		var _a = asteroids[i];
		if(point_distance(arrow_x, arrow_y, _a.x, _a.y) < _a.radius + 6){
			dying = true;
			explosion_x = arrow_x;
			explosion_y = arrow_y;
			explosion_timer = 0;
			screen_closing = false;
			for(var k = 0; k < array_length(asteroids); k++){
				var _aa = asteroids[k];
				var _count = irandom_range(5, 9);
				for(var m = 0; m < _count; m++){
					var _ddir = random(360);
					var _dspd = 1 + random(2.5);
					var _life = 35;
					array_push(debris, {
						x: _aa.x, y: _aa.y,
						hspd: lengthdir_x(_dspd, _ddir),
						vspd: lengthdir_y(_dspd, _ddir),
						radius: _aa.radius * 0.45,
						life: _life,
						max_life: _life
					});
				}
			}
			asteroids = [];
			bullets = [];
			break;
		}
	}
}

if(!dying && !paused){
	for(var i = array_length(bullets) - 1; i >= 0; i--){
		var _b = bullets[i];
		_b.x += _b.hspd;
		_b.y += _b.vspd;
		_b.angle += _b.spin;
		if(_b.x < -6 || _b.x > 206 || _b.y < -6 || _b.y > 156){
			array_delete(bullets, i, 1);
		}
	}

	for(var i = array_length(asteroids) - 1; i >= 0; i--){
		var _a = asteroids[i];
		_a.x += _a.hspd;
		_a.y += _a.vspd;
		if(_a.x < -40 || _a.x > 240 || _a.y < -40 || _a.y > 190){
			array_delete(asteroids, i, 1);
			continue;
		}
		var _hit = false;
		for(var j = array_length(bullets) - 1; j >= 0; j--){
			var _b = bullets[j];
			if(point_distance(_b.x, _b.y, _a.x, _a.y) < _a.radius){
				array_delete(bullets, j, 1);
				_hit = true;
				break;
			}
		}
		if(_hit){
			_a.hp--;
			if(_a.hp <= 0){
				var _count = irandom_range(4, 7);
				for(var k = 0; k < _count; k++){
					var _ddir = random(360);
					var _dspd = 1 + random(2);
					var _life = 30;
					array_push(debris, {
						x: _a.x, y: _a.y,
						hspd: lengthdir_x(_dspd, _ddir),
						vspd: lengthdir_y(_dspd, _ddir),
						radius: _a.radius * 0.4,
						life: _life,
						max_life: _life
					});
				}
				array_delete(asteroids, i, 1);
				score += 10;
			}
		}
	}
}

if(dying){
	if(!screen_closing){
		explosion_timer += explosion_speed;
		var _total = explosion_repeats * sprite_get_number(spr_char_prompt_test_explosion);
		if(explosion_timer >= _total){
			screen_closing = true;
			char_prompt_test_screen.ScreenOff();
		}
	}
	if(screen_closing && char_prompt_test_screen.surf_xscale <= 0.01){
		Prompt_ClearAll(false, 20);
		Anim_Create(camera,"x",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,camera.x,cx-camera.x,20);
		Anim_Create(camera,"y",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,camera.y,cy-camera.y,20);
		DelayFunction(function(){
			char_player.moveable = true;
			char_player.dir = DIR.DOWN;
			camera.target = char_player;
		},20);
		controlling = false;
		dying = false;

		arrow_x = 100;
		arrow_y = 75;
		arrow_angle = 90;
		hspd = 0;
		vspd = 0;
		bullets = [];
		asteroids = [];
		debris = [];
		spawn_timer = 60;
		score = 0;
		fire_cooldown = 0;
		explosion_x = 0;
		explosion_y = 0;
		explosion_timer = 0;
		screen_closing = false;
		control_delay = 0;
		paused = false;
		pause_typer = noone;
	}
}

if(!paused){
	for(var i = array_length(debris) - 1; i >= 0; i--){
		var _d = debris[i];
		_d.x += _d.hspd;
		_d.y += _d.vspd;
		_d.hspd *= 0.96;
		_d.vspd *= 0.96;
		_d.life--;
		if(_d.life <= 0){
			array_delete(debris, i, 1);
		}
	}
}