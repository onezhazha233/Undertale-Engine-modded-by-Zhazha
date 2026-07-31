function json_format(json_string){
    var indent = 0;
    var formatted = "";
    var in_string = false;

    for (var i = 1; i <= string_length(json_string); i++){
        var charr = string_char_at(json_string, i);

        // 检查是否在字符串内
        if(charr == "\"" && (i == 1 || string_char_at(json_string, i - 1) != "\\")){
            in_string = !in_string;
        }

        // 如果不在字符串内，处理格式化
        if(!in_string){
            if(charr == "{"){
                formatted += charr + "\n" + string_repeat("  ", indent + 1);
                indent++;
            }else if(charr == "}"){
                indent--;
                formatted += "\n" + string_repeat("  ", indent) + charr;
            }else if(charr == "["){
                formatted += charr + "\n" + string_repeat("  ", indent + 1);
                indent++;
            }else if(charr == "]"){
                indent--;
                formatted += "\n" + string_repeat("  ", indent) + charr;
            }else if(charr == ","){
                formatted += charr + "\n" + string_repeat("  ", indent);
            }else {
                formatted += charr;
            }
        }else {
            formatted += charr; // 在字符串内直接添加字符
        }
    }
    
    return formatted;
}