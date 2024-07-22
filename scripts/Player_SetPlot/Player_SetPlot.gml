///@arg plot
///@arg value
function Player_SetPlot() {
	var PLOT=argument[0];
	var VALUE=argument[1];

	Flag_Set(FLAG_TYPE.PLOT,PLOT,VALUE);

	return true;
}