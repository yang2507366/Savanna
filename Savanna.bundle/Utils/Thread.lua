require "Object"
require "AppContext"

class(Thread);

function Thread:create()
    local objId = runtime::invokeClassMethod("LIThread", "create:", AppContext.current());
    runtime::invokeMethod(objId, "setRunFuncName:", "Thread_run");
    local tmp = self:get(objId);
    ThreadEventProxyTable[objId] = tmp;
    
    return tmp;
end

function Thread:dealloc()
    self:exit();
    ThreadEventProxyTable[self:id()] = nil;
    super:dealloc();
end

function Thread:start()
    runtime::invokeMethod(self:id(), "start");
end

function Thread:exit()
    runtime::invokeMethod(self:id(), "exit");
end

function Thread:sleepForTimeInterval(interval)
    runtime::invokeClassMethod("NSThread", "sleepForTimeInterval:", interval);
end

function Thread:run()
    
end

ThreadEventProxyTable = {};

function Thread_run(threadId)
    local tmp = ThreadEventProxyTable[threadId];
    if tmp then
        tmp:run();
    end
end