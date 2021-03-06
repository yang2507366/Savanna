require "Object"
require "NSData"
require "AppContext"
require "CommonUtils"

class(AppBundle, Object);

function AppBundle:current()
    return self:get(app::getAppBundle(AppContext.current()));
end

function AppBundle:bundleId()
    local bid = runtime::invokeMethod(self:id(), "bundleId");
    
    return bid;
end

function AppBundle:dataFromResource(resName)
    local dataId = runtime::invokeMethod(self:id(), "resourceWithName:", resName);
    if string.len(dataId) ~= 0 then
        local data = NSData:get(dataId);
        return data;
    end
    return nil;
end

function AppBundle:resourceExists(resName)
    return toLuaBool(runtime::invokeMethod(self:id(), "resourceExistsWithName:", resName));
end

function AppBundle:bundleVersion()
    return runtime::invokeMethod(self:id(), "bundleVersion");
end

