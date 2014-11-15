require "UIView"
require "UITargetEvent"

class(UISegmentedControl, UIView);

function UISegmentedControl:create(items)
    if items and items.id then
        items = items:id();
    end
    self = self:get(runtime::createObject("UISegmentedControl", "initWithItems:", items));
    self.targetEvent = UITargetEvent:create(self, math::bitLeftshift(1, 12));
    return self;
end

function UISegmentedControl:dealloc()
    if self.targetEvent then
        self.targetEvent:removeDelegate();
    end
    super:dealloc();
end

function UISegmentedControl:event(event)
    if event == math::bitLeftshift(1, 12) then
        self:itemDidChange();
    end
end

function UISegmentedControl:itemDidChange()--[[event]]

end