require "Object"

class(NSNotificationCenter, Object);

function NSNotificationCenter.postNotificationName(name)
    local notificationCenter = runtime::invokeClassMethod("NSNotificationCenter", "defaultCenter");
    runtime::invokeMethod(notificationCenter, "postNotificationName:object:", name);
    runtime::releaseObject(notificationCenter);
end