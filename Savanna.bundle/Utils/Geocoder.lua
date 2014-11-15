require "Object"
require "AppContext"

class(Geocoder, Object);

function Geocoder:create()
    self = self:get(runtime::invokeClassMethod("LIGeocoder", "create:", AppContext:current()));
    
    GeocoderEventProxyTable[self:id()] = self;
    runtime::invokeMethod(self:id(), "setDidRecieveLocality:", "Geocoder_didSuccess");
    runtime::invokeMethod(self:id(), "setDidFailWithError:", "Geocoder_didError");
    
    return self;
end

function Geocoder:dealloc()
    GeocoderEventProxyTable[self:id()] = nil;
    self:cancel();
    super:dealloc();
end

function Geocoder:cancel()
    runtime::invokeMethod(self:id(), "cancel");
end

function Geocoder:geocode(latitude, longitude)
    runtime::invokeMethod(self:id(), "geocodeWithLatitude:longitude:", latitude, longitude);
end

function Geocoder:didSuccess(locality, address)--[[event]]
    
end

function Geocoder:didFailWithError()--[[event]]
    
end

-- event proxy
GeocoderEventProxyTable = {};

function Geocoder_didSuccess(gId, locality, address)
    local g = GeocoderEventProxyTable[gId];
    if g then
        g:didSuccess(locality, address);
    end
end

function Geocoder_didError(gId)
    local g = GeocoderEventProxyTable[gId];
    if g then
        g:didFailWithError();
    end
end