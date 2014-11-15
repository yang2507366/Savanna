require "Object"
require "CommonUtils"

class(NSArray, Object);

function NSArray:read(path)
    local arrId = runtime::invokeClassMethod("NSArray", "arrayWithContentsOfFile:", path);
    if string.len(arrId) ~= 0 then
        return self:get(arrId);
    end
    return nil;
end

function NSArray:arrayWithObject(obj)
    return self:get(runtime::invokeClassMethod("NSArray", "arrayWithObject:", obj:id()));
end

function NSArray:objectAtIndex(index)
    local objId = runtime::invokeMethod(self:id(), "objectAtIndex:", index);
    if isObjCObject(objId) then
        return Object:get(objId);
    else
        return objId;
    end
end

function NSArray:count()
    return tonumber(runtime::invokeMethod(self:id(), "count"));
end

function NSArray:writeToFile(path)
    runtime::invokeMethod(self:id(), "writeToFile:atomically:", path, toObjCBool(false));
end