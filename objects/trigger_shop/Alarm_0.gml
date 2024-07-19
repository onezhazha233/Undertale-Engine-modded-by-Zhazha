Shop_Start(0)
with(char_player){
	while(place_meeting(x,y,trigger_shop)){
		y -= 5;
	}
}
_triggered=false
Fader_Fade(1,0,20)