require "UIView"
require "UIColor"

class(UIActivityIndicatorView, UIView);

function UIActivityIndicatorView:create(style)
    self = self:get(newObjCObject("UIActivityIndicatorView"));
    self:setActivityIndicatorViewStyle(style);
    return self;
end

function UIActivityIndicatorView:hidesWhenStopped()
    return toLuaBool(runtime::invokeMethod(self:id(), "hidesWhenStopped"));
end

function UIActivityIndicatorView:setHidesWhenStopped(hidesWhenStopped)
    runtime::invokeMethod(self:id(), "setHidesWhenStopped:", toObjCBool(hidesWhenStopped));
end

function UIActivityIndicatorView:color()
    return UIColor:get(runtime::invokeMethod(self:id(), "color"));
end

function UIActivityIndicatorView:setColor(color)
    runtime::invokeMethod(self:id(), "setColor:", color:id());
end

function UIActivityIndicatorView:activityIndicatorViewStyle()
    return tonumber(runtime::invokeMethod(self:id(), "activityIndicatorViewStyle"));
end

function UIActivityIndicatorView:setActivityIndicatorViewStyle(style)
    runtime::invokeMethod(self:id(), "setActivityIndicatorViewStyle:", style);
end

function UIActivityIndicatorView:isAnimating()
    return toLuaBool(runtime::invokeMethod(self:id(), "isAnimating"));
end

function UIActivityIndicatorView:startAnimating()
    runtime::invokeMethod(self:id(), "startAnimating");
end

function UIActivityIndicatorView:stopAnimating()
    runtime::invokeMethod(self:id(), "stopAnimating");
end