require "AbstractDelegate"
require "AppContext"

class(UITableViewDataSource, AbstractDelegate);

function UITableViewDataSource:create(tableView, proxyTable)
    self = self:get(runtime::invokeClassMethod("LITableViewDataSource", "create:", AppContext.current()));
    self:setSourceObject(tableView);
    self:initProxyTable(proxyTable);
    runtime::invokeMethod(tableView:id(), "setDataSource:", self:id());
    
    return self;
end

function UITableViewDataSource:removeDelegate()
    super:removeDelegate();
    runtime::invokeMethod(self:sourceObject():id(), "setDataSource:", nil);
end

function UITableViewDataSource:initProxyTable(proxyTable)
    super:initProxyTable(proxyTable);
    if proxyTable then
        if proxyTable.numberOfRowsInSection then
            runtime::invokeMethod(self:id(), "setNumberOfRowsInSection:", "UITableViewDataSource_numberOfRowsInSection");
        else
            runtime::invokeMethod(self:id(), "setNumberOfRowsInSection:", "");
        end
        
        if proxyTable.cellForRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setCellForRowAtIndexPath:", "UITableViewDataSource_cellForRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setCellForRowAtIndexPath:", "");
        end
        
        if proxyTable.numberOfSections then
            runtime::invokeMethod(self:id(), "setNumberOfSections:", "UITableViewDataSource_numberOfSections");
        else
            runtime::invokeMethod(self:id(), "setNumberOfSections:", "");
        end
        
        if proxyTable.titleForHeaderInSection then
            runtime::invokeMethod(self:id(), "setTitleForHeaderInSection:", "UITableViewDataSource_titleForHeaderInSection");
        else
            runtime::invokeMethod(self:id(), "setTitleForHeaderInSection:", "");
        end
        
        if proxyTable.titleForFooterInSection then
            runtime::invokeMethod(self:id(), "setTitleForFooterInSection:", "UITableViewDataSource_titleForFooterInSection");
        else
            runtime::invokeMethod(self:id(), "setTitleForFooterInSection:", "");
        end
        
        if proxyTable.canEditRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setCanEditRowAtIndexPath:", "UITableViewDataSource_canEditRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setCanEditRowAtIndexPath:", "");
        end
        
        if proxyTable.canMoveRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setCanMoveRowAtIndexPath:", "UITableViewDataSource_canMoveRowAtIndexPath");
            else
            runtime::invokeMethod(self:id(), "setCanMoveRowAtIndexPath:", "");
        end
        
        if proxyTable.sectionIndexTitles then
            runtime::invokeMethod(self:id(), "setSectionIndexTitles:", "UITableViewDataSource_sectionIndexTitles");
        else
            runtime::invokeMethod(self:id(), "setSectionIndexTitles:", "");
        end
        
        if proxyTable.sectionForSectionIndexTitle then
            runtime::invokeMethod(self:id(), "setSectionForSectionIndexTitle:", "UITableViewDataSource_sectionForSectionIndexTitle");
        else
            runtime::invokeMethod(self:id(), "setSectionForSectionIndexTitle:", "");
        end
        
        if proxyTable.commitEditingStyle then
            runtime::invokeMethod(self:id(), "setCommitEditingStyle:", "UITableViewDataSource_commitEditingStyle");
        else
            runtime::invokeMethod(self:id(), "setCommitEditingStyle:", "");
        end
        
        if proxyTable.moveRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setMoveRowAtIndexPath:", "UITableViewDataSource_moveRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setMoveRowAtIndexPath:", "");
        end
    end
end

function UITableViewDataSource:numberOfRowsInSection(tableView, section)
end

function UITableViewDataSource:cellForRowAtIndexPath(tableView, indexPath)
end

function UITableViewDataSource:numberOfSections(tableView)
end

function UITableViewDataSource:titleForHeaderInSection(tableView, section)
end

function UITableViewDataSource:titleForFooterInSection(tableView, section)
end

function UITableViewDataSource:canEditRowAtIndexPath(tableView, indexPath)
end

function UITableViewDataSource:canMoveRowAtIndexPath(tableView, indexPath)
end

function UITableViewDataSource:sectionIndexTitles(tableView)
end

function UITableViewDataSource:sectionForSectionIndexTitle(tableView, title, index)
end

function UITableViewDataSource:commitEditingStyle(tableView, editingStyle, indexPath)
end

function UITableViewDataSource:moveRowAtIndexPath(tableView, sourceIndexPath, destinationIndexPath)
end

function UITableViewDataSource_numberOfRowsInSection(tableViewDataSourceId, section)
    local tableViewDataSource = AbstractDelegate.delegateForBindedId(tableViewDataSourceId);
    if tableViewDataSource and tableViewDataSource.proxyTable then
        local rows = tableViewDataSource.proxyTable:numberOfRowsInSection(tableViewDataSource:sourceObject(), tonumber(section));
        return rows;
    end
end

