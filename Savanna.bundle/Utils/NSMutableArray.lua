require "NSArray"
require "AppContext"
require "NSMutableArrayComparator"

class(NSMutableArray, NSArray);

function NSMutableArray:create(srcArray--[[option]])
    self = self:get(runtime::invokeClassMethod("NSMutableArray", "array"));
    
    if srcArray then
        self:addObjectsFromArray(srcArray);
    end

    return self;
end

function NSMutableArray:read(path)
    local arrId = runtime::invokeClassMethod("NSMutableArray", "arrayWithContentsOfFile:", path);
    if string.len(arrId) ~= 0 then
        return self:create(NSArray:get(arrId));
    end
    return nil;
end

function NSMutableArray:addObject(obj)
    if obj.id ~= nil then
        obj = obj:id();
    end
    runtime::invokeMethod(self:id(), "addObject:", obj);
end

function NSMutableArray:addObjectsFromArray(arr)
    runtime::invokeMethod(self:id(), "addObjectsFromArray:", arr:id());
end

function NSMutableArray:insertObject(obj, index--[[option]])
    if obj.id ~= nil then
        obj = obj:id();
    end
    if not index then
        self:addObject(obj);
    else
        runtime::invokeMethod(self:id(), "insertObject:atIndex:", obj, index);
    end
end

function NSMutableArray:removeObject(obj)
    runtime::invokeMethod(self:id(), "removeObject:", obj);
end

function NSMutableArray:removeObjectAtIndex(index)
    runtime::invokeMethod(self:id(), "removeObjectAtIndex:", index);
end

function NSMutableArray:sortUsingComparator(comparatorFunction, completeFunction)
    if self.arrayComparator == nil then
        self.arrayComparator = NSMutableArrayComparator:create(self);
    end
    self.arrayComparator:sortUsingComparator(comparatorFunction, completeFunction);
end
