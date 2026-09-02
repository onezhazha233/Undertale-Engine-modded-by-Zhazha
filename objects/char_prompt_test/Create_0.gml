event_inherited();

res_override = true

cx = 0
cy = 0

surf = surface_create(200,150)
arrow_x = 100
arrow_y = 75
arrow_angle = 90

hspd = 0
vspd = 0

controlling = false
control_delay = 0

paused = false
pause_typer = noone
pause_blink_timer = 30
pause_blink_on = true

bullets = []
asteroids = []
debris = []
spawn_timer = 60
score = 0
fire_cooldown = 0

dying = false
explosion_x = 0
explosion_y = 0
explosion_timer = 0
explosion_speed = 0.1
explosion_repeats = 5
screen_closing = false

Leave = function(){
	Prompt_ClearAll(false,20);
	Anim_Create(camera,"x",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,camera.x,cx-camera.x,20);
	Anim_Create(camera,"y",ANIM_TWEEN.QUAD,ANIM_EASE.OUT,camera.y,cy-camera.y,20);
	DelayFunction(function(){
		char_player.moveable = true;
		camera.target = char_player;
	},20);
	controlling = false;
	paused = true;
	if(!instance_exists(pause_typer) && instance_exists(char_prompt_test_screen)){
		pause_typer = instance_create_depth(char_prompt_test_screen.x + 100, char_prompt_test_screen.y + 75, DEPTH_UI.TEXT, text_typer);
		pause_typer.text = "{halign 1}{valign 1}" + Lang_GetString("prompt_test.pause");
		with(pause_typer){ event_user(15); }
		pause_typer.override_alpha_enabled = true;
		pause_typer.override_alpha = 1;
	}
}