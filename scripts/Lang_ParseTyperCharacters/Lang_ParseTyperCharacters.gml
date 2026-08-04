///@arg characters_struct
function Lang_ParseTyperCharacters(SRC) {
	var OUT={
		offsets: {},
		offsets_y: {},
		widths: {},
		offsets_default: undefined,
		offsets_y_default: undefined
	};
	if(!is_struct(SRC)){
		return OUT;
	}

	if(variable_struct_exists(SRC,"offsets_x_default")&&is_array(SRC[$ "offsets_x_default"])){
		var DEF=SRC[$ "offsets_x_default"];
		if(array_length(DEF)>=3){
			OUT.offsets_default=[real(DEF[0]),real(DEF[1]),real(DEF[2])];
		}
	}

	if(variable_struct_exists(SRC,"offsets_x")&&is_array(SRC[$ "offsets_x"])){
		var ARR=SRC[$ "offsets_x"];
		var LEN=array_length(ARR);
		var I=0;
		while(I+3<LEN){
			var KEY=ARR[I];
			var AFTER=real(ARR[I+1]);
			var BEFORE=real(ARR[I+2]);
			var AFTER_SAME=real(ARR[I+3]);
			I+=4;
			if(!is_string(KEY)||KEY==""){
				continue;
			}
			if(string_length(KEY)==2){
				var C0=ord(string_char_at(KEY,1));
				var C1=ord(string_char_at(KEY,2));
				if(C0>C1){
					var TMP=C0;C0=C1;C1=TMP;
				}
				for(var C=C0;C<=C1;C+=1){
					var TRIP=[AFTER,BEFORE,AFTER_SAME];
					OUT.offsets[$ chr(C)]=TRIP;
					OUT.offsets[$ ("#"+string(C))]=TRIP;
				}
			}else{
				var TRIP2=[AFTER,BEFORE,AFTER_SAME];
				OUT.offsets[$ KEY]=TRIP2;
				OUT.offsets[$ ("#"+string(ord(string_char_at(KEY,1))))]=TRIP2;
			}
		}
	}

	if(variable_struct_exists(SRC,"offsets_y_default")&&is_array(SRC[$ "offsets_y_default"])){
		var DEFY=SRC[$ "offsets_y_default"];
		if(array_length(DEFY)>=2){
			OUT.offsets_y_default=[real(DEFY[0]),real(DEFY[1])];
		}
	}

	if(variable_struct_exists(SRC,"offsets_y")&&is_array(SRC[$ "offsets_y"])){
		var ARRY=SRC[$ "offsets_y"];
		var LENY=array_length(ARRY);
		var IY=0;
		while(IY+2<LENY){
			var KEYY=ARRY[IY];
			var DOWN=real(ARRY[IY+1]);
			var UP=real(ARRY[IY+2]);
			IY+=3;
			if(!is_string(KEYY)||KEYY==""){
				continue;
			}
			if(string_length(KEYY)==2){
				var CY0=ord(string_char_at(KEYY,1));
				var CY1=ord(string_char_at(KEYY,2));
				if(CY0>CY1){
					var TMPY=CY0;CY0=CY1;CY1=TMPY;
				}
				for(var CY=CY0;CY<=CY1;CY+=1){
					var PAIRY=[DOWN,UP];
					OUT.offsets_y[$ chr(CY)]=PAIRY;
					OUT.offsets_y[$ ("#"+string(CY))]=PAIRY;
				}
			}else{
				var PAIRY2=[DOWN,UP];
				OUT.offsets_y[$ KEYY]=PAIRY2;
				OUT.offsets_y[$ ("#"+string(ord(string_char_at(KEYY,1))))]=PAIRY2;
			}
		}
	}

	if(variable_struct_exists(SRC,"widths")&&is_array(SRC[$ "widths"])){
		var WARR=SRC[$ "widths"];
		var WLEN=array_length(WARR);
		var WI=0;
		while(WI+1<WLEN){
			var WKEY=WARR[WI];
			var WVAL=real(WARR[WI+1]);
			WI+=2;
			if(is_string(WKEY)&&WKEY!=""){
				OUT.widths[$ WKEY]=WVAL;
			}
		}
	}

	return OUT;
}
