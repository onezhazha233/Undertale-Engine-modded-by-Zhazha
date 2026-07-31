function Lang_LoadList() {
	Lang_ClearList();

	var LIST=global._gmu_lang_list;
	var MANIFEST_MAP=global._gmu_lang_manifest;
	var ENTRIES=[];

	var _paths=[];
	var _exe=filename_dir(parameter_string(0));
	if(string_char_at(_exe,string_length(_exe))!="\\"&&string_char_at(_exe,string_length(_exe))!="/"){
		_exe+="/";
	}
	var _wd=working_directory;
	if(string_char_at(_wd,string_length(_wd))!="\\"&&string_char_at(_wd,string_length(_wd))!="/"){
		_wd+="/";
	}
	var _prog=program_directory;
	if(string_char_at(_prog,string_length(_prog))!="\\"&&string_char_at(_prog,string_length(_prog))!="/"){
		_prog+="/";
	}

	var _candidates=[_exe+"locale/",_wd+"locale/",_prog+"locale/"];
	for(var _ci=0;_ci<array_length(_candidates);_ci+=1){
		var _cand=_candidates[_ci];
		var _dup_path=false;
		for(var _pi=0;_pi<array_length(_paths);_pi+=1){
			if(_paths[_pi]==_cand){
				_dup_path=true;
				break;
			}
		}
		if(!_dup_path&&directory_exists(_cand)){
			array_push(_paths,_cand);
		}
	}

	global._gmu_lang_path=array_length(_paths)>0 ? _paths[0] : _exe+"locale/";

	for(var _root=0;_root<array_length(_paths);_root+=1){
		var _base=_paths[_root];
		var MANIFEST_FILES=[];
		var FILE=file_find_first(_base+"*.json",0);
		while(FILE!=""){
			array_push(MANIFEST_FILES,FILE);
			FILE=file_find_next();
		}
		file_find_close();

		for(var mi=0;mi<array_length(MANIFEST_FILES);mi+=1){
			var _fname=MANIFEST_FILES[mi];
			var _path=_base+_fname;
			if(!file_exists(_path)){
				continue;
			}
			var STR=Lang_LoadFileToString(_path);
			if(STR==""){
				continue;
			}
			var obj=json_parse(STR);
			if(!is_struct(obj)){
				continue;
			}
			var INFO=variable_struct_get(obj,"info");
			if(!is_struct(INFO)){
				continue;
			}
			var NAME=variable_struct_get(INFO,"ascii_name");
			if(!is_string(NAME)){
				continue;
			}
			if(ds_map_find_value(MANIFEST_MAP,NAME)!=undefined){
				continue;
			}
			if(!directory_exists(_base+NAME)){
				continue;
			}

			ds_map_add(MANIFEST_MAP,NAME,obj);
			ds_map_add(global._gmu_lang_root,NAME,_base);

			var ORDER=variable_struct_exists(INFO,"order") ? variable_struct_get(INFO,"order") : 9999;
			var ENTRY={};
			ENTRY[$ "name"]=NAME;
			ENTRY[$ "order"]=is_real(ORDER) ? ORDER : 9999;
			array_push(ENTRIES,ENTRY);
		}
	}

	array_sort(ENTRIES,function(a,b){ return a.order-b.order; });
	for(var i=0;i<array_length(ENTRIES);i+=1){
		ds_list_add(LIST,ENTRIES[i].name);
	}

	return !ds_list_empty(LIST);
}
