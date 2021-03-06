require "CommonUtils"
require "NSData"

class(StringUtils);

function StringUtils.appendingPathComponent(path, component)
    return runtime::invokeClassMethod("LIStringUtils", "appendingPath:component:", path, component);
end

function StringUtils.md5(str)
    return runtime::invokeClassMethod("LIStringUtils", "md5ForString:", str);
end

function StringUtils.removeUnicodeCharsFromString(str)
    return runtime::invokeClassMethod("LIStringUtils", "removeAllUnicode:", str);
end

function StringUtils.trim(str)
    return runtime::invokeClassMethod("LIStringUtils", "trim:", str);
end

function StringUtils.hasPrefix(str, prefix)
    return toLuaBool(runtime::invokeClassMethod("LIStringUtils", "string:hasPrefix:", str, prefix));
end

function StringUtils.length(str)
    return tonumber(runtime::invokeClassMethod("LIStringUtils", "length:", str));
end

function StringUtils.equals(str1, str2)
    return toLuaBool(runtime::invokeClassMethod("LIStringUtils", "equals:with:", str1, str2));
end

function StringUtils.toString(str)
    if str.id then
        str = str:id();
    end
    return runtime::invokeClassMethod("LIStringUtils", "objectToString:", str);
end

function StringUtils.UTF8StringFromData(data)
    return runtime::invokeClassMethod("LIStringUtils", "UTF8StringFromData:", data:id());
end

function StringUtils.dataFromUTF8String(str)
    local dataId = runtime::invokeClassMethod("LIStringUtils", "dataFromUTF8String:", str);
    return NSData:get(dataId);
end

function StringUtils.find(str, matching, fromIndex--[[option]], reverse--[[option]])
    if fromIndex == nil then
        fromIndex = 0;
    end
    if reverse == nil then
        reverse = false;
    end
    return tonumber(runtime::invokeClassMethod("LIStringUtils", "find:matching:fromIndex:reverse", str, matching, fromIndex, toObjCBool(reverse)));
end

function StringUtils.substring(str, beginIndex, endIndex)
    return runtime::invokeClassMethod("LIStringUtils", "substring:beginIndex:endIndex:", str, beginIndex, endIndex);
end

function StringUtils.replace(str, matching, replacement, compareOptions--[[option]], beginIndex--[[option]], endIndex--[[option]])
    if compareOptions == nil then
        compareOptions = 1;
    end
    if beginIndex == nil then
        beginIndex = 0;
    end
    if endIndex == nil then
        endIndex = StringUtils.length(str);
    end
    return runtime::invokeClassMethod("LIStringUtils", "replace:matching:replacement:compareOptions:beginIndex:endIndex:", str, matching, replacement, compareOptions, beginIndex, endIndex);
end

function StringUtils.compare(str1, str2)
    return tonumber(string::invokeMethod(str1, "compare:", str2));
end

function StringUtils.sizeWithFont(str, font, constrainedToWidth, constrainedToHeight)
    return unpackCStruct(string::invokeMethod(str, "sizeWithFont:constrainedToSize:", font:id(), toCStruct(constrainedToWidth, constrainedToHeight)));
end
