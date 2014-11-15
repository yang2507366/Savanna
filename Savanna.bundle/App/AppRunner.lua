require "Object"
require "UIViewController"
require "AppContext"

class(AppRunner);

function AppRunner:create(url, params, relatedViewController)
    if not url then
        return nil;
    end
    if not relatedViewController then
        relatedViewController = UIViewController.relatedNavigationController():id();
    end
    if params then
        params = params:id();
    end
    self = self:get(runtime::invokeClassMethod("LIAppRunner", "create:", AppContext.current()));
    AppRunnerEventProxyTable[self:id()] = self;
    runtime::invokeMethod(self:id(), "set_completion:", "AppRunner_completion");
    
    runtime::invokeMethod(self:id(), "runWithURL:params:relatedViewController:", url:id(), params, relatedViewController);
    
    return self;
end

function AppRunner:dealloc()
    self:cancel();
    self:destory();
    AppRunnerEventProxyTable[self:id()] = nil;
    super:dealloc();
end

function AppRunner:cancel()
    runtime::invokeMethod(self:id(), "cancel");
end

function AppRunner:destory()
    runtime::invokeMethod(self:id(), "destory");
end

function AppRunner:completion(success, returnValue)--[[event]]
    
end

AppRunnerEventProxyTable = {};

function AppRunner_completion(objId, success, returnValue)
    local runner = AppRunnerEventProxyTable[objId];
    if runner then
        runner:completion(toLuaBool(success), returnValue);
    end
end