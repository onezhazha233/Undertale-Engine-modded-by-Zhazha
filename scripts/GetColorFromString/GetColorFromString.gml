///@arg string
function GetColorFromString() {
	var STR=argument[0];

	var color=c_white;
	switch(STR){
		case "aqua":
	        color = c_aqua;
	        break;
	    case "black":
	        color = c_black;
	        break;
	    case "blue":
	        color = c_blue;
	        break;
	    case "dkgray":
	        color = c_dkgray;
	        break;
	    case "fuchsia":
	        color = c_fuchsia;
	        break;
	    case "gray":
	        color = c_gray;
	        break;
	    case "green":
	        color = c_green;
	        break;
	    case "lime":
	        color = c_lime;
	        break;
	    case "ltgray":
	        color = c_ltgray;
	        break;
	    case "maroon":
	        color = c_maroon;
	        break;
	    case "navy":
	        color = c_navy;
	        break;
	    case "olive":
	        color = c_olive;
	        break;
	    case "orange":
	        color = c_orange;
	        break;
	    case "purple":
	        color = c_purple;
	        break;
	    case "red":
	        color = c_red;
	        break;
	    case "silver":
	        color = c_silver;
	        break;
	    case "teal":
	        color = c_teal;
	        break;
	    case "white":
	        color = c_white;
	        break;
	    case "yellow":
	        color = c_yellow;
	        break;
	}
	return color;


}
