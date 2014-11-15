require "Object"
require "AppContext"
require "NSError"

class(HTTPRequest, Object);

HTTPRequestEncodingUTF8     = "UTF8";
HTTPRequestEncodingGBK      = "GBK";

-- constructor
function HTTPRequest:get(URLString, encoding--[[option]])
    if encoding == nil then
        encoding = HTTPRequestEncodingUTF8;
    end
    
    self = super:get(runtime::invokeClassMethod("LIHTTP", "HTTPGetWithURLString:appId:", URLString, AppContext.current()));
    runtime::invokeMethod(self:id(), "setEncoding:", encoding);
    runtime::invokeMethod(self:id(), "set_response:", "HTTPRequest_response");
    HTTPRequestEventProxyTable[self:id()] = self;
    self:start();
    
    return self;
end

function HTTPRequest:post(URLString, params, encoding--[[option]])
    if params == nil then
        params = "";
    end
    if params.id then
        params = params:id();
    end
    if encoding == nil then
        encoding = HTTPRequestEncodingUTF8;
    end
    
    self = super:get(runtime::invokeClassMethod("LIHTTP", "HTTPPostWithURLString:parameters:appId:", URLString, params, AppContext.current()));
    runtime::invokeMethod(self:id(), "setEncoding:", encoding);
    runtime::invokeMethod(self:id(), "set_response:", "HTTPRequest_response");
    HTTPRequestEventProxyTable[self:id()] = self;
    self:start();
    
    return self;
end

function HTTPRequest:download(URLString)
    self = super:get(runtime::invokeClassMethod("LIHTTP", "HTTPDownloadWithURLString:appId:", URLString, AppContext.current()));
    runtime::invokeMethod(self:id(), "set_response:", "HTTPRequest_response");
    runtime::invokeMethod(self:id(), "set_progress:", "HTTPRequest_progress");
    HTTPRequestEventProxyTable[self:id()] = self;
    self:start();
    
    return self;
end

function HTTPRequest:cachePage(URLString)
    self = super:get(runtime::invokeClassMethod("LIHTTP", "HTTPCachePageWithURLString:appId:", URLString, AppContext.current()));
    runtime::invokeMethod(self:id(), "set_response:", "HTTPRequest_response");
    runtime::invokeMethod(self:id(), "set_progress:", "HTTPRequest_progress");
    HTTPRequestEventProxyTable[self:id()] = self;
    self:start();
    
    return self;
end

-- instance method
function HTTPRequest:dealloc()
    self:cancel();
    super:dealloc();
end

function HTTPRequest:start()
    runtime::invokeMethod(self:id(), "start");
end

function HTTPRequest:cancel()
    runtime::invokeMethod(self:id(), "cancel");
    HTTPRequestEventProxyTable[self:id()] = nil;
end

-- event
function HTTPRequest:progress(downloaded, total)--[[event]]
    
end

function HTTPRequest:response(response, err)--[[event]]
    
end

-- event proxy
HTTPRequestEventProxyTable = {};

function HTTPRequest_response(reqId, response, errorId)
    local tmp = HTTPRequestEventProxyTable[reqId];
    if tmp then
        local err = nil;
        if errorId and string.len(errorId) ~= 0 then
            err = NSError:get(errorId);
        end
        tmp:response(response, err);
    end
end

function HTTPRequest_progress(reqId, downloaded, total)
    local tmp = HTTPRequestEventProxyTable[reqId];
    if tmp then
        tmp:progress(tonumber(downloaded), tonumber(total));
    end
end
