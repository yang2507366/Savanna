require "CommonUtils"

class(SystemUtils);

function SystemUtils.isPad()
    return toLuaBool(runtime::invokeClassMethod("LISystemUtils", "isPad"));
end