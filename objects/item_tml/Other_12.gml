Dialog_Add(Lang_GetString("item.tml.drop"));
Dialog_Start();

Item_Remove(_item_slot);
audio_play_sound(snd_flee,0,0);

instance_destroy();