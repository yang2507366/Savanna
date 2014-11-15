require "Object"
require "UIBarButtonItem"

class(UINavigationItem, Object);

-- constructor
function UINavigationItem:create()
    self = self:get(runtime::createObject("UINavigationItem", "init"));
    
    return self;
end

function UINavigationItem:dealloc()
    super:dealloc();
end

-- instance methods
function UINavigationItem:setTitle(title)
    runtime::invokeMethod(self:id(), "setTitle:", title);
end

function UINavigationItem:leftBarButtonItem()
    local ri = runtime::invokeMethod(self:id(), "leftBarButtonItem");
    local bi = UIBarButtonItem:get(ri);
    return bi;
end

function UINavigationItem:rightBarButtonItem()
    local ri = runtime::invokeMethod(self:id(), "rightBarButtonItem");
    local bi = UIBarButtonItem:get(ri);
    return bi;
end

function UINavigationItem:setRightBarButtonItem(buttonItem, animated--[[option]])
    animated = toObjCBool(animated);
    if buttonItem then
        runtime::invokeMethod(self:id(), "setRightBarButtonItem:animated:", buttonItem:id(), animated);
    else
        runtime::invokeMethod(self:id(), "setRightBarButtonItem:animated:");
    end
end

function UINavigationItem:setLeftBarButtonItem(buttonItem, animated--[[option]])
    animated = toObjCBool(animated);
    if buttonItem then
        runtime::invokeMethod(self:id(), "setLeftBarButtonItem:animated:", buttonItem:id(), animated);
    else
        runtime::invokeMethod(self:id(), "setLeftBarButtonItem:animated:");
    end
end