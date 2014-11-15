require "AbstractDelegate"
require "AppContext"

class(NSMutableArrayComparator, AbstractDelegate);

function NSMutableArrayComparator:create(array)
    self = self:get(runtime::invokeClassMethod("LIMutableArrayComparator", "create:", AppContext.current()));
    runtime::invokeMethod(self:id(), "set_comparator", "NSMutableArrayComparator_comparator");
    runtime::invokeMethod(self:id(), "set_complete", "NSMutableArrayComparator_complete");
    NSMutableArrayComparatorEventProxyTable[self:id()] = self;
    self:setSourceObject(array);
    self:initProxyTable(nil);
    return self;
end

function NSMutableArrayComparator:dealloc()
    NSMutableArrayComparatorEventProxyTable[self:id()] = nil;
    super:dealloc();
end

function NSMutableArrayComparator:sortUsingComparator(comparator, complete)
    self.__comparator = comparator;
    self.__complete = complete;
    runtime::invokeMethod(self:id(), "sortWithArray:", self:sourceObject():id());
end

NSMutableArrayComparatorEventProxyTable = {};

function NSMutableArrayComparator_comparator(objId, obj1Id, obj2Id)
    local comparator = NSMutableArrayComparatorEventProxyTable[objId];
    if comparator then
        return comparator.__comparator(obj1Id, obj2Id);
    end
    return 0;
end

function NSMutableArrayComparator_complete(objId)
    local comparator = NSMutableArrayComparatorEventProxyTable[objId];
    if comparator and comparator.__complete then
        comparator.__complete();
    end
end