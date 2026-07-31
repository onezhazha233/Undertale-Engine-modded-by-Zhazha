///@arg target_x
///@arg target_y
///@arg center_x
///@arg center_y
///@arg angle
function RotateXY(TARGET_X, TARGET_Y, CENTER_X, CENTER_Y, ANGLE){
	ANGLE = -ANGLE;
	
	var RESULT_X=(TARGET_X-CENTER_X)*dcos(ANGLE)-(TARGET_Y-CENTER_Y)*dsin(ANGLE)+CENTER_X;
	var RESULT_Y=(TARGET_Y-CENTER_Y)*dcos(ANGLE)+(TARGET_X-CENTER_X)*dsin(ANGLE)+CENTER_Y;
	
	return [RESULT_X,RESULT_Y];
}