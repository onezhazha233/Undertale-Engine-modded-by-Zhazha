///@desc Use
Player_Heal(10);

Dialog_Add(Item_GetTextDrink(_name)+(Player_IsInBattle()&&Battle_GetPlayerTempSpd()<2 ? "&"+Lang_GetString("item.sea_tea.use") : "")+Item_GetTextHeal(10));
Dialog_Start();

Item_Remove(_item_slot);

if(Player_IsInBattle()&&Battle_GetPlayerTempSpd()<2){
	Battle_SetPlayerTempSpd(Battle_GetPlayerTempSpd()+0.5);
	audio_play_sound(snd_speedup,0,false);
}
else{
	audio_play_sound(snd_item_heal,0,false);
}

event_inherited();