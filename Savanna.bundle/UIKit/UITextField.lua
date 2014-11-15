require "UIView"
require "UITextFieldDelegate"
require "AppContext"
require "CommonUtils"

class(UITextField, UIView);

-- constructor
function UITextField:create()
    return self:get(runtime::invokeClassMethod("LITextField", "create:", AppContext.current()));
end

-- instance methods
function UITextField:setDelegate(delegate)
    if delegate then
        self.textFieldDelegate = UITextFieldDelegate:create(self, delegate);
    else
        runtime::invokeMethod(self:id(), "setDelegate:", nil);
    end
end

function UITextField:borderStyle()
    return tonumber(runtime::invokeMethod(self:id(), "borderStyle"));
end

function UITextField:setBorderStyle(borderStyle)
    runtime::invokeMethod(self:id(), "setBorderStyle:", borderStyle);
end

function UITextField:setClearButtonMode(mode)
    runtime::invokeMethod(self:id(), "setClearButtonMode", mode);
end

function UITextField:text()
    return runtime::invokeMethod(self:id(), "text");
end

function UITextField:setText(str)
    runtime::invokeMethod(self:id(), "setText:", str);
end

function UITextField:setKeyboardType(ktype)
    runtime::invokeMethod(self:id(), "setKeyboardType:", ktype);
end

function UITextField:keyboardType()
    return tonumber(runtime::invokeMethod(self:id(), "keyboardType"));
end

function UITextField:setEnabled(enabled)
    runtime::invokeMethod(self:id(), "setEnabled:", toObjCBool(enabled));
end

function UITextField:enabled()
    return toLuaBool(runtime::invokeMethod(self:id(), "enabled"));
end

function UITextField:setReturnKeyType(keyType)
    runtime::invokeMethod(self:id(), "setReturnKeyType:", keyType);
end

function UITextField:returnKeyType()
    return runtime::invokeMethod(self:id(), "returnKeyType");
end

function UITextField:setFont(font)
    runtime::invokeMethod(self:id(), "setFont:", font:id());
end

function UITextField:font()
    return UIFont:get(runtime::invokeMethod(self:id(), "font"));
end

function UITextField:setPlaceholder(placeholder)
    runtime::invokeMethod(self:id(), "setPlaceholder:", placeholder);
end

function UITextField:placeholder()
    return runtime::invokeMethod(self:id(), "placeholder");
end