function UITableViewDataSource_cellForRowAtIndexPath(tableViewDataSourceId, indexPathId)
    local tableViewDataSource = AbstractDelegate.delegateForBindedId(tableViewDataSourceId);
    
    if tableViewDataSource and tableViewDataSource.proxyTable then
        local indexPath = NSIndexPath:get(indexPathId);
        local cell = tableViewDataSource.proxyTable:cellForRowAtIndexPath(tableViewDataSource:sourceObject(), indexPath);
        if cell and cell.id then
            cell:retain();
            return cell:id();
        end
    end
end

function UITableViewDataSource_numberOfSections(tableViewDataSourceId)
    local tableViewDataSource = AbstractDelegate.delegateForBindedId(tableViewDataSourceId);
    
    if tableViewDataSource and tableViewDataSource.proxyTable then
        local sections = tableViewDataSource.proxyTable:numberOfSections(tableViewDataSource:sourceObject());
        return sections;
    end
end

function UITableViewDataSource_titleForHeaderInSection(tableViewDataSourceId, section)
    local tableViewDataSource = AbstractDelegate.delegateForBindedId(tableViewDataSourceId);
    
    if tableViewDataSource and tableViewDataSource.proxyTable then
        local title = tableViewDataSource.proxyTable:titleForHeaderInSection(tableViewDataSource:sourceObject(), tonumber(section));
        return title;
    end
end

function UITableViewDataSource_titleForFooterInSection(tableViewDataSourceId, section)
    local tableViewDataSource = AbstractDelegate.delegateForBindedId(tableViewDataSourceId);
    
    if tableViewDataSource and tableViewDataSource.proxyTable then
        
        local title = tableViewDataSource.proxyTable:titleForFooterInSection(tableViewDataSource:sourceObject(), tonumber(section));
        
        return title;
    end
end

function UITableViewDataSource_canEditRowAtIndexPath(tableViewDataSourceId, indexPathId)
    local tableViewDataSource = AbstractDelegate.delegateForBindedId(tableViewDataSourceId);
    
    if tableViewDataSource and tableViewDataSource.proxyTable then
        
        local indexPath = NSIndexPath:get(indexPathId);
        local can = toObjCBool(tableViewDataSource.proxyTable:canEditRowAtIndexPath(tableViewDataSource:sourceObject(), indexPath));
        
        return can;
    end
end

function UITableViewDataSource_canMoveRowAtIndexPath(tableViewDataSourceId, indexPathId)
    local tableViewDataSource = AbstractDelegate.delegateForBindedId(tableViewDataSourceId);
    
    if tableViewDataSource and tableViewDataSource.proxyTable then
        
        local indexPath = NSIndexPath:get(indexPathId);
        local can = toObjCBool(tableViewDataSource.proxyTable:canMoveRowAtIndexPath(tableViewDataSource:sourceObject(), indexPath));
        
        return can;
    end
end

function UITableViewDataSource_sectionIndexTitles(tableViewDataSourceId)
    local tableViewDataSource = AbstractDelegate.delegateForBindedId(tableViewDataSourceId);
    
    if tableViewDataSource and tableViewDataSource.proxyTable then
        
        local titles = tableViewDataSource.proxyTable:sectionIndexTitles(tableViewDataSource:sourceObject());
        if titles and titles.id then
            titles:retain();
            return titles:id();
        end
    end
end

function UITableViewDataSource_sectionForSectionIndexTitle(tableViewDataSourceId, title, index)
    local tableViewDataSource = AbstractDelegate.delegateForBindedId(tableViewDataSourceId);
    
    if tableViewDataSource and tableViewDataSource.proxyTable then
        
        local section = tableViewDataSource.proxyTable:sectionForSectionIndexTitle(tableViewDataSource:sourceObject(), title, tonumber(index));
        
        return section;
    end
end

function UITableViewDataSource_commitEditingStyle(tableViewDataSourceId, editingStyle, indexPathId)
    local tableViewDataSource = AbstractDelegate.delegateForBindedId(tableViewDataSourceId);
    
    if tableViewDataSource and tableViewDataSource.proxyTable then
        
        local indexPath = NSIndexPath:get(indexPathId);
        tableViewDataSource.proxyTable:commitEditingStyle(tableViewDataSource:sourceObject(), tonumber(editingStyle), indexPath);
        
    end
end

function UITableViewDataSource_moveRowAtIndexPath(tableViewDataSourceId, sourceIndexPathId, destinationIndexPathId)
    local tableViewDataSource = AbstractDelegate.delegateForBindedId(tableViewDataSourceId);
    
    if tableViewDataSource and tableViewDataSource.proxyTable then
        
        local sourceIndexPath = NSIndexPath:get(sourceIndexPathId);
        local destinationIndexPath = NSIndexPath:get(destinationIndexPathId);
        tableViewDataSource.proxyTable:moveRowAtIndexPath(tableViewDataSource:sourceObject(), sourceIndexPath, destinationIndexPath);
        
    end
end
