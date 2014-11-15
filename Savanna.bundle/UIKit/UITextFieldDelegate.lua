require "AppContext"
require "AbstractDelegate"

class(UITextFieldDelegate, AbstractDelegate);

function UITextFieldDelegate:create(textField, proxyTable)
    self = self:get(runtime::invokeClassMethod("LITextFieldDelegate", "create:", AppContext.current()));
    
    self:setSourceObject(textField);
    self:initProxyTable(proxyTable);
    runtime::invokeMethod(textField:id(), "setDelegate:", self:id());
    
    return self;
end

function UITextFieldDelegate:removeDelegate()
    super:removeDelegate();
    runtime::invokeMethod(self:sourceObject():id(), "setDelegate:", nil);
end

function UITextFieldDelegate:initProxyTable(proxyTable)
    super:initProxyTable(proxyTable);
    if proxyTable then
        if proxyTable.shouldBeginEditing then
            runtime::invokeMethod(self:id(), "setShouldBeginEditing:", "UITextFieldDelegate_shouldBeginEditing");
        else
            runtime::invokeMethod(self:id(), "setShouldBeginEditing:", "");
        end
        
        if proxyTable.didBeginEditing then
            runtime::invokeMethod(self:id(), "setDidBeginEditing:", "UITextFieldDelegate_didBeginEditing");
        else
            runtime::invokeMethod(self:id(), "setDidBeginEditing:", "");
        end
        
        if proxyTable.shouldEndEditing then
            runtime::invokeMethod(self:id(), "setShouldEndEditing:", "UITextFieldDelegate_shouldEndEditing");
        else
            runtime::invokeMethod(self:id(), "setShouldEndEditing:", "");
        end
        
        if proxyTable.didEndEditing then
            runtime::invokeMethod(self:id(), "setDidEndEditing:", "UITextFieldDelegate_didEndEditing");
        else
            runtime::invokeMethod(self:id(), "setDidEndEditing:", "");
        end
        
        if proxyTable.shouldChangeCharactersInRange then
            runtime::invokeMethod(self:id(), "setShouldChangeCharactersInRange:", "UITextFieldDelegate_shouldChangeCharactersInRange");
        else
            runtime::invokeMethod(self:id(), "setShouldChangeCharactersInRange:", "");
        end
        
        if proxyTable.shouldClear then
            runtime::invokeMethod(self:id(), "setShouldClear:", "UITextFieldDelegate_shouldClear");
        else
            runtime::invokeMethod(self:id(), "setShouldClear:", "");
        end
        
        if proxyTable.shouldReturn then
            runtime::invokeMethod(self:id(), "setShouldReturn:", "UITextFieldDelegate_shouldReturn");
        else
            runtime::invokeMethod(self:id(), "setShouldReturn:", "");
        end
        
        if proxyTable.textDidChange then
            runtime::invokeMethod(self:id(), "setTextValueChanged:", "UITextFieldDelegate_TextValueChanged");
        else
            runtime::invokeMethod(self:id(), "setTextValueChanged:", "");
        end

    end
end

function UITextFieldDelegate:shouldBeginEditing(textField)
end

function UITextFieldDelegate:didBeginEditing(textField)
end

function UITextFieldDelegate:shouldEndEditing(textField)
end

function UITextFieldDelegate:didEndEditing(textField)
end

function UITextFieldDelegate:shouldChangeCharactersInRange(textField, location, length, replacementString)
end

function UITextFieldDelegate:shouldClear(textField)
end

function UITextFieldDelegate:shouldReturn(textField)
end

function UITextFieldDelegate:textDidChange(textField)
    
end

function UITextFieldDelegate_shouldBeginEditing(textFieldDelegateId)
    local textFieldDelegate = AbstractDelegate.delegateForBindedId(textFieldDelegateId);
    if textFieldDelegate and textFieldDelegate.proxyTable then
        local should = toObjCBool(textFieldDelegate.proxyTable:shouldBeginEditing(textFieldDelegate:sourceObject()));
        return should;
    end
end

function UITextFieldDelegate_didBeginEditing(textFieldDelegateId)
    local textFieldDelegate = AbstractDelegate.delegateForBindedId(textFieldDelegateId);
    if textFieldDelegate and textFieldDelegate.proxyTable then
        textFieldDelegate.proxyTable:didBeginEditing(textFieldDelegate:sourceObject());
    end
end

function UITextFieldDelegate_shouldEndEditing(textFieldDelegateId)
    local textFieldDelegate = AbstractDelegate.delegateForBindedId(textFieldDelegateId);
    if textFieldDelegate and textFieldDelegate.proxyTable then
        local should = toObjCBool(textFieldDelegate.proxyTable:shouldEndEditing(textFieldDelegate:sourceObject()));
        return should;
    end
end

function UITextFieldDelegate_didEndEditing(textFieldDelegateId)
    local textFieldDelegate = AbstractDelegate.delegateForBindedId(textFieldDelegateId);
    if textFieldDelegate and textFieldDelegate.proxyTable then
        textFieldDelegate.proxyTable:didEndEditing(textFieldDelegate:sourceObject());
    end
end

function UITextFieldDelegate_shouldChangeCharactersInRange(textFieldDelegateId, location, length, replacementString)
    local textFieldDelegate = AbstractDelegate.delegateForBindedId(textFieldDelegateId);
    if textFieldDelegate and textFieldDelegate.proxyTable then
        local should = toObjCBool(textFieldDelegate.proxyTable:shouldChangeCharactersInRange(textFieldDelegate:sourceObject(), tonumber(location), tonumber(length), replacementString));
        return should;
    end
end

function UITextFieldDelegate_shouldClear(textFieldDelegateId)
    local textFieldDelegate = AbstractDelegate.delegateForBindedId(textFieldDelegateId);
    if textFieldDelegate and textFieldDelegate.proxyTable then
        local should = toObjCBool(textFieldDelegate.proxyTable:shouldClear(textFieldDelegate:sourceObject()));
        return should;
    end
end

function UITextFieldDelegate_shouldReturn(textFieldDelegateId)
    local textFieldDelegate = AbstractDelegate.delegateForBindedId(textFieldDelegateId);
    if textFieldDelegate and textFieldDelegate.proxyTable then
        local should = toObjCBool(textFieldDelegate.proxyTable:shouldReturn(textFieldDelegate:sourceObject()));
        return should;
    end
end

function UITextFieldDelegate_TextValueChanged(textFieldDelegateId)
    local textFieldDelegate = AbstractDelegate.delegateForBindedId(textFieldDelegateId);
    if textFieldDelegate and textFieldDelegate.proxyTable then
        textFieldDelegate.proxyTable:textDidChange(textFieldDelegate:sourceObject());
    end
end