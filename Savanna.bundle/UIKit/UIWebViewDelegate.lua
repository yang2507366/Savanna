require "AppContext"
require "AbstractDelegate"

class(UIWebViewDelegate, AbstractDelegate);

function UIWebViewDelegate:create(webView, proxyTable)
    self = self:get(runtime::invokeClassMethod("LIWebViewDelegate", "create:", AppContext.current()));
    
    self:setSourceObject(webView);
    self:initProxyTable(proxyTable);
    runtime::invokeMethod(webView:id(), "setDelegate:", self:id());
    
    return self;
end

function UIWebViewDelegate:removeDelegate()
    super:removeDelegate();
    runtime::invokeMethod(self:sourceObject():id(), "setDelegate:", nil);
end

function UIWebViewDelegate:initProxyTable(proxyTable)
    super:initProxyTable(proxyTable);
    if proxyTable then
        if proxyTable.shouldStartLoadWithRequest then
            runtime::invokeMethod(self:id(), "setShouldStartLoadWithRequest:", "UIWebView_shouldStartLoadWithRequest");
        else
            runtime::invokeMethod(self:id(), "setShouldStartLoadWithRequest:", "");
        end
        
        if proxyTable.didStartLoad then
            runtime::invokeMethod(self:id(), "setDidStartLoad:", "UIWebView_didStartLoad");
        else
            runtime::invokeMethod(self:id(), "setDidStartLoad:", "");
        end
        
        if proxyTable.didFinishLoad then
            runtime::invokeMethod(self:id(), "setDidFinishLoad:", "UIWebView_didFinishLoad");
        else
            runtime::invokeMethod(self:id(), "setDidFinishLoad:", "");
        end
        
        if proxyTable.didFailLoadWithError then
            runtime::invokeMethod(self:id(), "setDidFailLoadWithError:", "UIWebView_didFailLoadWithError");
        else
            runtime::invokeMethod(self:id(), "setDidFailLoadWithError:", "");
        end
    end
end

function UIWebViewDelegate:shouldStartLoadWithRequest(webView, URLString, navigationType)
end

function UIWebViewDelegate:didStartLoad(webView)
end

function UIWebViewDelegate:didFinishLoad(webView)
end

function UIWebViewDelegate:didFailLoadWithError(webView, err)
end

function UIWebView_shouldStartLoadWithRequest(webViewDelegateId, request, navigationType)
    local webViewDelegate = AbstractDelegate.delegateForBindedId(webViewDelegateId);
    if webViewDelegate and webViewDelegate.proxyTable then
        local should = toObjCBool(webViewDelegate.proxyTable:shouldStartLoadWithRequest(webViewDelegate:sourceObject(), NSURLRequest:get(request), tonumber(navigationType)));
        return should;
    end
end

function UIWebView_didStartLoad(webViewDelegateId)
    local webViewDelegate = AbstractDelegate.delegateForBindedId(webViewDelegateId);
    if webViewDelegate and webViewDelegate.proxyTable then
        webViewDelegate.proxyTable:didStartLoad(webViewDelegate:sourceObject());
    end
end

function UIWebView_didFinishLoad(webViewDelegateId)
    local webViewDelegate = AbstractDelegate.delegateForBindedId(webViewDelegateId);
    if webViewDelegate and webViewDelegate.proxyTable then
        webViewDelegate.proxyTable:didFinishLoad(webViewDelegate:sourceObject());
    end
end

function UIWebView_didFailLoadWithError(webViewDelegateId, errId)
    local webViewDelegate = AbstractDelegate.delegateForBindedId(webViewDelegateId);
    local err = NSError:get(errId);
    if webViewDelegate and webViewDelegate.proxyTable then
        webViewDelegate.proxyTable:didFailLoadWithError(webViewDelegate:sourceObject(), err);
    end
end