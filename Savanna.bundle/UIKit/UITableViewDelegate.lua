require "AppContext"
require "AbstractDelegate"
require "UIScrollViewDelegate"

class(UITableViewDelegate, UIScrollViewDelegate);

function UITableViewDelegate:create(tableView, proxyTable)
    self = self:get(runtime::invokeClassMethod("LITableViewDelegate", "create:", AppContext.current()));
    self:setSourceObject(tableView);
    self:initProxyTable(proxyTable);
    runtime::invokeMethod(tableView:id(), "setDelegate:", self:id());
    
    return self;
end

function UITableViewDelegate:removeDelegate()
    super:removeDelegate();
    runtime::invokeMethod(self:sourceObject():id(), "setDelegate:", nil);
end

function UITableViewDelegate:initProxyTable(proxyTable)
    super:initProxyTable(proxyTable);
    if proxyTable then
        if proxyTable.willDisplayCell then
            runtime::invokeMethod(self:id(), "setWillDisplayCell:", "UITableViewDelegate_willDisplayCell");
        else
            runtime::invokeMethod(self:id(), "setWillDisplayCell:", "");
        end
        
        if proxyTable.willDisplayHeaderView then
            runtime::invokeMethod(self:id(), "setWillDisplayHeaderView:", "UITableViewDelegate_willDisplayHeaderView");
        else
            runtime::invokeMethod(self:id(), "setWillDisplayHeaderView:", "");
        end
        
        if proxyTable.willDisplayFooterView then
            runtime::invokeMethod(self:id(), "setWillDisplayFooterView:", "UITableViewDelegate_willDisplayFooterView");
        else
            runtime::invokeMethod(self:id(), "setWillDisplayFooterView:", "");
        end
        
        if proxyTable.willDisplayCell then
            runtime::invokeMethod(self:id(), "setDidEndDisplayingCell:", "UITableViewDelegate_didEndDisplayingCell");
        else
            runtime::invokeMethod(self:id(), "setDidEndDisplayingCell:", "");
        end
        
        if proxyTable.didEndDisplayingHeaderView then
            runtime::invokeMethod(self:id(), "setDidEndDisplayingHeaderView:", "UITableViewDelegate_didEndDisplayingHeaderView");
        else
            runtime::invokeMethod(self:id(), "setDidEndDisplayingHeaderView:", "");
        end
        
        if proxyTable.didEndDisplayingFooterView then
            runtime::invokeMethod(self:id(), "setDidEndDisplayingFooterView:", "UITableViewDelegate_didEndDisplayingFooterView");
        else
            runtime::invokeMethod(self:id(), "setDidEndDisplayingFooterView:", "");
        end
        
        if proxyTable.heightForRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setHeightForRowAtIndexPath:", "UITableViewDelegate_heightForRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setHeightForRowAtIndexPath:", "");
        end
        
        if proxyTable.heightForHeaderInSection then
            runtime::invokeMethod(self:id(), "setHeightForHeaderInSection:", "UITableViewDelegate_heightForHeaderInSection");
        else
            runtime::invokeMethod(self:id(), "setHeightForHeaderInSection:", "");
        end
        
        if proxyTable.heightForFooterInSection then
            runtime::invokeMethod(self:id(), "setHeightForFooterInSection:", "UITableViewDelegate_heightForFooterInSection");
        else
            runtime::invokeMethod(self:id(), "setHeightForFooterInSection:", "");
        end
        
        if proxyTable.viewForHeaderInSection then
            runtime::invokeMethod(self:id(), "setViewForHeaderInSection:", "UITableViewDelegate_viewForHeaderInSection");
        else
            runtime::invokeMethod(self:id(), "setViewForHeaderInSection:", "");
        end
        
        if proxyTable.viewForFooterInSection then
            runtime::invokeMethod(self:id(), "setViewForFooterInSection:", "UITableViewDelegate_viewForFooterInSection");
        else
            runtime::invokeMethod(self:id(), "setViewForFooterInSection:", "");
        end
        
        if proxyTable.accessoryButtonTappedForRowWithIndexPath then
            runtime::invokeMethod(self:id(), "setAccessoryButtonTappedForRowWithIndexPath:",
                                  "UITableViewDelegate_accessoryButtonTappedForRowWithIndexPath");
        else
            runtime::invokeMethod(self:id(), "setAccessoryButtonTappedForRowWithIndexPath:","");
        end
        
        if proxyTable.shouldHighlightRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setShouldHighlightRowAtIndexPath:", "UITableViewDelegate_shouldHighlightRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setShouldHighlightRowAtIndexPath:", "");
        end
        
        if proxyTable.didHighlightRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setDidHighlightRowAtIndexPath:", "UITableViewDelegate_didHighlightRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setDidHighlightRowAtIndexPath:", "");
        end
        
        if proxyTable.didUnhighlightRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setDidUnhighlightRowAtIndexPath:", "UITableViewDelegate_didUnhighlightRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setDidUnhighlightRowAtIndexPath:", "");
        end
        
        if proxyTable.willSelectRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setWillSelectRowAtIndexPath:", "UITableViewDelegate_willSelectRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setWillSelectRowAtIndexPath:", "");
        end
        
        if proxyTable.willDeselectRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setWillDeselectRowAtIndexPath:", "UITableViewDelegate_willDeselectRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setWillDeselectRowAtIndexPath:", "");
        end
        
        if proxyTable.didSelectRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setDidSelectRowAtIndexPath:", "UITableViewDelegate_didSelectRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setDidSelectRowAtIndexPath:", "");
        end
        
        if proxyTable.didDeselectRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setDidDeselectRowAtIndexPath:", "UITableViewDelegate_didDeselectRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setDidDeselectRowAtIndexPath:", "");
        end
        
        if proxyTable.editingStyleForRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setEditingStyleForRowAtIndexPath:", "UITableViewDelegate_editingStyleForRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setEditingStyleForRowAtIndexPath:", "");
        end
        
        if proxyTable.titleForDeleteConfirmationButtonForRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setTitleForDeleteConfirmationButtonForRowAtIndexPath:", "UITableViewDelegate_titleForDeleteConfirmationButtonForRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setTitleForDeleteConfirmationButtonForRowAtIndexPath:", "");
        end
        
        if proxyTable.shouldIndentWhileEditingRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setShouldIndentWhileEditingRowAtIndexPath:", "UITableViewDelegate_shouldIndentWhileEditingRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setShouldIndentWhileEditingRowAtIndexPath:", "");
        end
        
        if proxyTable.willBeginEditingRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setWillBeginEditingRowAtIndexPath:", "UITableViewDelegate_willBeginEditingRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setWillBeginEditingRowAtIndexPath:", "");
        end
        
        if proxyTable.didEndEditingRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setDidEndEditingRowAtIndexPath:", "UITableViewDelegate_didEndEditingRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setDidEndEditingRowAtIndexPath:", "");
        end
        
        if proxyTable.targetIndexPathForMoveFromRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setTargetIndexPathForMoveFromRowAtIndexPath:", "UITableViewDelegate_targetIndexPathForMoveFromRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setTargetIndexPathForMoveFromRowAtIndexPath:", "");
        end
        
        if proxyTable.indentationLevelForRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setIndentationLevelForRowAtIndexPath:", "UITableViewDelegate_indentationLevelForRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setIndentationLevelForRowAtIndexPath:", "");
        end
        
        if proxyTable.shouldShowMenuForRowAtIndexPath then
            runtime::invokeMethod(self:id(), "setShouldShowMenuForRowAtIndexPath:", "UITableViewDelegate_shouldShowMenuForRowAtIndexPath");
        else
            runtime::invokeMethod(self:id(), "setShouldShowMenuForRowAtIndexPath:", "");
        end
    end
