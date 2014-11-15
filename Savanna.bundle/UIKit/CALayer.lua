require "Object"
require "UIColor"

class(CALayer);

function CALayer:cornerRadius()
    return tonumber(runtime::invokeMethod(self:id(), "cornerRadius"));
end

function CALayer:setCornerRadius(cornerRadius)
    runtime::invokeMethod(self:id(), "setCornerRadius:", cornerRadius);
end

function CALayer:setShadowColor(color)
    runtime::invokeClassMethod("LICALayer", "setShadowColor:target:", color:id(), self:id());
end

function CALayer:setBorderColor(color)
    runtime::invokeClassMethod("LICALayer", "setBorderColor:target:", color:id(), self:id());
end

function CALayer:setBackgroundColor(color)
    runtime::invokeClassMethod("LICALayer", "setBackgroundColor:target:", color:id(), self:id());
end

function CALayer:shadowColor()
    return UIColor:get(runtime::invokeClassMethod("LICALayer", "shadowColorWithTarget:", self:id()));
end

function CALayer:borderColor()
    return UIColor:get(runtime::invokeClassMethod("LICALayer", "borderColorWithTarget:", self:id()));
end

function CALayer:backgroundColor()
    return UIColor:get(runtime::invokeClassMethod("LICALayer", "backgroundColorWithTarget:", self:id()));
end

function CALayer:shadowOffset()
    return unpackCStruct(runtime::invokeMethod(self:id(), "shadowOffset"));
end

function CALayer:setShadowOffset(width, height)
    runtime::invokeMethod(self:id(), "setShadowOffset:", toCStruct(width, height));
end

function CALayer:shadowOpacity()
    return tonumber(runtime::invokeMethod(self:id(), "shadowOpacity"));
end

function CALayer:setShadowOpacity(shadowOpacity)
    runtime::invokeMethod(self:id(), "setShadowOpacity:", shadowOpacity);
end

function CALayer:shadowRadius()
    return tonumber(runtime::invokeMethod(self:id(), "shadowRadius"));
end

function CALayer:setShadowRadius(shadowRadius)
    runtime::invokeMethod(self:id(), "setShadowRadius:", shadowRadius);
end

function CALayer:shouldRasterize()
    return toLuaBool(runtime::invokeMethod(self:id(), "shouldRasterize"));
end

function CALayer:setShouldRasterize(shouldRasterize)
    runtime::invokeMethod(self:id(), "setShouldRasterize:", toObjCBool(shouldRasterize));
end

