require "UIView"
require "UIFont"
require "AppContext"

class(UILabel, UIView);

-- constructor
function UILabel:create(text--[[option]])
    if text == nil then
        text = "";
    end
    self = self:get(runtime::invokeClassMethod("LILabel", "create:", AppContext.current()));
    self:setText(text);
    
    return self;
end

-- instance methods
function UILabel:setText(text)
    runtime::invokeMethod(self:id(), "setText:", text);
end

function UILabel:text()
    local strId = runtime::invokeMethod(self:id(), "text");
    return strId;
end

function UILabel:setFont(font)
    runtime::invokeMethod(self:id(), "setFont:", font:id());
end

function UILabel:font()
    local fontId = runtime::invokeMethod(self:id(), "font");
    return UIFont:get(fontId);
end

function UILabel:setNumberOfLines(numberOfLines)
    runtime::invokeMethod(self:id(), "setNumberOfLines:", numberOfLines);
end

function UILabel:setTextColor(color)
    runtime::invokeMethod(self:id(), "setTextColor:", color:id());
end

function UILabel:textColor()
    return UIColor:get(runtime::invokeMethod(self:id(), "textColor"));
end

function UILabel:setTextAlignment(alignment)
    runtime::invokeMethod(self:id(), "setTextAlignment:", alignment);
end

function UILabel:textAlignment()
    tonumber(runtime::invokeMethod(self:id(), "textAlignment"));
end

function UILabel:adjustsFontSizeToFitWidth()
    return toLuaBool(runtime::invokeMethod(self:id(), "adjustsFontSizeToFitWidth"));
end

function UILabel:setAdjustsFontSizeToFitWidth(adjusts)
    runtime::invokeMethod(self:id(), "setAdjustsFontSizeToFitWidth:", toObjCBool(adjusts));
end