function Xpoly_Init(){
	//注意：要用 board_initialized 的“值”判断，而不是“是否存在”。
	//Xpoly_UnInit() 会把它置 false 并删除缓冲区；若只判断存在性，重启后会跳过重建，导致碰撞检测崩溃。
	if(variable_global_exists("board_initialized") && global.board_initialized) return;
	global.board_initialized = true;
	global.buf_cap = 524288;
	global.buf_in = buffer_create(global.buf_cap,buffer_fixed,4);
	global.buf_out = buffer_create(global.buf_cap,buffer_fixed,4);
}

function Xpoly_Is_Initialized(){
	if(!variable_global_exists("board_initialized")) return false;
	return global.board_initialized;
}

function Xpoly_UnInit(){
	global.board_initialized = false;
	buffer_delete(global.buf_in);
	buffer_delete(global.buf_out);
}