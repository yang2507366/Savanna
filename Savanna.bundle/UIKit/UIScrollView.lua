require "UIView"
require "AppContext"
require "CommonUtils"
require "UIScrollViewDelegate"

class(UIScrollView, UIView);

function UIScrollView:create()
    return self:get(newObjCObject("UIScrollView"));
end

function UIScrollView:dealloc()
    self:setDelegate(nil);
    super:dealloc();
end

function UIScrollView:setContentInset(top, left, bottom, right)
    local inset = top..","..left..","..bottom..","..right;
    runtime::invokeMethod(self:id(), "setContentInset:", inset);
end

function UIScrollView:setScrollIndicatorInsets(top, left, bottom, right)
    local inset = top..","..left..","..bottom..","..right;
    runtime::invokeMethod(self:id(), "setScrollIndicatorInsets:", inset);
end

function UIScrollView:contentOffset()
    return unpackCStruct(runtime::invokeMethod(self:id(), "contentOffset"));
end

function UIScrollView:contentSize()
    return unpackCStruct(runtime::invokeMethod(self:id(), "contentSize"));
end

function UIScrollView:setContentSize(width, height)
    runtime::invokeMethod(self:id(), "setContentSize:", width..","..height);
end

function UIScrollView:scrollsToTop()
    return runtime::invokeMethod(self:id(), "scrollsToTop");
end

function UIScrollView:setScrollsToTop(scrollsToTop)
    runtime::invokeMethod(self:id(), "setScrollsToTop:", toObjCBool(scrollsToTop));
end

function UIScrollView:setDelegate(delegate)
    if delegate then
        self.scrollViewDelegate = UIScrollViewDelegate:create(self, delegate);
    else
        runtime::invokeMethod(self:id(), "setDelegate:", nil);
    end
end