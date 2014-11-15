require "UIView"
require "AppContext"
require "UITableViewCell"
require "UITableViewDataSource"
require "UITableViewDelegate"
require "NSIndexPath"

class(UITableView, UIView);

-- constructor
function UITableView:createWithStyle(style--[[option]])
    if style == nil then
        style = 0;
    end
    self = self:get(runtime::invokeClassMethod("LITableView", "create:style:", AppContext.current(), style));
    
    return self;
end

function UITableView:create()
    return UITableView:createWithStyle(0);
end

function UITableView:dealloc()
    super:dealloc();
end

-- instance method
function UITableView:setDataSource(dataSource)
    if dataSource then
        self.tableViewDataSource = UITableViewDataSource:create(self, dataSource);
    else
        runtime::invokeMethod(self:id(), "setDataSource:", nil);
    end
end

function UITableView:setDelegate(delegate)
    if delegate then
        self.tableViewDelegate = UITableViewDelegate:create(self, delegate);
    else
        runtime::invokeMethod(self:id(), "setDelegate:", nil);
    end
end

function UITableView:dequeueReusableCellWithIdentifier(identifier)
    local cellId = runtime::invokeMethod(self:id(), "dequeueReusableCellWithIdentifier:", identifier);
    if string.len(cellId) == 0 then
        return nil;
    end
    local cell = UITableViewCell:get(cellId);
    
    return cell;
end

function UITableView:setEditing(editing)
    runtime::invokeMethod(self:id(), "setEditing:", toObjCBool(editing));
end

function UITableView:reloadData()
    runtime::invokeMethod(self:id(), "reloadData");
end

function UITableView:deselectRowAtIndexPath(indexPath)
    runtime::invokeMethod(self:id(), "deselectRowAtIndexPath:animated:", indexPath:id(), toObjCBool(true));
end

function UITableView:tableHeaderView()
    local viewId = runtime::invokeMethod(self:id(), "tableHeaderView");
    return UIView:get(viewId):autorelease();
end

function UITableView:setTableHeaderView(view)
    runtime::invokeMethod(self:id(), "setTableHeaderView:", view:id());
end

function UITableView:setSeparatorStyle(style)
    runtime::invokeMethod(self:id(), "setSeparatorStyle:", style);
end

function UITableView:selectRowAtIndexPath(indexPath, animated)
    runtime::invokeMethod(self:id(), "selectRowAtIndexPath:animated:scrollPosition:", indexPath:id(), toObjCBool(animated));
end

function UITableView:beginUpdates()
    runtime::invokeMethod(self:id(), "beginUpdates");
end

function UITableView:endUpdates()
    runtime::invokeMethod(self:id(), "endUpdates");
end

function UITableView:deleteRowsAtIndexPaths(indexPaths, rowAnimation--[[option]])
    if not rowAnimation then
        rowAnimation = 100;
    end
    runtime::invokeMethod(self:id(), "deleteRowsAtIndexPaths:withRowAnimation:", indexPaths:id(), rowAnimation);
end
