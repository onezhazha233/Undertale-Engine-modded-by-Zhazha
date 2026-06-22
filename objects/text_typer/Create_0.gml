//typer init
event_user(6);

//group init
event_user(5);

width=0;
height=0;
override_alpha_enabled=false;
override_alpha=1;
override_color_text_enabled=false;
override_color_text[0]=c_white;
override_color_text[1]=c_white;
override_color_text[2]=c_white;
override_color_text[3]=c_white;

ttime=0;
torder=[];
_order=0;

auto_destroy=false;

alarm[1] = 1

function CharUpdate(character){
	with(character){
		if(other._position_follow = 1){
			if(other._type_dir = 0){
				x = other.x + _offset_x + _xUnit[0] * _deltaX + _yUnit[0] * _deltaY;
				y = other.y + _offset_y + _xUnit[1] * _deltaX + _yUnit[1] * _deltaY;
			}
			else{
				x = other.x + _offset_x + _xUnit[1] * _deltaX + _yUnit[1] * _deltaY;
				y = other.y + _offset_y + _xUnit[0] * _deltaX + _yUnit[0] * _deltaY;
			}
		}
	}
}

function ChangeText(TEXT){
	event_user(3);
	event_user(6);
	text = TEXT;
}