///@arg plot
///@arg *default
function Player_GetPlot(){
	var PLOT = argument[0];
	var DEFAULT = 0;
	if(argument_count >= 2){
		DEFAULT = argument[1];
	}
	
	return Flag_Get(FLAG_TYPE.PLOT,PLOT,DEFAULT);
}