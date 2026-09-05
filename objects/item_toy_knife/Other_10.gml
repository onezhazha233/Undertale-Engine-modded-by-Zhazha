///@desc Use
Dialog_Add(Item_GetTextEquip(_name));
Dialog_Start();
Item_Set(_item_slot,Item_GetWeapon());
Item_SetWeapon(object_index);

Player_SetAtkItem(3);
Flag_Set(FLAG_STATIC,"battle_menu_fight_obj","knife");

audio_play_sound(snd_item_equip,0,false);

event_inherited();