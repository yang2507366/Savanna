require "UIView"
require "AppContext"
require "UIScrollView"
require "NSError"
require "NSURL"
require "NSURLRequest"
require "UIWebViewDelegate"

class(UIWebView, UIView);

function UIWebView:create()
    self = self:get(runtime::invokeClassMethod("LIWebView", "create:", AppContext.current()));
    runtime::invokeMethod(self:id(), "set_shouldShowMenuItemWithSelectedText:", "UIWebView_shouldShowMenuItemWithSelectedText");
    runtime::invokeMethod(self:id(), "set_menuItemTapped:", "UIWebView_menuItemDidTap");
    runtime::invokeMethod(self:id(), "set_scrollViewDidScroll:", "UIWebView_scrollViewDidScroll");
    UIWebViewEventProxyTable[self:id()] = self;
    
    return self;
end

function UIWebView:dealloc()
    self:stopLoading();
    self:setDelegate(nil);
    UIWebViewEventProxyTable[self:id()] = nil;
    super:dealloc();
end

-- instance methods
function UIWebView:setDelegate(delegate)
    if delegate then
        self.webViewDelegate = UIWebViewDelegate:create(self, delegate);
    else
        runtime::invokeMethod(self:id(), "setDelegate:", nil);
    end
end

function UIWebView:loadURLString(URLString)
    runtime::invokeMethod(self:id(), "loadURLString:", URLString);
end

function UIWebView:loadURL(url)
    runtime::invokeMethod(self:id(), "loadURL:", url:id());
end

function UIWebView:loadHTMLString(HTMLString)
    runtime::invokeMethod(self:id(), "loadHTMLString:baseURL:", HTMLString);
end

function UIWebView:scalesPageToFit()
    return toLuaBool(runtime::invokeMethod(self:id(), "scalesPageToFit"));
end

function UIWebView:setScalesPageToFit(scale)
    runtime::invokeMethod(self:id(), "setScalesPageToFit:", toObjCBool(scale));
end

function UIWebView:goForward()
    runtime::invokeMethod(self:id(), "goForward");
end

function UIWebView:setActionMenuItem(menuItem)
    runtime::invokeMethod(self:id(), "setActionMenuItem:", menuItem);
end

function UIWebView:goBack()
    runtime::invokeMethod(self:id(), "goBack");
end

function UIWebView:canGoBack()
    return toLuaBool(runtime::invokeMethod(self:id(), "canGoBack"));
end

function UIWebView:canGoForward()
    return toLuaBool(runtime::invokeMethod(self:id(), "canGoForward"));
end

function UIWebView:scrollView()
    return UIScrollView:get(runtime::invokeMethod(self:id(), "getScrollView"));
end

function UIWebView:currentPageTitle()
    return runtime::invokeMethod(self:id(), "getPageTitle");
end

function UIWebView:disableContextMenu()
    runtime::invokeMethod(self:id(), "disableWebViewContextMenu");
end

function UIWebView:reload()
    runtime::invokeMethod(self:id(), "reload");
end

function UIWebView:stopLoading()
    runtime::invokeMethod(self:id(), "stopLoading");
end

function UIWebView:runScript(script)
    runtime::invokeMethod(self:id(), "stringByEvaluatingJavaScriptFromString:", script);
end

function UIWebView:currentDocumentURL()
    local request = runtime::invokeMethod(self:id(), "request");
    local URL = runtime::invokeMethod(request, "mainDocumentURL");
    runtime::releaseObject(request);
    
    return NSURL:get(URL);
end

function UIWebView:realWindowSize()
    return unpackCStruct(runtime::invokeMethod(self:id(), "windowSize"));
end

function UIWebView:linkURLStringAtPoint(x, y)
    return runtime::invokeMethod(self:id(), "getALinkAtPoint:", x..","..y);
end

function UIWebView:scrollOffset()
    return unpackCStruct(runtime::invokeMethod(self:id(), "scrollOffset"));
end

function UIWebView:HTMLElementsAtPoint(x, y)
    return runtime::invokeMethod(self:id(), "getHTMLElementsAtPoint:", x..","..y);
end

function UIWebView:stringByEvaluatingJavaScriptFromString(javascript)
    return runtime::invokeMethod(self:id(), "stringByEvaluatingJavaScriptFromString:", javascript);
end

function UIWebView:shouldShowMenuItemWithSelectedText(selectedText)
    return StringUtils.length(selectedText) ~= 0;
end

function UIWebView:actionMenuItemDidTap()
    
end

function UIWebView:scrollViewDidScroll(scrollView)
    
end

function UIWebView:selectedText()
    return runtime::invokeMethod(self:id(), "getSelectedText");
end

UIWebViewEventProxyTable = {};

function UIWebView_shouldShowMenuItemWithSelectedText(webViewId, selectedText)
    local webView = UIWebViewEventProxyTable[webViewId];
    if webView then
        return toObjCBool(webView:shouldShowMenuItemWithSelectedText(selectedText));
    end
    return toObjCBool(false);
end

function UIWebView_menuItemDidTap(webViewId)
    local webView = UIWebViewEventProxyTable[webViewId];
    if webView then
        webView:actionMenuItemDidTap();
    end
end

function UIWebView_scrollViewDidScroll(webViewId, scrollViewId)
    local webView = UIWebViewEventProxyTable[webViewId];
    if webView then
        webView:scrollViewDidScroll(UIScrollView:get(scrollViewId));
    end
end
