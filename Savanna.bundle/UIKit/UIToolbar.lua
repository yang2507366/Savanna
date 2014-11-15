require "UIView"

class(UIToolbar, UIView);

function UIToolbar:create()
    return self:get(newObjCObject(UIToolbar));
end

function UIToolbar:setItems(items)
    runtime::invokeMethod(self:id(), "setItems:", items:id());
end

function UIToolbar:barStyle()
    return tonumber(runtime::invokeMethod(self:id(), "barStyle"));
end

function UIToolbar:setBarStyle(barStyle)
    runtime::invokeMethod(self:id(), "setBarStyle:", barStyle);
end

function UIToolbar:setTintColor(color)
    runtime::invokeMethod(self:id(), "setTintColor:", color:id());
end

function UIToolbar:tintColor()
    return UIColor:get(runtime::invokeMethod(self:id(), "tintColor"));
end