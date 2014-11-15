require "Object"

class(UIFont, Object);

-- constructor
function UIFont:create(fontSize, bold--[[option]])
    local fontId = nil;
    if bold ~= nil and bold then
        fontId = runtime::invokeClassMethod("UIFont", "boldSystemFontOfSize:", fontSize);
    else
        fontId = runtime::invokeClassMethod("UIFont", "systemFontOfSize:", fontSize);
    end
    
    return self:get(fontId);
end

-- instance methods
function UIFont:lineHeight()
    return tonumber(runtime::invokeMethod(self:id(), "lineHeight"));
end