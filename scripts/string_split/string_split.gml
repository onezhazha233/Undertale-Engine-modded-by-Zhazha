/// @function string_split(str, delimiter)
/// @description 将字符串按指定分隔符拆分为数组
/// @param {String} str 要拆分的源字符串
/// @param {String} delimiter 分隔符
/// @return {Array<String>} 拆分后的字符串数组

function string_split(_str, _delimiter) {
    var _result = [];
    var _del_len = string_length(_delimiter);
    
    // 边界情况处理：如果分隔符为空，直接返回原字符串组成的单元素数组
    if (_del_len == 0) {
        array_push(_result, _str);
        return _result;
    }
    
    var _pos = string_pos(_delimiter, _str);
    
    // 循环查找分隔符
    while (_pos > 0) {
        // 截取分隔符左侧的内容并放入数组
        var _part = string_copy(_str, 1, _pos - 1);
        array_push(_result, _part);
        
        // 移除已截取的部分和分隔符本身
        _str = string_delete(_str, 1, _pos + _del_len - 1);
        
        // 查找下一个分隔符位置
        _pos = string_pos(_delimiter, _str);
    }
    
    // 将剩余的最后一个字符串压入数组
    array_push(_result, _str);
    
    return _result;
}