end

function UITableViewDelegate:willDisplayCell(tableView, cell, indexPath)
end

function UITableViewDelegate:willDisplayHeaderView(tableView, view, section)
end

function UITableViewDelegate:willDisplayFooterView(tableView, view, section)
end

function UITableViewDelegate:didEndDisplayingCell(tableView, cell, indexPath)
end

function UITableViewDelegate:didEndDisplayingHeaderView(tableView, view, section)
end

function UITableViewDelegate:didEndDisplayingFooterView(tableView, view, section)
end

function UITableViewDelegate:heightForRowAtIndexPath(tableView, indexPath)
end

function UITableViewDelegate:heightForHeaderInSection(tableView, section)
end

function UITableViewDelegate:heightForFooterInSection(tableView, section)
end

function UITableViewDelegate:viewForHeaderInSection(tableView, section)
end

function UITableViewDelegate:viewForFooterInSection(tableView, section)
end

function UITableViewDelegate:accessoryButtonTappedForRowWithIndexPath(tableView, indexPath)
end

function UITableViewDelegate:shouldHighlightRowAtIndexPath(tableView, indexPath)
end

function UITableViewDelegate:didHighlightRowAtIndexPath(tableView, indexPath)
end

function UITableViewDelegate:didUnhighlightRowAtIndexPath(tableView, indexPath)
end

function UITableViewDelegate:willSelectRowAtIndexPath(tableView, indexPath)
end

function UITableViewDelegate:willDeselectRowAtIndexPath(tableView, indexPath)
end

function UITableViewDelegate:didSelectRowAtIndexPath(tableView, indexPath)
end

