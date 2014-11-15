class(DateUtils);

function DateUtils.now(dateFormat)
    local dateFormatId = runtime::invokeClassMethod("NSDateFormatter", "new");
    runtime::invokeMethod(dateFormatId, "autorelease");
    runtime::releaseObject(dateFormatId);
    
    runtime::invokeMethod(dateFormatId, "setDateFormat:", dateFormat);
    
    local dateId = runtime::invokeClassMethod("NSDate", "new");
    runtime::invokeMethod(dateId, "autorelease");
    runtime::releaseObject(dateId);
    
    local dateString = runtime::invokeMethod(dateFormatId, "stringFromDate:", dateId);
    runtime::releaseObject(dateFormatId);
    runtime::releaseObject(dateId);
    
    return dateString;
end