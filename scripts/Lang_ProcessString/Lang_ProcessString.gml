///@arg text
function Lang_ProcessString(TEXT){
	var replace_key = ["sleep"];
	
	for(var i=0;i<array_length(replace_key);i+=1){
		var KEY = replace_key[i];
		TEXT = string_replace_all(TEXT,Lang_GetLayout("replace."+KEY+".0"),Lang_GetLayout("replace."+KEY+".1"));
	}
	
	return TEXT;
	//注意匹配词的内容和顺序防止被反复替换，如先后匹配“a”和“ab”的顺序的结果肯定是不一样的
	//不过真的有人对它有除了停顿之外的需求吗？
}