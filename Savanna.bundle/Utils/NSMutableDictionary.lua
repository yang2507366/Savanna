require "NSDictionary"

class(NSMutableDictionary, NSDictionary);

function NSMutableDictionary:create()
    return self:get(runtime::invokeClassMethod("NSMutableDictionary", "dictionary"));
end

function NSMutableDictionary:setObjectForKey(obj, key)
    if obj.id ~= nil then
        obj = obj:id();
    end
    runtime::invokeMethod(self:id(), "setObject:forKey:", obj, key);
end