text = "{define `ITEM` `"+string(Item_GetName(contain_item))+"`}"+Lang_GetString("box_item")+"{pause}{clear}"
if(Item_GetNumber() < 8){
	Item_Add(contain_item);
	text += Lang_GetString("item.get");
}
else{
	text += Lang_GetString("item.toomuch");
}

Dialog_Add(text)
Dialog_Start()

audio_play_sound(snd_treasure,0,0)