/// Category header for debugger lists (tldr-style color + shadow).
///@arg x
///@arg y
///@arg label
///@arg scale*
///@arg color*
function Debugger_ListDrawHeader(){
	var X=argument[0];
	var Y=argument[1];
	var LABEL=argument[2];
	var SCALE=1;
	if(argument_count>=4){
		SCALE=argument[3];
	}

	var text=LABEL;
	var base=c_white;
	if(argument_count>=5){
		base=argument[4];
	}else{
		base=Debugger_ListCategoryColor(LABEL);
	}

	var col=base;
	var shd=1*SCALE;
	draw_set_color(c_black);
	draw_text_transformed(X+shd,Y+shd,text,SCALE,SCALE,0);
	draw_set_color(col);
	draw_text_transformed(X,Y,text,SCALE,SCALE,0);
}
