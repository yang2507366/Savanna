require "Object"
require "NotificationObserver"
require "AppContext"

class(AbstractDelegate);

AbstractDelegate.EventProxyTable = {};

function AbstractDelegate:initProxyTable(proxyTable)
    self:bind();
    self.notificationObserver = NotificationObserver:create();
    local bself = self;
    function self.notificationObserver:didReceive(object, userInfo)
        local appId = StringUtils.toString(object);
        if StringUtils.equals(appId, AppContext.current()) then
            bself:appWillDestory();
        end
    end
    self.notificationObserver:observe("kAppWillBeDestoryNotification");
    self.proxyTable = proxyTable;
end

function AbstractDelegate:setSourceObject(sourceObject)
    rawset(self, "_sourceObject", sourceObject);
end

function AbstractDelegate:sourceObject()
    return rawget(self, "_sourceObject");
end

function AbstractDelegate:appWillDestory()
    self:removeDelegate();
end

function AbstractDelegate:removeDelegate()
    
end

function AbstractDelegate:dealloc()
    self:removeDelegate();
    self:unbind();
    super:dealloc();
end

function AbstractDelegate:bind()
    AbstractDelegate.EventProxyTable[self:id()] = self;
end

function AbstractDelegate:unbind()
    AbstractDelegate.EventProxyTable[self:id()] = nil;
end

function AbstractDelegate.delegateForBindedId(bindedId)
    return AbstractDelegate.EventProxyTable[bindedId];
end