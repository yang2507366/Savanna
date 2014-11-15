require "Object"
require "NSURL"

class(NSURLRequest, Object);

function NSURLRequest:URL()
    local url = runtime::invokeMethod(self:id(), "URL");
    return NSURL:get(url);
end

function NSURLRequest:mainDocumentURL()
    local url = runtime::invokeMethod(self:id(), "mainDocumentURL");
    return NSURL:get(url);
end