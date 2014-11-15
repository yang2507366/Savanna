require "Object"
require "AppContext"
require "CommonUtils"

class(UIGestureRecognizer, Object);

UITapGestureRecognizer = "UITapGestureRecognizer";
UIPinchGestureRecognizer = "UIPinchGestureRecognizer";
UIRotationGestureRecognizer = "UIRotationGestureRecognizer";
UISwipeGestureRecognizer = "UISwipeGestureRecognizer";
UIPanGestureRecognizer = "UIPanGestureRecognizer";
UILongPressGestureRecognizer = "UILongPressGestureRecognizer";

function UIGestureRecognizer:create(gestureRecognizerClassName)
    self = self:get(runtime::invokeClassMethod("LIGestureRecognizer", "create:className:", AppContext.current(), gestureRecognizerClassName));
    
    runtime::invokeClassMethod("LIGestureRecognizer", "setCallbackFuncNameForGR:funcName:", self:id(), "UIGestureRecognizer_action");
    UIGestureRecognizerEventProxyTable[self:id()] = self;
    
    return self;
end

function UIGestureRecognizer:dealloc()
    UIGestureRecognizerEventProxyTable[self:id()] = nil;
    self:removeAssociatedObject();
    super:dealloc();
end

-- instance methods
function UIGestureRecognizer:state()
    return tonumber(runtime::invokeMethod(self:id(), "state"));
end

function UIGestureRecognizer:view()
    local objId = runtime::invokeMethod(self:id(), "view");
    return UIView:get(objId);
end

function UIGestureRecognizer:locationInView(view)
    return unpackCStruct(runtime::invokeMethod(self:id(), "locationInView:", view:id()));
end

-- event
function UIGestureRecognizer:didPerform()--[[event]]
    
end

UIGestureRecognizerEventProxyTable = {};

function UIGestureRecognizer_action(grId)
    local obj = UIGestureRecognizerEventProxyTable[grId];
    if obj then
        obj:didPerform();
    end
end