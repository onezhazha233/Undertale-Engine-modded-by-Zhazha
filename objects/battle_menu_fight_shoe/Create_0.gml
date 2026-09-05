event_inherited();

depth=DEPTH_BATTLE.UI_HIGH;

_input_acceptable=true;
_num_targets=3+3;
_target_speed=5;
_crit_per_target=100;
_anim_time=20;

_score_table=[
	[10,110,2],
	[20,90,1],
	[30,80,1],
	[40,70,1],
	[50,50,1],
	[100,40,1],
	[160,20,0],
	[220,15,0],
	[999,10,0]
];

_targets=[];
_current_target=0;
_total_score=0;
_crit=false;

var left_edge=battle_board.x-battle_board.left;
/*var _offsets=[
	-50,
	choose(0,25,50),
	choose(100,125,150)
];*/
for(i=0;i<6;i+=1)_offsets[i] = +50*i;

for(var i=0;i<_num_targets;i++){
	array_push(_targets,{
		x:left_edge-_offsets[i],
		active:true,
		hit:false,
		score:0,
		fadebar_frame:0,
		fadebar_alpha:0,
		fadebar_scale:1.0,
		fadebar_image_index:0,
		fadebar_image_speed:0,
		alpha:1.0,
		fading:false
	});
}

_finish_all_targets=function(){
	_input_acceptable=false;

	if(_total_score==0){
		Battle_SetMenuFightDamage(0);
		Battle_SetMenuFightAnimTime(0);
		Anim_Create(id,"image_alpha",0,0,1,-1,30);
	}else{
		if(_total_score>430){
			_total_score*=1.8;
		}
		if(_total_score>=400){
			_total_score*=1.25;
		}

		_crit=(_total_score>_crit_per_target*_num_targets);

		var ATK=Player_GetAtkTotal();
		var DEF=Battle_GetEnemyDEF(Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy()));
		var damage=ATK-DEF;
		damage*=(_total_score/160)*(4/_num_targets);
		damage=round(damage);
		damage+=round(random(2));
		if(damage<=0)damage=1;

		Battle_SetMenuFightAnimTime(_anim_time);
		Battle_SetMenuFightDamage(damage);
	}
	Battle_SetMenuFightDamageTime(60);
	Battle_EndMenuFightAim();
};