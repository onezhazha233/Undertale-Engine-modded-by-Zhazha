///@arg target_x
///@arg target_y
///@arg center_x
///@arg center_y
///@arg angle
function RotateXY(){
	var TARGET_X = argument[0];
	var TARGET_Y = argument[1];
	var CENTER_X = argument[2];
	var CENTER_Y = argument[3];
	var ANGLE = -argument[4];
	
	var RESULT_X=(TARGET_X-CENTER_X)*dcos(ANGLE)-(TARGET_Y-CENTER_Y)*dsin(ANGLE)+CENTER_X;
	var RESULT_Y=(TARGET_Y-CENTER_Y)*dcos(ANGLE)+(TARGET_X-CENTER_X)*dsin(ANGLE)+CENTER_Y;
	
	return [RESULT_X,RESULT_Y];
}