text = "{define `ITEM` `50G`}"+Lang_GetString("box_item")+"{pause}{clear}"
text += Lang_GetString("item.get");

Player_AddGold(50)
Dialog_Add(text)
Dialog_Start()

audio_play_sound(snd_treasure,0,0)