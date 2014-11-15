require "Object"

class(UIAnimation, Object);

-- constant
UIViewAnimationOptionLayoutSubviews            = 1;
UIViewAnimationOptionAllowUserInteraction      = 2;
UIViewAnimationOptionBeginFromCurrentState     = 4;
UIViewAnimationOptionRepeat                    = 8;
UIViewAnimationOptionAutoreverse               = 16;
UIViewAnimationOptionOverrideInheritedDuration = 32;
UIViewAnimationOptionOverrideInheritedCurve    = 64;
UIViewAnimationOptionAllowAnimatedContent      = 128;
UIViewAnimationOptionShowHideTransitionViews   = 256;

UIViewAnimationOptionCurveEaseInOut            = 0;
UIViewAnimationOptionCurveEaseIn               = 65536;
UIViewAnimationOptionCurveEaseOut              = 131072;
UIViewAnimationOptionCurveLinear               = 196608;

UIViewAnimationOptionTransitionNone            = 0;
UIViewAnimationOptionTransitionFlipFromLeft    = 1048576;
UIViewAnimationOptionTransitionFlipFromRight   = 2097152;
UIViewAnimationOptionTransitionCurlUp          = 3145728;
UIViewAnimationOptionTransitionCurlDown        = 4194304;
UIViewAnimationOptionTransitionCrossDissolve   = 5242880;
UIViewAnimationOptionTransitionFlipFromTop     = 6291456;
UIViewAnimationOptionTransitionFlipFromBottom  = 7340032;

-- constructor
function UIAnimation:create()
    self = super:get(tostring(math::random()));
    UIAnimationEventProxyTable[self:id()] = self;
    
    return self;
end

function UIAnimation:dealloc()
    UIAnimationEventProxyTable[self:id()] = nil;
    super:dealloc();
end

function UIAnimation:start(duration--[[option]], delay--[[option]], options--[[option]])
    if duration == nil then
        duration = 0.25;
    end
    if delay == nil then
        delay = 0;
    end
    if options == nil then
        options = 0;
    end
    ui::animate(self:id(), duration, delay, options, "UIAnimation_animation", "UIAnimation_complete");
end

-- instance methods
function UIAnimation:animation()--[[event]]
    
end

function UIAnimation:didStop()--[[event]]
    
end

-- event proxy
UIAnimationEventProxyTable = {};

function UIAnimation_animation(animId)
    local anim = UIAnimationEventProxyTable[animId];
    if anim then
        anim:animation();
    end
end

function UIAnimation_complete(animId)
    local anim = UIAnimationEventProxyTable[animId];
    if anim then
        anim:didStop();
    end
end