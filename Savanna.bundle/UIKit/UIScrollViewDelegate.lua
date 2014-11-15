require "AppContext"
require "AbstractDelegate"

class(UIScrollViewDelegate, AbstractDelegate);

function UIScrollViewDelegate:create(scrollView, proxyTable)
    self = self:get(runtime::invokeClassMethod("LIScrollViewDelegate", "create:", AppContext.current()));
    self:setSourceObject(scrollView);
    self:initProxyTable(proxyTable);
    runtime::invokeMethod(scrollView:id(), "setDelegate:", self:id());
    
    return self;
end

function UIScrollViewDelegate:removeDelegate()
    super:removeDelegate();
    runtime::invokeMethod(self:sourceObject():id(), "setDelegate:", nil);
end

function UIScrollViewDelegate:initProxyTable(proxyTable)
    super:initProxyTable(proxyTable);
    
    if proxyTable then
        if proxyTable.scrollViewDidScroll then
            runtime::invokeMethod(self:id(), "set_scrollViewDidScroll:", "UIScrollViewDelegateEventProxyTable_scrollViewDidScroll");
        else
            runtime::invokeMethod(self:id(), "set_scrollViewDidScroll:", "");
        end
    end
end

function UIScrollViewDelegate:scrollViewDidScroll(scrollView)
end

function UIScrollViewDelegateEventProxyTable_scrollViewDidScroll(scrollViewDelegateId)
    local scrollViewDelegate = AbstractDelegate.delegateForBindedId(scrollViewDelegateId);
    if scrollViewDelegate and scrollViewDelegate.proxyTable then
        scrollViewDelegate.proxyTable:scrollViewDidScroll(scrollViewDelegate:sourceObject());
    end
end