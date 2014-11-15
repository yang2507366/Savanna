require "Object"

class(NSIndexPath, Object);

function NSIndexPath:create(row, section)
    return self:get(runtime::invokeClassMethod("NSIndexPath", "indexPathForRow:inSection:", row, section));
end

function NSIndexPath:section()
    return tonumber(runtime::invokeMethod(self:id(), "section"));
end

function NSIndexPath:row()
    return tonumber(runtime::invokeMethod(self:id(), "row"));
end