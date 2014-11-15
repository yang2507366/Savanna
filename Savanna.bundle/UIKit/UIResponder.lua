require "Object"
require "CommonUtils"

class(UIResponder);

function UIResponder:canPerformAction(actionName, sender)
    return "nil";
end

function UIResponder:dealloc()
    UIResponderEventProxyTable[self:id()] = nil;
    super:dealloc();
end

function UIResponder:get(objectId)
    self = super:get(objectId);
    UIResponderEventProxyTable[self:id()] = self;
    
    return self;
end

UIResponderEventProxyTable = {};

function UIResponder_canPerformAction(objectId, actionName, senderId)
    local tmp = UIResponderEventProxyTable[objectId];
    if tmp then
        local can = tmp:canPerformAction(actionName, nil);
        if can ~= "nil" then
            return toObjCBool(can);
        end
    end
    return "nil";
end