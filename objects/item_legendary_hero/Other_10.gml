///@desc Use
Player_Heal(40);

Dialog_Add(Item_GetTextEat(_name)+(Player_IsInBattle()&&Player_GetAtkTotal()<150 ? "&"+Lang_GetString("item.legendary_hero.use") : "")+Item_GetTextHeal(40));
Dialog_Start();

Item_Remove(_item_slot);

if(Player_IsInBattle()&&!Battle_IsSerious()&&Player_GetAtkTotal()<150){
	Battle_SetPlayerTempAtk(Battle_GetPlayerTempAtk()+4);
	audio_play_sound(snd_legendary_hero,0,false);
}
else{
	audio_play_sound(snd_item_heal,0,false);
}

event_inherited();