require "Object"
require "NSArray"

class(NSDictionary, Object);

function NSDictionary:objectForKey(key)
    local objId = runtime::invokeMethod(self:id(), "objectForKey:", key);
    if isObjCObject(objId) then
        return Object:get(objId);
    else
        return objId;
    end
end

function NSDictionary:allKeys()
    local arrId = runtime::invokeMethod(self:id(), "allKeys");
    return NSArray:get(arrId);
end

function NSDictionary:count()
    return tonumber(runtime::invokeMethod(self:id(), "count"));
end