function Flag_Init(){
	global.flag ={};
	
	// 设置初始化（仅游戏启动时执行，Flag_Custom 不会重置）
	#macro FLAG_SETTINGS "settings"
	var flag_settings = new Flag_Storage();
	Flag_RegisterType(FLAG_SETTINGS,flag_settings);
	Flag_CustomSettings();
	
	Flag_Custom();
}