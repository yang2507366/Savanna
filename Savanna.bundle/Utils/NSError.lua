require "Object"

class(NSError, Object);

function NSError:code()
    return tonumber(runtime::invokeMethod(self:id(), "code"));
end

function NSError:domain()
    return runtime::invokeMethod(self:id(), "domain");
end

function NSError:localizedDescription()
    return runtime::invokeMethod(self:id(), "localizedDescription");
end