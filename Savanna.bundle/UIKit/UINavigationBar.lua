require "UIView"
require "UIColor"

class(UINavigationBar, UIView);

function UINavigationBar:create()
    self = self:get(runtime::createObject("UINavigationBar", "init"));
    
    return self;
end

function UINavigationBar:pushNavigationItem(naviItem, animated)
    runtime::invokeMethod(self:id(), "pushNavigationItem:animated:", naviItem:id(), toObjCBool(animated));
end

function UINavigationBar:popNavigationItem(animated)
    runtime::invokeMethod(self:id(), "popNavigationItemAnimated:", toObjCBool(animated));
end

function UINavigationBar:barStyle()
    return tonumber(runtime::invokeMethod(self:id(), "barStyle"));
end

function UINavigationBar:setBarStyle(barStyle)
    runtime::invokeMethod(self:id(), "setBarStyle:", barStyle);
end

function UINavigationBar:setTintColor(color)
    runtime::invokeMethod(self:id(), "setTintColor:", color:id());
end

function UINavigationBar:tintColor()
    return UIColor:get(runtime::invokeMethod(self:id(), "tintColor"));
end