function UITableViewDelegate:didDeselectRowAtIndexPath(tableView, indexPath)
end

function UITableViewDelegate:editingStyleForRowAtIndexPath(tableView, indexPath)
end

function UITableViewDelegate:titleForDeleteConfirmationButtonForRowAtIndexPath(tableView, indexPath)
end

function UITableViewDelegate:shouldIndentWhileEditingRowAtIndexPath(tableView, indexPath)
end

function UITableViewDelegate:willBeginEditingRowAtIndexPath(tableView, indexPath)
end

function UITableViewDelegate:didEndEditingRowAtIndexPath(tableView, indexPath)
end

function UITableViewDelegate:targetIndexPathForMoveFromRowAtIndexPath(tableView, sourceIndexPath, proposedDestinationIndexPath)
end

function UITableViewDelegate:indentationLevelForRowAtIndexPath(tableView, indexPath)
end

function UITableViewDelegate:shouldShowMenuForRowAtIndexPath(tableView, indexPath)
end

function UITableViewDelegate_willDisplayCell(tableViewDelegateId, cellId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        tbDelegate.proxyTable:willDisplayCell(tbDelegate:sourceObject(), UITableViewCell:get(cellId), NSIndexPath:get(indexPathId));
        
    end
end

function UITableViewDelegate_willDisplayHeaderView(tableViewDelegateId, viewId, section)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        tbDelegate.proxyTable:willDisplayHeaderView(tbDelegate:sourceObject(), UIView:get(viewId), section);
        
    end
end

function UITableViewDelegate_willDisplayFooterView(tableViewDelegateId, viewId, section)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        tbDelegate.proxyTable:willDisplayFooterView(tbDelegate:sourceObject(), UIView:get(viewId), section);
        
    end
end

function UITableViewDelegate_didEndDisplayingCell(tableViewDelegateId, cellId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        tbDelegate.proxyTable:didEndDisplayingCell(tbDelegate:sourceObject(), UITableViewCell:get(cellId), NSIndexPath:get(indexPathId));
        
    end
end

function UITableViewDelegate_didEndDisplayingHeaderView(tableViewDelegateId, viewId, section)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        tbDelegate.proxyTable:didEndDisplayingHeaderView(tbDelegate:sourceObject(), UIView:get(viewId), section);
        
    end
end

function UITableViewDelegate_didEndDisplayingFooterView(tableViewDelegateId, viewId, section)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        tbDelegate.proxyTable:didEndDisplayingFooterView(tbDelegate:sourceObject(), UIView:get(viewId), section);
        
    end
end

function UITableViewDelegate_heightForRowAtIndexPath(tableViewDelegateId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        local height = tbDelegate.proxyTable:heightForRowAtIndexPath(tbDelegate:sourceObject(), NSIndexPath:get(indexPathId));
        
        return height;
    end
end

function UITableViewDelegate_heightForHeaderInSection(tableViewDelegateId, section)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        local height = tbDelegate.proxyTable:heightForHeaderInSection(tbDelegate:sourceObject(), section);
        
        return height;
    end
end

function UITableViewDelegate_heightForFooterInSection(tableViewDelegateId, section)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        local height = tbDelegate.proxyTable:heightForFooterInSection(tbDelegate:sourceObject(), section);
        
        return height;
    end
end

function UITableViewDelegate_viewForHeaderInSection(tableViewDelegateId, section)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        local view = tbDelegate.proxyTable:viewForHeaderInSection(tbDelegate:sourceObject(), section);
        local viewId = "";
        if view and view.id then
            view:retain();
            viewId = view:id();
        end
        
        return viewId;
    end
end

function UITableViewDelegate_viewForFooterInSection(tableViewDelegateId, section)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        local view = tbDelegate.proxyTable:viewForFooterInSection(tbDelegate:sourceObject(), section);
        local viewId = "";
        if view and view.id then
            view:retain()
            viewId = view:id();
        end
        
        return viewId;
    end
end

function UITableViewDelegate_accessoryButtonTappedForRowWithIndexPath(tableViewDelegateId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        tbDelegate.proxyTable:accessoryButtonTappedForRowWithIndexPath(tbDelegate:sourceObject(), NSIndexPath:get(indexPathId));
        
    end
end

function UITableViewDelegate_shouldHighlightRowAtIndexPath(tableViewDelegateId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        local should = toObjCBool(tbDelegate.proxyTable:shouldHighlightRowAtIndexPath(tbDelegate:sourceObject(), NSIndexPath:get(indexPathId)));
        
        return should;
    end
end

function UITableViewDelegate_didHighlightRowAtIndexPath(tableViewDelegateId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        tbDelegate.proxyTable:didHighlightRowAtIndexPath(tbDelegate:sourceObject(), NSIndexPath:get(indexPathId));
        
    end
end

function UITableViewDelegate_didUnhighlightRowAtIndexPath(tableViewDelegateId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        tbDelegate.proxyTable:didUnhighlightRowAtIndexPath(tbDelegate:sourceObject(), NSIndexPath:get(indexPathId));
        
    end
end

function UITableViewDelegate_willSelectRowAtIndexPath(tableViewDelegateId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        local newIndexPath = tbDelegate.proxyTable:willSelectRowAtIndexPath(tbDelegate:sourceObject(), NSIndexPath:get(indexPathId));
        local newIndexPathId = "";
        if newIndexPath and newIndexPath.id then
            newIndexPath:retain();
            newIndexPathId = newIndexPath:id();
        end
        
        return newIndexPathId;
    end
end

function UITableViewDelegate_willDeselectRowAtIndexPath(tableViewDelegateId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        local newIndexPath = tbDelegate.proxyTable:willDeselectRowAtIndexPath(tbDelegate:sourceObject(), NSIndexPath:get(indexPathId));
        local newIndexPathId = "";
        if newIndexPath and newIndexPath.id then
            newIndexPath:retain();
            newIndexPathId = newIndexPath:id();
        end
        
        return newIndexPathId;
    end
end

function UITableViewDelegate_didSelectRowAtIndexPath(tableViewDelegateId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        tbDelegate.proxyTable:didSelectRowAtIndexPath(tbDelegate:sourceObject(), NSIndexPath:get(indexPathId));
        
    end
end

function UITableViewDelegate_didDeselectRowAtIndexPath(tableViewDelegateId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        tbDelegate.proxyTable:didDeselectRowAtIndexPath(tbDelegate:sourceObject(), NSIndexPath:get(indexPathId));
        
    end
end

function UITableViewDelegate_editingStyleForRowAtIndexPath(tableViewDelegateId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        local style = tbDelegate.proxyTable:editingStyleForRowAtIndexPath(tbDelegate:sourceObject(), NSIndexPath:get(indexPathId));
        
        return style;
    end
end

function UITableViewDelegate_titleForDeleteConfirmationButtonForRowAtIndexPath(tableViewDelegateId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        local title = tbDelegate.proxyTable:titleForDeleteConfirmationButtonForRowAtIndexPath(tbDelegate:sourceObject(), NSIndexPath:get(indexPathId));
        
        return title;
    end
end

function UITableViewDelegate_shouldIndentWhileEditingRowAtIndexPath(tableViewDelegateId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        local should = toObjCBool(tbDelegate.proxyTable:shouldIndentWhileEditingRowAtIndexPath(tbDelegate:sourceObject(), NSIndexPath:get(indexPathId)));
        
        return should;
    end
end

function UITableViewDelegate_willBeginEditingRowAtIndexPath(tableViewDelegateId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        tbDelegate.proxyTable:willBeginEditingRowAtIndexPath(tbDelegate:sourceObject(), NSIndexPath:get(indexPathId));
        
    end
end

function UITableViewDelegate_didEndEditingRowAtIndexPath(tableViewDelegateId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        tbDelegate.proxyTable:didEndEditingRowAtIndexPath(tbDelegate:sourceObject(), NSIndexPath:get(indexPathId));
        
    end
end

function UITableViewDelegate_targetIndexPathForMoveFromRowAtIndexPath(tableViewDelegateId, sourceIndexPathId, destinationIndexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        local resultIndexPath = tbDelegate.proxyTable:targetIndexPathForMoveFromRowAtIndexPath(tbDelegate:sourceObject(),
                                                                                               NSIndexPath:get(sourceIndexPathId),
                                                                                               NSIndexPath:get(destinationIndexPathId));
        local resultIndexPathId = "";
        if resultIndexPath and resultIndexPath.id then
            resultIndexPath:retain();
            resultIndexPathId = resultIndexPath:id();
        end
        
        return resultIndexPathId;
    end
end

function UITableViewDelegate_indentationLevelForRowAtIndexPath(tableViewDelegateId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        local level = tbDelegate.proxyTable:indentationLevelForRowAtIndexPath(tbDelegate:sourceObject(), NSIndexPath:get(indexPathId));
        
        return level;
    end
end

function UITableViewDelegate_shouldShowMenuForRowAtIndexPath(tableViewDelegateId, indexPathId)
    local tbDelegate = AbstractDelegate.delegateForBindedId(tableViewDelegateId);
    
    if tbDelegate and tbDelegate.proxyTable then
        
        local should = toObjCBool(tbDelegate.proxyTable:shouldShowMenuForRowAtIndexPath(tbDelegate:sourceObject(), NSIndexPath:get(indexPathId)));
        
        return should;
    end
end




