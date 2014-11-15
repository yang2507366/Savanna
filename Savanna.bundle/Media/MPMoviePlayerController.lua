require "UIView"
require "AppContext"

class(MPMoviePlayerController);

function MPMoviePlayerController:create(url)
    self = self:get(runtime::createObject("MPMoviePlayerController", "initWithContentURL:", url:id()));
    
    return self;
end

function MPMoviePlayerController:dealloc()
    self:pause();
    self:stop();
    self:view():removeFromSuperview();
    super:dealloc();
end

function MPMoviePlayerController:view()
    return UIView:get(runtime::invokeMethod(self:id(), "view"));
end

function MPMoviePlayerController:play()
    runtime::invokeMethod(self:id(), "play");
end

function MPMoviePlayerController:pause()
    runtime::invokeMethod(self:id(), "pause");
end

function MPMoviePlayerController:stop()
    runtime::invokeMethod(self:id(), "stop");
end