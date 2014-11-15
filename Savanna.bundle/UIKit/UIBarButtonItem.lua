require "Object"

class(UIBarButtonItem, Object);

UIBarButtonItemStylePlain = 0;
UIBarButtonItemStyleBordered = 1;
UIBarButtonItemStyleDone = 2;

-- constructor
function UIBarButtonItem:create(title--[[option]])
    if title == nil then
        title = "Untitled";
    end
    self = self:get(runtime::invokeClassMethod("LIBarButtonItem", "create", AppContext.current()));
    self:setTitle(title);
    
    return self;
end

function UIBarButtonItem:createWithSystemItem(systemItem)
    self = self:get(runtime::invokeClassMethod("LIBarButtonItem", "createWithAppId:systemItem:", AppContext.current(), systemItem));
    return self;
end

function UIBarButtonItem:createWithImage(img)
    self = self:get(runtime::invokeClassMethod("LIBarButtonItem", "createWithAppId:image:", AppContext.current(), img:id()));
    return self;
end

function UIBarButtonItem:initWithCustomView(customView)
    self = runtime::createObject("UIBarButtonItem", "initWithCustomView:", customView:id());
    return self;
end

function UIBarButtonItem:get(buttonItemId)
    local buttonItem = super:get(buttonItemId);
    
    UIBarButtonItemEventProxyTable[buttonItemId] = buttonItem;
    runtime::invokeMethod(buttonItemId, "setTapped:", "UIBarButtonItem_tapped");
    
    return buttonItem;
end

-- deconstructor
function UIBarButtonItem:dealloc()
    runtime::invokeMethod(self:id(), "setTapped:", "");
    UIBarButtonItemEventProxyTable[self:id()] = nil;
    super:dealloc();
end

-- instance methods
function UIBarButtonItem:setTitle(title)
    runtime::invokeMethod(self:id(), "setTitle:", title);
end

function UIBarButtonItem:setStyle(style)
    runtime::invokeMethod(self:id(), "setStyle:", style);
end

function UIBarButtonItem:style()
    return tonumber(runtime::invokeMethod(self:id(), "style"));
end

function UIBarButtonItem:setEnabled(enabled)
    runtime::invokeMethod(self:id(), "setEnabled:", toObjCBool(enabled));
end

function UIBarButtonItem:enabled()
    return toLuaBool(runtime::invokeMethod(self:id(), "enabled"));
end

-- event
function UIBarButtonItem:didTap()--[[event]]
end

-- event proxy
UIBarButtonItemEventProxyTable = {};

function UIBarButtonItem_tapped(btnId)
    UIBarButtonItemEventProxyTable[btnId]:didTap();
end