require "AutoreleasePool"
require "CommonUtils"

Object = {};
Object.__index = Object;
Object.__classname = "Object";
--class(Object);

function Object:get(objectId--[[option]])
    local obj = {};
    obj.__propertylist = {};
    setmetatable(obj, self);
    function self.__newindex(t, k, v)
        --print(type(v).."\t"..k..","..tostring(v));
        if type(v) == "table" and v.retain then
            t:setProperty(k, v);
        else
            if v == nil then
                local plist = rawget(t, "__propertylist");
                local ev = rawget(plist, k);
                if ev then
                    t:setProperty(k, v);
                end
            else
                rawset(t, k, v);
            end
        end
    end
    function self.__index(t, k)
        local v = rawget(t, k);
        local metatable = getmetatable(t);
        if v == nil and metatable then
            v = metatable[k];
        end
        if v == nil then
            local plist = rawget(t, "__propertylist");
            if plist ~= nil then
                v = rawget(plist, k);
            end
        end
        return v;
    end
    obj.__objectid = objectId;
    if objectId == nil or not isObjCObject(objectId) then
        obj.__retaincount = 1;
    end
    obj:init();
    return obj:autorelease();
end

function Object:new()
    return self:get();
end

function Object:init()
end

function Object:dealloc()
    for k, v in pairs(self.__propertylist) do
        if v and type(v) == "table" and v.id then
            v:release();
        end
    end
    self.__objectid = nil;
end

-- instance methods
function Object:id()
    return self.__objectid;
end

function Object:release()
    if self.__retaincount then
        self.__retaincount = self.__retaincount - 1;
        if self.__retaincount == 0 then
            self:dealloc();
        end
    else
        local objectid = self:id()
        if self:retainCount() == 1 then
            self:dealloc();
        end
        runtime::releaseObject(objectid);
    end
end

function Object:retain()
    if self.__retaincount then
        self.__retaincount = self.__retaincount + 1;
    else
        runtime::retainObject(self:id());
    end
    return self;
end

function Object:retainCount()
    if self.__retaincount then
        return self.__retaincount;
    end
    return runtime::objectRetainCount(self:id());
end

function Object:equals(obj)
    if obj.id then
        local sb, se = string.find(self:id(), obj:id());
        if sb and se then
            return se == string.len(self:id());
        end
    end
    return false;
end

function Object:classname()
    return self.__classname;
end

function Object:autorelease()
    local success = _autorelease_pool_addObject(self);
    if success == false then
        print("error, autorelease failed, no pool around");
    end
    return self;
end

function Object:hash()
    return runtime::invokeMethod(self:id(), "hash");
end

function Object:objCClassName()
    return runtime::objectClassName(self:id());
end

function Object.objectIsKindOfClass(objId, className)
    return toLuaBool(runtime::invokeClassMethod("LIRuntimeUtils", "object:isKindOfClass:", objId, className));
end

function Object:isKindOfClass(className)
    return self.objectIsKindOfClass(self:id(), className);
end

function Object:objCDescription()
    return runtime::objectDescription(self:id());
end

function Object:setAssociatedObject(obj)
    if obj.id then
        obj = obj:id();
    end
    runtime::invokeClassMethod("LIRuntimeUtils", "setAssociatedObjectFor:key:value:policy:override", self:id(), "", obj, 1, toObjCBool(true));
end

function Object:associatedObject()
    local objId = runtime::invokeClassMethod("LIRuntimeUtils", "getAssociatedObjectWithAppId:forObject:key:", AppContext.current(), self:id(), "");
    return Object:new(objId);
end

function Object:removeAssociatedObject()
    runtime::invokeClassMethod("LIRuntimeUtils", "removeAssociatedObjectsForObject:", self:id());
end

function Object:setProperty(k, v)
    if v then
        v:retain();
    end
    local oldValue = self.__propertylist[k];
    if oldValue then
        oldValue:release();
        oldValue = nil;
    end
    self.__propertylist[k] = v;
end

