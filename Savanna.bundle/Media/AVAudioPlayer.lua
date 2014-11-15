require "Object"
require "AppContext"
require "CommonUtils"

class(AVAudioPlayer, Object);

function AVAudioPlayer:create(URL)
    self = self:get(runtime::invokeClassMethod("LIAudioPlayer", "create:URL:", AppContext.current(), URL:id()));
    AVAudioPlayerEventProxyTable[self:id()] = self;
    runtime::invokeMethod(self:id(), "setAudioPlayerDidFinishPlaying:", "AVAudioPlayer_audioPlayerDidFinishPlaying");
    
    return self;
end

function AVAudioPlayer:get(objId)
    local obj = super:get(objId);
    
    return obj;
end

function AVAudioPlayer:dealloc()
    AVAudioPlayerEventProxyTable[self:id()] = nil;
    super:dealloc();
end

function AVAudioPlayer:play()
    runtime::invokeMethod(self:id(), "play");
end

function AVAudioPlayer:pause()
    runtime::invokeMethod(self:id(), "pause");
end

function AVAudioPlayer:stop()
    runtime::invokeMethod(self:id(), "stop");
end

function AVAudioPlayer:didFinishPlaying(successfully)
    
end

AVAudioPlayerEventProxyTable = {};

function AVAudioPlayer_audioPlayerDidFinishPlaying(objId, successfully)
    local obj = AVAudioPlayerEventProxyTable[objId];
    if obj then
        obj:didFinishPlaying(toLuaBool(successfully));
    end
end