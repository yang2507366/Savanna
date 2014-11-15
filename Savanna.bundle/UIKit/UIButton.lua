require "UIView"
require "UILabel"
require "AppContext"
require "CommonUtils"
require "UITargetEvent"

class(UIButton, UIView);

-- constructor
function UIButton:create(title--[[option]], buttonType--[[option]])
    if title == nil then
        title = "";
    end
    if buttonType == nil then
        buttonType = 1;
    end
    self = self:get(runtime::invokeClassMethod("UIButton", "buttonWithType:", buttonType));
    self:setTitle(title);
    self.targetEvent = UITargetEvent:create(self, math::bitLeftshift(1, 6));
    
    return self;
end

function UIButton:dealloc()
    if self.targetEvent then
        self.targetEvent:removeDelegate();
    end
    super:dealloc();
end

function UIButton:event(event)
    if event == math::bitLeftshift(1, 6) then
        self:didTap();
    end
end

-- instance methods
function UIButton:setTitle(title, state--[[option]])
    if state == nil then
        state = UIControlStateNormal;
    end
    runtime::invokeMethod(self:id(), "setTitle:forState:", title, state);
end

function UIButton:setTitleColor(color, state--[[option]])
    if state == nil then
        state = UIControlStateNormal;
    end
    runtime::invokeMethod(self:id(), "setTitleColor:forState:", color:id(), state);
end

function UIButton:setTitleShadowColor(color, state--[[option]])
    if state == nil then
        state = UIControlStateNormal;
    end
    runtime::invokeMethod(self:id(), "setTitleShadowColor:forState:", color:id(), state);
end

function UIButton:titleLabel()
    local labelId = runtime::invokeMethod(self:id(), "titleLabel");
    return UILabel:get(labelId);
end

function UIButton:setEnabled(enabled)
    runtime::invokeMethod(self:id(), "setEnabled:", toObjCBool(enabled));
end

function UIButton:enabled()
    return toLuaBool(runtime::invokeMethod(self:id(), "enabled"));
end

function UIButton:setImage(img, state--[[option]])
    if not state then
        state = 0;
    end
    runtime::invokeMethod(self:id(), "setImage:forState:", img:id(), state);
end

function UIButton:setBackgroundImage(img, state--[[option]])
    if not state then
        state = 0;
    end
    runtime::invokeMethod(self:id(), "setBackgroundImage:forState:", img:id(), state);
end

function UIButton:imageForState(state)
    return UIImage:get(runtime::invokeMethod(self:id(), "imageForState:", state));
end

function UIButton:currentImage()
    return UIImage:get(runtime::invokeMethod(self:id(), "currentImage"));
end

function UIButton:imageEdgeInsets()
    return unpackCStruct(runtime::invokeMethod(self:id(), "imageEdgeInsets"));
end

function UIButton:setImageEdgeInsets(top, left, bottom, right)
    runtime::invokeMethod(self:id(), "setImageEdgeInsets:", top..","..left..","..bottom..","..right);
end

function UIButton:titleEdgeInsets()
    return unpackCStruct(runtime::invokeMethod(self:id(), "titleEdgeInsets"));
end

function UIButton:setTitleEdgeInsets(top, left, bottom, right)
    runtime::invokeMethod(self:id(), "setTitleEdgeInsets:", top..","..left..","..bottom..","..right);
end

function UIButton:setBackgroundImageWithURL(URL, placeholderImage)
    if placeholderImage then
        placeholderImage = placeholderImage:id();
    end
    runtime::invokeMethod(self:id(), "setBackgroundImageWithURL:placeholderImage:", URL:id(), placeholderImage);
end

function UIButton:setImageWithURL(URL, placeholderImage)
    if placeholderImage then
        placeholderImage = placeholderImage:id();
    end
    runtime::invokeMethod(self:id(), "setImageWithURL:placeholderImage:", URL:id(), placeholderImage);
end

function UIButton:cancelCurrentImageLoad()
    runtime::invokeMethod(self:id(), "cancelCurrentImageLoad");
end

-- events
function UIButton:didTap()--[[event]]
end