require "Object"
require "UIView"
require "UIFont"
require "CommonUtils"
require "UITextViewDelegate"

class(UITextView, UIView);

-- constructor
function UITextView:create()
    return self:get(runtime::invokeClassMethod("LITextView", "create:", AppContext.current()));
end

function UITextView:dealloc()
    self:setDelegate(nil);
    super:dealloc();
end

-- instance methods
function UITextView:setText(text)
    runtime::invokeMethod(self:id(), "setText:", text);
end

function UITextView:text()
    return runtime::invokeMethod(self:id(), "text");
end

function UITextView:setTextColor(color)
    runtime::invokeMethod(self:id(), "setTextColor:", color:id());
end

function UITextView:textColor()
    return UIColor:get(runtime::invokeMethod(self:id(), "textColor"));
end

function UITextView:setFont(font)
    runtime::invokeMethod(self:id(), "setFont:", font:id());
end

function UITextView:font()
    local fontId = runtime::invokeMethod(self:id(), "font");
    return UIFont:get(fontId);
end

function UITextView:setEditable(editable)
    runtime::invokeMethod(self:id(), "setEditable:", toObjCBool(editable));
end

function UITextView:editable()
    local b = runtime::invokeMethod(self:id(), "isEditable");
    return toLuaBool(b);
end

function UITextView:setDelegate(delegate)
    if delegate then
        self.textViewDelegate = UITextViewDelegate:create(self, delegate);
    else
        runtime::invokeMethod(self:id(), "setDelegate:", nil);
    end
end