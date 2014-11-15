require "Object"
require "AppContext"
require "CommonUtils"

class(UIPopoverController, Object);

function UIPopoverController:create(vc)
    self = self:get(runtime::invokeClassMethod("LIPopoverController", "create:contentViewController:", AppContext.current(), vc:id()));
    
    UIPopoverControllerEventProxyTable[self:id()] = self;
    runtime::invokeMethod(self:id(), "setShouldDismiss:", "UIPopoverController_shouldDismiss");
    runtime::invokeMethod(self:id(), "setDidDismiss:", "UIPopoverController_didDismiss");

    return self;
end

function UIPopoverController:dealloc()
    UIPopoverControllerEventProxyTable[self:id()] = nil;
    super:dealloc();
end

function UIPopoverController:dismiss(animated--[[option]])
    runtime::invokeMethod(self:id(), "dismissPopoverAnimated:", toObjCBool(animated));
end

function UIPopoverController:presentFromBarButtonItem(barButtonItem, arrowDirection, animated--[[option]])
    runtime::invokeMethod(self:id(), "presentPopoverFromBarButtonItem:permittedArrowDirections:animated:", barButtonItem:id(), arrowDirection, toObjCBool(animated));
end

function UIPopoverController:popoverContentSize()
    return unpackCStruct(runtime::invokeMethod(self:id(), "popoverContentSize"));
end

function UIPopoverController:setPopoverContentSize(width, height)
    runtime::invokeMethod(self:id(), "setPopoverContentSize:", width..","..height);
end

function UIPopoverController:shouldDismiss()--[[event]]
    return true;
end

function UIPopoverController:didDismiss()--[[event]]

end

function UIPopoverController:popoverVisible()
    return toLuaBool(runtime::invokeMethod(self:id(), "isPopoverVisible"));
end

UIPopoverControllerEventProxyTable = {};

function UIPopoverController_shouldDismiss(objId)
    local obj = UIPopoverControllerEventProxyTable[objId];
    if obj then
        return toObjCBool(obj:shouldDismiss());
    end
    return toObjCBool(true);
end

function UIPopoverController_didDismiss(objId)
    local obj = UIPopoverControllerEventProxyTable[objId];
    if obj then
        obj:didDismiss();
    end
end