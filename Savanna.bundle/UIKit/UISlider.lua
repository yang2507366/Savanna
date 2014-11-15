require "UIView"

class(UISlider, UIView);

function UISlider:create()
    self = self:get(newObjCObject("UISlider"));
    self.targetEvent = UITargetEvent:create(self, math::bitLeftshift(1, 12));
    
    return self;
end

function UISlider:dealloc()
    if self.targetEvent then
        self.targetEvent:removeDelegate();
    end
    super:dealloc();
end

function UISlider:event(event)
    if event == math::bitLeftshift(1, 12) then
        self:valueDidChange();
    end
end

function UISlider:valueDidChange()--[[event]]
    
end