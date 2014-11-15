require "Object"
require "AppContext"

class(NSURL, Object);

function NSURL:create(URLString, isfileURL)
    local objId;
    if isfileURL then
        objId = runtime::invokeClassMethod("NSURL", "fileURLWithPath:", URLString);
    else
        objId = runtime::invokeClassMethod("NSURL", "URLWithString:", URLString);
    end
    return self:get(objId);
end

function NSURL:absoluteString()
    return runtime::invokeMethod(self:id(), "absoluteString");
end