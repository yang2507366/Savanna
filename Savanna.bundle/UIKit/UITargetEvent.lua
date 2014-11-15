require "AppContext"
require "AbstractDelegate"

class(UITargetEvent, AbstractDelegate);

function UITargetEvent:create(target, event)
    self = self:get(runtime::invokeClassMethod("LITargetEvent", "create:", AppContext.current()));
    self:setSourceObject(target);
    self:initProxyTable(nil);
    runtime::invokeClassMethod("LITargetEvent", "sourceObject:addTarget:event:", self:sourceObject():id(), self:id(), event);
    
    return self;
end

function UITargetEvent:removeDelegate()
    super:removeDelegate();
    runtime::invokeClassMethod("LITargetEvent", "sourceObject:removeTarget:", self:sourceObject():id(), self:id());
end

function UITargetEvent:initProxyTable(proxyTable)
    super:initProxyTable(proxyTable);
    runtime::invokeMethod(self:id(), "setEventDidPerform:", "UITargetEvent_eventDidPerform");
end

function UITargetEvent_eventDidPerform(targetEventId, event)
    local targetEvent = AbstractDelegate.delegateForBindedId(targetEventId);
    if targetEvent then
        targetEvent:sourceObject():event(tonumber(event));
    end
end