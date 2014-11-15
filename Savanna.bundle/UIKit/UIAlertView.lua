require "Object"

class(UIAlertView);

function UIAlertView:create(title, message, cancelButtonTitle, ...--[[other titles]])
    self = self:get(tostring(math::random()));
    
    UIAlertViewEventProxyTable[self:id()] = self;
    ui::dialog_c(title, message, cancelButtonTitle, "UIAlertView_dismiss", self:id(), ...);
    
    return self;
end

function UIAlertView:dealloc()
    UIAlertViewEventProxyTable[self:id()] = nil;
    super:dealloc();
end

function UIAlertView:didDismiss(buttonIndex, buttonTitle)--[[event]]

end

UIAlertViewEventProxyTable = {};

function UIAlertView_dismiss(dialogId, buttonIndex, buttonTitle)
    local dialog = UIAlertViewEventProxyTable[dialogId];
    if dialog then
        dialog:didDismiss(tonumber(buttonIndex), buttonTitle);
    end
end