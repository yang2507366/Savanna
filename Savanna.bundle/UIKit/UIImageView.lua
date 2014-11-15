require "UIView"
require "UIImage"

class(UIImageView, UIView);

function UIImageView:create(img--[[option]])
    self = self:get(newObjCObject("UIImageView"));
    if img then
        self:setImage(img);
    end
    return self;
end

-- instance methods
function UIImageView:setImage(image)
    if image then
        runtime::invokeMethod(self:id(), "setImage:", image:id());
    else
        runtime::invokeMethod(self:id(), "setImage:", "");
    end
end

function UIImageView:image()
    local imgViewId = runtime::invokeMethod(self:id(), "image");
    if string.len(imgViewId) == 0 then
        return nil;
    end
    return UIImage:get(imgViewId);
end

function UIImageView:setBackgroundImageWithURL(URL, placeholderImage)
    if placeholderImage then
        placeholderImage = placeholderImage:id();
    end
    runtime::invokeMethod(self:id(), "setBackgroundImageWithURL:placeholderImage:", URL:id(), placeholderImage);
end

function UIImageView:setImageWithURL(URL, placeholderImage)
    if placeholderImage then
        placeholderImage = placeholderImage:id();
    end
    runtime::invokeMethod(self:id(), "setImageWithURL:placeholderImage:", URL:id(), placeholderImage);
end

function UIImageView:cancelCurrentImageLoad()
    runtime::invokeMethod(self:id(), "cancelCurrentImageLoad");
end