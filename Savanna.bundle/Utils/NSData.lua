require "Object"
require "CommonUtils"

class(NSData, Object);

function NSData:dataWithContentsOfFile(path)
    return self:get(runtime::invokeClassMethod("NSData", "dataWithContentsOfFile:", path));
end

function NSData:dataWithContentsOfURL(URL)
    return self:get(runtime::invokeClassMethod("NSData", "dataWithContentsOfURL:", URL:id()));
end

function NSData:dataWithData(data)
    return self:get(runtime::invokeClassMethod("NSData", "dataWithData:", data:id()));
end

function NSData:length()
    return tonumber(runtime::invokeMethod(self:id(), "length"));
end

function NSData:description()
    return runtime::invokeMethod(self:id(), "description");
end

function NSData:writeToFile(path, atomically--[[option]])
    if atomically == nil then
        atomically = false;
    end
    
    runtime::invokeMethod(self:id(), "writeToFile:atomically:", path, toObjCBool(atomically));
end

function NSData:writeToURL(URL, atomically--[[option]])
    if atomically == nil then
        atomically = false;
    end
    
    runtime::invokeMethod(self:id(), "writeToURL:atomically:", URL:id(), toObjCBool(atomically));
end
