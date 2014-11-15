require "UIView"
require "UIColor"
require "UITargetEvent"

class(UIPageControl, UIView);

function UIPageControl:create()
    self = self:get(newObjCObject("UIPageControl"));
    self.targetEvent = UITargetEvent:create(self, math::bitLeftshift(1, 12));
    self:setCurrentPageIndicatorTintColor(UIColor:create(255, 0, 0));
    self:setPageIndicatorTintColor(UIColor:create(0, 0, 0));
    return self;
end

function UIPageControl:dealloc()
    if self.targetEvent then
        self.targetEvent:removeDelegate();
    end
    super:dealloc();
end

function UIPageControl:currentPage()
    return tonumber(runtime::invokeMethod(self:id(), "currentPage"));
end

function UIPageControl:setCurrentPage(pageIndex)
    runtime::invokeMethod(self:id(), "setCurrentPage:", pageIndex);
end

function UIPageControl:numberOfPages()
    return tonumber(runtime::invokeMethod(self:id(), "numberOfPages"));
end

function UIPageControl:setNumberOfPages(nums)
    runtime::invokeMethod(self:id(), "setNumberOfPages:", nums);
end

function UIPageControl:currentPageIndicatorTintColor()
    return UIColor:get(runtime::invokeMethod(self:id(), "currentPageIndicatorTintColor"));
end

function UIPageControl:setCurrentPageIndicatorTintColor(color)
    runtime::invokeMethod(self:id(), "setCurrentPageIndicatorTintColor:", color:id());
end

function UIPageControl:pageIndicatorTintColor()
    return UIColor:get(runtime::invokeMethod(self:id(), "pageIndicatorTintColor"));
end

function UIPageControl:setPageIndicatorTintColor(color)
    runtime::invokeMethod(self:id(), "setPageIndicatorTintColor:", color:id());
end

function UIPageControl:defersCurrentPageDisplay()
    return toLuaBool(runtime::invokeMethod(self:id(), "defersCurrentPageDisplay"));
end

function UIPageControl:setDefersCurrentPageDisplay(defers)
    runtime::invokeMethod(self:id(), "setDefersCurrentPageDisplay:", toObjCBool(defers));
end

function UIPageControl:hidesForSinglePage()
    return toLuaBool(runtime::invokeMethod(self:id(), "hidesForSinglePage"));
end

function UIPageControl:setHidesForSinglePage(hides)
    runtime::invokeMethod(self:id(), "setHidesForSinglePage:", toObjCBool(hides));
end

function UIPageControl:sizeForNumberOfPages(pageCount)
    return unpackCStruct(runtime::invokeMethod(self:id(), "sizeForNumberOfPages:", pageCount));
end

function UIPageControl:updateCurrentPageDisplay()
    runtime::invokeMethod(self:id(), "updateCurrentPageDisplay");
end

function UIPageControl:pageDidChange()--[[event]]
    
end

function UIPageControl:event(event)
    if event == math::bitLeftshift(1, 12) then
        self:pageDidChange();
    end
end