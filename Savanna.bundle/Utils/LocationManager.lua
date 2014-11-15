require "Object"
require "AppContext"

class(LocationManager, Object);

function LocationManager:create()
    self = self:get(runtime::invokeClassMethod("LILocationManager", "create:", AppContext.current()));

    LocationManagerEventProxyTable[self:id()] = self;
    runtime::invokeMethod(self:id(), "setDidUpdateToLocation:", "LocationManager_didUpdateToLocation");
    runtime::invokeMethod(self:id(), "setDidFailWithError:", "LocationManager_didFailWithError");
    
    return self;
end

function LocationManager:dealloc()
    self:cancel();
    LocationManagerEventProxyTable[self:id()] = nil;
    super:dealloc();
end

function LocationManager:cancel()
    runtime::invokeMethod(self:id(), "cancel");
end

function LocationManager:startUpdatingLocation()
    runtime::invokeMethod(self:id(), "startUpdatingLocation");
end

function LocationManager:didUpdateToLocation(latitude, longitude)--[[event]]
    
end

function LocationManager:didFailWithError()--[[event]]
    
end

-- event proxy
LocationManagerEventProxyTable = {};

function LocationManager_didUpdateToLocation(lmId, latitude, longitude)
    local lm = LocationManagerEventProxyTable[lmId];
    if lm then
        lm:didUpdateToLocation(tonumber(latitude), tonumber(longitude));
    end
end

function LocationManager_didFailWithError(lmId)
    local lm = LocationManagerEventProxyTable[lmId];
    if lm then
        lm:didFailWithError();
    end
end