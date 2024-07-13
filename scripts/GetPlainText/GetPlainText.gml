///@arg text
function GetPlainText(){
	var TEXT = argument[0];
	
	var len = string_length(TEXT);
    var result = "";
    var inside_braces = false;

    for(i=0;i<=len;i++){
        var charr = string_char_at(TEXT,i);

        if(charr = "{"){
            inside_braces = true;
        }
		else if(charr = "}"){
            inside_braces = false;
        }
		if(inside_braces = 0){
            result += charr;
        }
    }

    return string_replace_all(result,"}","");
}
//返回不带命令的文本，返回的结果中不会含有大括号，如果要使用该函数，请保证大括号成对出现