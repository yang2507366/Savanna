require "AppContext"
require "UIView"
require "UIPickerViewDelegate"

class(UIPickerView, UIView);

function UIPickerView:create()
    self = self:get(runtime::invokeClassMethod("LIPickerView", "create:", AppContext.current()));
    
    UIPickerViewEventProxyTable[self:id()] = self;
    
    return self;
end

function UIPickerView:dealloc()
    UIPickerViewEventProxyTable[self:id()] = nil;
    super:dealloc();
end

-- instance methods
function UIPickerView:setDelegate(delegate)
    self.delegate = delegate;
    
    if delegate.titleForRowForComponent then
        runtime::invokeMethod(self:id(), "setTitleForRowForComponentFunc:", "UIPickerView_titleForRowForComponent");
    else
        runtime::invokeMethod(self:id(), "setTitleForRowForComponentFunc:", "");
    end
    
    if delegate.didSelectRowInComponent then
        runtime::invokeMethod(self:id(), "setDidSelectRowInComponentFunc:", "UIPickerView_didSelectRowInComponent");
    else
        runtime::invokeMethod(self:id(), "setDidSelectRowInComponentFunc:", "");
    end
    
    if delegate.rowHeightForComponent then
        runtime::invokeMethod(self:id(), "setRowHeightForComponentFunc:", "UIPickerView_rowHeightForComponent");
    else
        runtime::invokeMethod(self:id(), "setRowHeightForComponentFunc:", "");
    end
    
    if delegate.viewForRowForComponentReusingView then
        runtime::invokeMethod(self:id(), "setViewForRowForComponentReusingViewFunc:", "UIPickerView_viewForRowForComponentReusingView");
    else
        runtime::invokeMethod(self:id(), "setViewForRowForComponentReusingViewFunc:", "");
    end
end

function UIPickerView:setDataSource(dataSource)
    self.dataSource = dataSource;
    
    if dataSource.numberOfComponents then
        runtime::invokeMethod(self:id(), "setNumberOfComponentsFunc:", "UIPickerView_numberOfComponents");
        else
        runtime::invokeMethod(self:id(), "setNumberOfComponentsFunc:", "");
    end
    
    if dataSource.numberOfRowsInComponent then
        runtime::invokeMethod(self:id(), "setNumberOfRowsInComponentFunc:", "UIPickerView_numberOfRowsInComponent");
        else
        runtime::invokeMethod(self:id(), "setNumberOfRowsInComponentFunc:", "");
    end
end

function UIPickerView:setShowsSelectionIndicator(show)
    runtime::invokeMethod(self:id(), "setShowsSelectionIndicator:", toObjCBool(show));
end

function UIPickerView:showsSelectionIndicator()
    return toLuaBool(runtime::invokeMethod(self:id(), "showsSelectionIndicator"));
end

function UIPickerView:numberOfComponents()
    return runtime::invokeMethod(self:id(), "numberOfComponents");
end

function UIPickerView:numberOfRowsInComponent(component)
    return runtime::invokeMethod(self:id(), "numberOfRowsInComponent:", component);
end

function UIPickerView:reloadAllComponents()
    runtime::invokeMethod(self:id(), "reloadAllComponents");
end

function UIPickerView:rowSizeForComponent(component)
    return unpackCStruct(runtime::invokeMethod(self:id(), "rowSizeForComponent:", component));
end

function UIPickerView:selectedRowInComponent(component)
    return tonumber(runtime::invokeMethod(self:id(), "selectedRowInComponent:", component));
end

function UIPickerView:selectRowInComponentAnimated(row, component, animated)
    runtime::invokeMethod(self:id(), "selectRow:inComponent:animated:", row, component, toObjCBool(animated));
end

function UIPickerView:viewForRowForComponent(row, component)
    local viewId = runtime::invokeMethod(self:id(), "viewForRow:forComponent:", row, component);
    if string.len(viewId) ~= 0 then
        return UIView:get(viewId);
    end
end

-- event proxy
UIPickerViewEventProxyTable = {};
function UIPickerView_numberOfComponents(pvId)
    local pv = UIPickerViewEventProxyTable[pvId];
    if pv and pv.dataSource then
        local num = pv.dataSource:numberOfComponents(pv);
        return num;
    end
    return 0;
end

function UIPickerView_numberOfRowsInComponent(pvId, component)
    local pv = UIPickerViewEventProxyTable[pvId];
    if pv and pv.dataSource then
        local num = pv.dataSource:numberOfRowsInComponent(pv, component);
        return num;
    end
    return 0;
end

function UIPickerView_widthForComponent(pvId, component)
    local pv = UIPickerViewEventProxyTable[pvId];
    if pv then
        local width = pv:widthForComponent(pv, component);
        return width;
    end
    return 0;
end

function UIPickerView_rowHeightForComponent(pvId, component)
    local pv = UIPickerViewEventProxyTable[pvId];
    if pv and pv.delegate then
        local height = pv.delegate:rowHeightForComponent(pv, component);
        return height;
    end
    return 0;
end

function UIPickerView_titleForRowForComponent(pvId, row, component)
    local pv = UIPickerViewEventProxyTable[pvId];
    if pv and pv.delegate then
        local title = pv.delegate:titleForRowForComponent(pv, row, component);
        return title;
    end
end

function UIPickerView_attributedTitleForRowForComponent(pvId, row, component)
    return nil;
end

function UIPickerView_viewForRowForComponentReusingView(pvId, row, component, reusingView)
    local pv = UIPickerViewEventProxyTable[pvId];
    if pv and pv.delegate then
        if string.len(reusingView) ~= 0 then
            reusingView = UIView:get(reusingView);
        else
            reusingView = nil;
        end
        local view = pv.delegate:viewForRowForComponentReusingView(pv, row, component, reusingView);
        local viewId = "";
        if view then
            viewId = view:id();
        end
        return viewId;
    end
end

function UIPickerView_didSelectRowInComponent(pvId, row, component)
    local pv = UIPickerViewEventProxyTable[pvId];
    if pv and pv.delegate then
        pv.delegate:didSelectRowInComponent(pv, row, component);
    end
end







