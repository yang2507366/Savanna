require "Object"
require "AppContext"
require "NSDictionary"

class(NotificationObserver, Object);

function NotificationObserver:create()
    self = self:get(runtime::invokeClassMethod("LINotificationObserver", "create:", AppContext.current()));
    NotificationObserverEventProxyTable[self:id()] = self;
    return self;
end

function NotificationObserver:dealloc()
    NotificationObserverEventProxyTable[self:id()] = nil;
    super:dealloc();
end

function NotificationObserver:observe(notificationName)
    self.notificationName = notificationName;
    runtime::invokeMethod(self:id(), "setNotificationName:func:", self.notificationName, "NotificationObserver_notification");
end

function NotificationObserver:cancel()
    runtime::invokeMethod(self:id(), "setNotificationName:func:", "", "");
end

-- event
function NotificationObserver:didReceive(object, userInfo)--[[event]]
    
end

-- event proxy
NotificationObserverEventProxyTable = {};

function NotificationObserver_notification(noId, objectId, userInfoId)
    local no = NotificationObserverEventProxyTable[noId];
    if no then
        local object = nil;
        if string.len(objectId) ~= 0 then
            object = Object:get(objectId);
        end
        local userInfo = nil;
        if string.len(userInfoId) then
            userInfo = NSDictionary:get(userInfoId);
        end
        no:didReceive(object, userInfo);
    end
end