///@arg path
///@arg default*
function Lang_GetTyper(PATH, DEF=undefined) {
	var MAN=Lang_GetManifest(Language());
	if(!is_struct(MAN)){
		return DEF;
	}

	var ROOT=MAN[$ "typer"];
	if(!is_struct(ROOT)){
		return DEF;
	}

	var PARTS=string_split(PATH,".");
	var CUR=ROOT;
	for(var i=0;i<array_length(PARTS);i+=1){
		var KEY=PARTS[i];
		if(!is_struct(CUR)||!variable_struct_exists(CUR,KEY)){
			return DEF;
		}
		CUR=CUR[$ KEY];
	}

	return CUR;
}
