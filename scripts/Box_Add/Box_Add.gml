function Box_Add(SLOT,ITEM){
	return Flag_Get(FLAG_STATIC,"box"+string(SLOT)).Add(ITEM);
}