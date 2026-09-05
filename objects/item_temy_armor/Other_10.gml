///@desc Use
Dialog_Add(Lang_GetString("item.temy_armor.use"));
Dialog_Start();

Item_Set(_item_slot,Item_GetArmor());
Item_SetArmor(object_index);

Player_SetDefItem(20);
Player_SetInvItem(30);
Player_SetAtkItem(10);

audio_play_sound(snd_item_equip,0,false);

event_inherited();