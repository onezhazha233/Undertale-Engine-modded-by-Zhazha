///@desc Use
Player_Heal(10);

Dialog_Add(Lang_GetString("item.bandage.use.0")+Item_GetTextHeal(10));
Dialog_Start();

Item_Remove(_item_slot);

audio_play_sound(snd_item_heal,0,false);

event_inherited();