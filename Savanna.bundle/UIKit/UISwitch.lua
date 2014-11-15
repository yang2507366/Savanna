require "UIView"

class(UISwitch, UIView);

function UISwitch:create()
    self = self:get(newObjCObject("UISwitch"));
    self.targetEvent = UITargetEvent:create(self, math::bitLeftshift(1, 12));
    
    return self;
end

function UISwitch:dealloc()
    if self.targetEvent then
        self.targetEvent:removeDelegate();
    end
    super:dealloc();
end

function UISwitch:event(event)
    if event == math::bitLeftshift(1, 12) then
        self:valueDidChange();
    end
end

function UISwitch:valueDidChange()--[[event]]
    
end

function UISwitch:on()
    return toLuaBool(runtime::invokeMethod(self:id(), "isOn"));
end

function UISwitch:setOn(on)
    runtime::invokeMethod(self:id(), "setOn:", toObjCBool(on));
end