require "UIResponder"
require "UIColor"
require "CommonUtils"
require "AppContext"
require "NSSet"
require "UIImage"
require "CALayer"

class(UIView);
class(UIEvent);

-- constant
UIViewAutoresizingNone = 0;
UIViewAutoresizingFlexibleLeftMargin = 1;
UIViewAutoresizingFlexibleWidth = 2;
UIViewAutoresizingFlexibleRightMargin = 4;
UIViewAutoresizingFlexibleTopMargin = 8;
UIViewAutoresizingFlexibleHeight = 16;
UIViewAutoresizingFlexibleBottomMargin = 32;

-- Constructor
function UIView:create()
    self = self:get(runtime::invokeClassMethod("LIView", "create:", AppContext.current()));
    
    UIViewEventProxyTable[self:id()] = self;
    runtime::invokeMethod(self:id(), "set_layoutSubviews", "UIView_layoutSubviews");
    runtime::invokeMethod(self:id(), "set_touchesBegan", "UIView_touchesBegan");
    runtime::invokeMethod(self:id(), "set_touchesCancelled", "UIView_touchesCancelled");
    runtime::invokeMethod(self:id(), "set_touchesEnded", "UIView_touchesEnded");
    runtime::invokeMethod(self:id(), "set_touchesMoved", "UIView_touchesMoved");
    
    return self;
end

function UIView:dealloc()
    UIViewEventProxyTable[self:id()] = nil;
    super:dealloc();
end

-- instance methods
function UIView:setFrame(x, y, width, height)
    local frame = x..","..y..","..width..","..height;
    runtime::invokeMethod(self:id(), "setFrame:", frame);
end

function UIView:frame()
    return unpackCStruct(runtime::invokeMethod(self:id(), "frame"));
end

function UIView:bounds()
    return unpackCStruct(runtime::invokeMethod(self:id(), "bounds"));
end

function UIView:setBackgroundColor(color)
	runtime::invokeMethod(self:id(), "setBackgroundColor:", color:id());
end

function UIView:backgroundColor()
    local colorId = runtime::invokeMethod(self:id(), "backgroundColor");
    return UIColor:get(colorId);
end

function UIView:addSubview(subview)
    runtime::invokeMethod(self:id(), "addSubview:", subview:id());
end

function UIView:setAutoresizingMask(mask)
    runtime::invokeMethod(self:id(), "setAutoresizingMask:", mask);
end

function UIView:autoresizingMask()
    return tonumber(runtime::invokeMethod(self:id(), "autoresizingMask"));
end

function UIView:resignFirstResponder()
    runtime::invokeMethod(self:id(), "resignFirstResponder");
end

function UIView:becomeFirstResponder()
    runtime::invokeMethod(self:id(), "becomeFirstResponder");
end

function UIView:isFirstResponder()
    return toLuaBool(runtime::invokeMethod(self:id(), "isFirstResponder"));
end

function UIView:viewWithTag(tag, viewType)
    local viewId = runtime::invokeMethod(self:id(), "viewWithTag:", tag);
    if isObjCObject(viewId) then
        local view = UIView:get(viewId);
        if viewType then
            setmetatable(view, viewType);
        end
        return view;
    end
    return nil;
end

function UIView:setTag(tag)
    runtime::invokeMethod(self:id(), "setTag:", tag);
end

function UIView:tag()
    local tag = runtime::invokeMethod(self:id(), "tag");
    return tonumber(tag);
end

function UIView:contentMode()
    return tonumber(runtime::invokeMethod(self:id(), "contentMode"));
end

function UIView:setContentMode(mode)
    runtime::invokeMethod(self:id(), "setContentMode:", mode);
end

function UIView:setUserInteractionEnabled(enabled)
    runtime::invokeMethod(self:id(), "setUserInteractionEnabled:", toObjCBool(enabled));
end

function UIView:userInteractionEnabled()
    local enabled = runtime::invokeMethod(self:id(), "userInteractionEnabled");
    return toLuaBool(enabled);
end

function UIView:setHidden(hidden)
    runtime::invokeMethod(self:id(), "setHidden:", toObjCBool(hidden));
end

function UIView:hidden()
    local hidden = runtime::invokeMethod(self:id(), "isHidden");
    return toLuaBool(hidden);
end

function UIView:addGestureRecognizer(gr)
    runtime::invokeMethod(self:id(), "addGestureRecognizer:", gr:id());
end

function UIView:removeGestureRecognizer(gr)
    runtime::invokeMethod(self:id(), "removeGestureRecognizer:", gr:id());
end

function UIView:toImage()
    return UIImage:get(runtime::invokeClassMethod("LIUIUtils", "imageWithView:", self:id()));
end

function UIView:layer()
    return CALayer:get(runtime::invokeMethod(self:id(), "layer"));
end

function UIView:clipsToBounds()
    return toLuaBool(runtime::invokeMethod(self:id(), "clipsToBounds"));
end

function UIView:setClipsToBounds(clipsToBounds)
    runtime::invokeMethod(self:id(), "setClipsToBounds:", toObjCBool(clipsToBounds));
end

function UIView:removeFromSuperview()
    runtime::invokeMethod(self:id(), "removeFromSuperview");
end

-- events
function UIView:layoutSubviews()
    
end

function UIView:touchesBegan(touches, event)
    
end

function UIView:touchesCancelled(touches, event)
    
end

function UIView:touchesEnded(touches, event)
    
end

function UIView:touchesMoved(touches, event)
    
end

UIViewEventProxyTable = {};

function UIView_layoutSubviews(viewId)
    local view = UIViewEventProxyTable[viewId];
    if view then
        view:layoutSubviews();
    end
end

function UIView_touchesBegan(viewId, touches, event)
    local view = UIViewEventProxyTable[viewId];
    if view then
        view:touchesBegan(NSSet:get(touches), UIEvent:get(event));
    end
end

function UIView_touchesCancelled(viewId, touches, event)
    local view = UIViewEventProxyTable[viewId];
    if view then
        view:touchesCancelled(NSSet:get(touches), UIEvent:get(event));
    end
end

function UIView_touchesEnded(viewId, touches, event)
    local view = UIViewEventProxyTable[viewId];
    if view then
        view:touchesEnded(NSSet:get(touches), UIEvent:get(event));
    end
end

function UIView_touchesMoved(viewId, touches, event)
    local view = UIViewEventProxyTable[viewId];
    if view then
        view:touchesMoved(NSSet:get(touches), UIEvent:get(event));
    end
end










