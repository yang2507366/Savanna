require "AppContext"
require "AbstractDelegate"

class(UITextViewDelegate, AbstractDelegate);

function UITextViewDelegate:create(textView, proxyTable)
    self = self:get(runtime::invokeClassMethod("LITextViewDelegate", "create:", AppContext.current()));
    
    self:setSourceObject(textView);
    self:initProxyTable(proxyTable);
    runtime::invokeMethod(textView:id(), "setDelegate:", self:id());
    
    return self;
end

function UITextViewDelegate:removeDelegate()
    super:removeDelegate();
    runtime::invokeMethod(self:sourceObject():id(), "setDelegate:", nil);
end

function UITextViewDelegate:initProxyTable(proxyTable)
    super:initProxyTable(proxyTable);
    if proxyTable then
        if proxyTable.shouldBeginEditing then
            runtime::invokeMethod(self:id(), "setShouldBeginEditing:", "UITextView_shouldBeginEditing");
        else
            runtime::invokeMethod(self:id(), "setShouldBeginEditing:", "");
        end
        
        if proxyTable.shouldEndEditing then
            runtime::invokeMethod(self:id(), "setShouldEndEditing:", "UITextView_shouldEndEditing");
        else
            runtime::invokeMethod(self:id(), "setShouldEndEditing:", "");
        end
        
        if proxyTable.didBeginEditing then
            runtime::invokeMethod(self:id(), "setDidBeginEditing:", "UITextView_didBeginEditing");
        else
            runtime::invokeMethod(self:id(), "setDidBeginEditing:", "");
        end
        
        if proxyTable.didEndEditing then
            runtime::invokeMethod(self:id(), "setDidEndEditing:", "UITextView_didEndEditing");
        else
            runtime::invokeMethod(self:id(), "setDidEndEditing:", "");
        end
        
        if proxyTable.shouldChangeTextInRange then
            runtime::invokeMethod(self:id(), "setShouldChangeTextInRange:", "UITextView_shouldChangeTextInRange");
        else
            runtime::invokeMethod(self:id(), "setShouldChangeTextInRange:", "");
        end
        
        if proxyTable.didChange then
            runtime::invokeMethod(self:id(), "setDidChange:", "UITextView_didChange");
        else
            runtime::invokeMethod(self:id(), "setDidChange:", "");
        end
        
        if proxyTable.didChangeSelection then
            runtime::invokeMethod(self:id(), "setDidChangeSelection:", "UITextView_didChangeSelection");
        else
            runtime::invokeMethod(self:id(), "setDidChangeSelection:", "");
        end
    end
end

function UITextViewDelegate:shouldBeginEditing(textView)
end

function UITextViewDelegate:shouldEndEditing(textView)
end

function UITextViewDelegate:didBeginEditing(textView)
end

function UITextViewDelegate:didEndEditing(textView)
end

function UITextViewDelegate:shouldChangeTextInRange(textView)
end

function UITextViewDelegate:didChange(textView)
end

function UITextViewDelegate:didChangeSelection(textView)
end

function UITextView_shouldBeginEditing(textViewDelegateId)
    local textViewDelegate = AbstractDelegate.delegateForBindedId(textViewDelegateId);
    if textViewDelegate and textViewDelegate.proxyTable then
        
        local should = toObjCBool(textViewDelegate.proxyTable:shouldBeginEditing(textViewDelegate:sourceObject()));
        
        return should;
    end
end

function UITextView_shouldEndEditing(textViewDelegateId)
    local textViewDelegate = AbstractDelegate.delegateForBindedId(textViewDelegateId);
    if textViewDelegate and textViewDelegate.proxyTable then
        
        local should = toObjCBool(textViewDelegate.proxyTable:shouldEndEditing(textViewDelegate:sourceObject()));
        
        return should;
    end
end

function UITextView_didBeginEditing(textViewDelegateId)
    local textViewDelegate = AbstractDelegate.delegateForBindedId(textViewDelegateId);
    if textViewDelegate and textViewDelegate.proxyTable then
        
        textViewDelegate.proxyTable:didBeginEditing(textViewDelegate:sourceObject());
        
    end
end

function UITextView_didEndEditing(textViewDelegateId)
    local textViewDelegate = AbstractDelegate.delegateForBindedId(textViewDelegateId);
    if textViewDelegate and textViewDelegate.proxyTable then
        
        textViewDelegate.proxyTable:didEndEditing(textViewDelegate:sourceObject());
        
    end
end

function UITextView_shouldChangeTextInRange(textViewDelegateId, location, length, replacementText)
    local textViewDelegate = AbstractDelegate.delegateForBindedId(textViewDelegateId);
    if textViewDelegate and textViewDelegate.proxyTable then
        
        local should = toObjCBool(textViewDelegate.proxyTable:shouldChangeTextInRange(textViewDelegate:sourceObject(), tonumber(location), tonumber(length), replacementText));
        
        return should;
    end
end

function UITextView_didChange(textViewDelegateId)
    local textViewDelegate = AbstractDelegate.delegateForBindedId(textViewDelegateId);
    if textViewDelegate and textViewDelegate.proxyTable then
        
        textViewDelegate.proxyTable:didChange(textViewDelegate:sourceObject());
        
    end
end

function UITextView_didChangeSelection(textViewDelegateId)
    local textViewDelegate = AbstractDelegate.delegateForBindedId(textViewDelegateId);
    if textViewDelegate and textViewDelegate.proxyTable then
        
        textViewDelegate.proxyTable:didChangeSelection(textViewDelegate:sourceObject());
        
    end
end