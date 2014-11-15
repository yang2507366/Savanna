require "UIView"
require "AppContext"
require "CommonUtils"
require "StringUtils"

class(UIActionSheet, UIView);

function UIActionSheet:create(title, cancelButtonTitle, destructiveButtonTitle, ...--[[button titles]])
    if not cancelButtonTitle then
        cancelButtonTitle = "";
    end
    if not destructiveButtonTitle then
        destructiveButtonTitle = "";
    end
    self = self:get(runtime::invokeClassMethod("LIActionSheet", "create:title:", AppContext.current(), title));
    for i=1,arg.n do
        self:addButtonWithTitle(arg[i]);
    end
    local count = arg.n;
    if StringUtils.length(destructiveButtonTitle) ~= 0 then
        self:addButtonWithTitle(destructiveButtonTitle);
        self:setDestructiveButtonIndex(count);
        count = count + 1;
    end
    if StringUtils.length(cancelButtonTitle) ~= 0 then
        self:addButtonWithTitle(cancelButtonTitle);
        self:setCancelButtonIndex(count);
    end
    return self;
end

function UIActionSheet:get(asId)
    local as = super:get(asId);
    
    runtime::invokeMethod(asId, "setClickedButtonAtIndex:", "UIActionSheet_clickedButtonAtIndex");
    runtime::invokeMethod(asId, "setActionSheetCancel:", "UIActionSheet_cancel");
    runtime::invokeMethod(asId, "setDidDismissWithButtonIndex:", "UIActionSheet_didDismissWithButtonIndex");
    runtime::invokeMethod(asId, "setWillDismissWithButtonIndex:", "UIActionSheet_willDismissWithButtonIndex");
    UIActionSheetEventProxyTable[asId] = as;
    
    return as;
end

function UIActionSheet:title()
    return runtime::invokeMethod(self:id(), "title");
end

function UIActionSheet:setTitle(title)
    runtime::invokeMethod(self:id(), "setTitle:", title);
end

function UIActionSheet:setDestructiveButtonIndex(buttonIndex)
    runtime::invokeMethod(self:id(), "setDestructiveButtonIndex:", buttonIndex);
end

function UIActionSheet:destructiveButtonIndex()
    return tonumber(runtime::invokeMethod(self:id(), "destructiveButtonIndex"));
end

function UIActionSheet:cancelButtonIndex()
    return tonumber(runtime::invokeMethod(self:id(), "cancelButtonIndex"));
end

function UIActionSheet:setCancelButtonIndex(buttonIndex)
    runtime::invokeMethod(self:id(), "setCancelButtonIndex:", buttonIndex);
end

function UIActionSheet:showInView(view)
    runtime::invokeMethod(self:id(), "showInView:", view:id());
end

function UIActionSheet:showFromToolbar(toolbar)
    runtime::invokeMethod(self:id(), "showFromToolbar:", toolbar:id());
end

function UIActionSheet:showFromTabBar(tabBar)
    runtime::invokeMethod(self:id(), "showFromTabBar:", tabBar:id());
end

function UIActionSheet:showFromRect(x, y, width, height, view, animated--[[option]])
    runtime::invokeMethod(self:id(), "showFromRect:inView:animated:", toCStruct(x, y, width, height), view:id(), toObjCBool(animated));
end

function UIActionSheet:showFromBarButtonItem(barButtonItem)
    runtime::invokeMethod(self:id(), "showFromBarButtonItem:animated:", barButtonItem:id(), toObjCBool(animated));
end

function UIActionSheet:addButtonWithTitle(title)
    return tonumber(runtime::invokeMethod(self:id(), "addButtonWithTitle:", title));
end

function UIActionSheet:buttonTitleAtIndex(index)
    return runtime::invokeMethod(self:id(), "buttonTitleAtIndex:", index);
end

function UIActionSheet:dismissWithClickedButtonIndex(buttonIndex, animated)
    runtime::invokeMethod(self:id(), "dismissWithClickedButtonIndex:animated:", buttonIndex, toObjCBool(animated));
end

function UIActionSheet:dealloc()
    UIActionSheetEventProxyTable[self:id()] = nil;
    super:dealloc();
end

function UIActionSheet:clickedButtonAtIndex(index)--[[event]]
    
end

function UIActionSheet:didCancel()--[[event]]
    
end

function UIActionSheet:willDismissWithButtonIndex(buttonIndex)--[[event]]
    
end

function UIActionSheet:didDismissWithButtonIndex(buttonIndex)--[[event]]
    
end

UIActionSheetEventProxyTable = {};

function UIActionSheet_clickedButtonAtIndex(asId, index)
    local as = UIActionSheetEventProxyTable[asId];
    if as then
        as:clickedButtonAtIndex(tonumber(index));
    end
end

function UIActionSheet_cancel(asId)
    local as = UIActionSheetEventProxyTable[asId];
    if as then
        as:didCancel();
    end
end

function UIActionSheet_willDismissWithButtonIndex(asId, index)
    local as = UIActionSheetEventProxyTable[asId];
    if as then
        as:willDismissWithButtonIndex(tonumber(index));
    end
end

function UIActionSheet_didDismissWithButtonIndex(asId, index)
    local as = UIActionSheetEventProxyTable[asId];
    if as then
        as:didDismissWithButtonIndex(tonumber(index));
    end
end
