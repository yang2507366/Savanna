require "UIView"

class(UIStepper, UIView);

function UIStepper:create()
    self = self:get(newObjCObject("UIStepper"));
    self.targetEvent = UITargetEvent:create(self, math::bitLeftshift(1, 12));
    
    return self;
end

function UIStepper:dealloc()
    if self.targetEvent then
        self.targetEvent:removeDelegate();
    end
    super:dealloc();
end

function UIStepper:event(event)
    if event == math::bitLeftshift(1, 12) then
        self:valueDidChange();
    end
end

function UIStepper:valueDidChange()--[[event]]
    
end