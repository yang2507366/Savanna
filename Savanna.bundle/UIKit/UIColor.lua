require "Object"

class(UIColor, Object);

-- constructor
function UIColor:create(red, green, blue, alpha--[[option]])
    if not alpha then
        alpha = 1;
    end
    local colorId = runtime::invokeClassMethod("UIColor", "colorWithRed:green:blue:alpha:",
                                               tostring(red / 255), tostring(green / 255), tostring(blue / 255), tostring(alpha));
    self = self:get(colorId);
    
    return self;
end

function UIColor.clearColor()
    return UIColor:get(runtime::invokeClassMethod("UIColor", "clearColor"));
end