function Dialog_Add(TEXT){
	ds_queue_enqueue(global._dialog_queue,TEXT);
	return true;
}
