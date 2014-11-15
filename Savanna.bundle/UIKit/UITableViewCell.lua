require "UIView"
require "UILabel"
require "UIImageView"
require "AppContext"

class(UITableViewCell, UIView);

-- constructor
function UITableViewCell:create(reuseIdentifier, style--[[option]])
    if reuseIdentifier == nil then
        return nil;
    end
    if not style then
        style = 1;
    end
    self = self:get(runtime::invokeClassMethod("LITableViewCell", "create:style:reuseIdentifier:", AppContext.current() ,style, reuseIdentifier));
    
    return self;
end

-- instance methods
function UITableViewCell:textLabel()
    return UILabel:get(runtime::invokeMethod(self:id(), "textLabel"));
end

function UITableViewCell:detailTextLabel()
    return UILabel:get(runtime::invokeMethod(self:id(), "detailTextLabel"));
end

function UITableViewCell:contentView()
    local viewId = runtime::invokeMethod(self:id(), "contentView");
    
    return UIView:get(viewId);
end

function UITableViewCell:imageView()
    local imageViewId = runtime::invokeMethod(self:id(), "imageView");
    return UIImageView:get(imageViewId);
end

function UITableViewCell:setAccessoryType(accessoryType)
    runtime::invokeMethod(self:id(), "setAccessoryType", accessoryType);
end

function UITableViewCell:accessoryType()
    return runtime::invokeMethod(self:id(), "accessoryType");
end

function UITableViewCell:backgroundView()
    return UIView:get(runtime::invokeMethod(self:id(), "backgroundView"));
end

function UITableViewCell:setBackgroundView(view)
    if view then
        view = view:id();
    end
    runtime::invokeMethod(self:id(), "setBackgroundView:", view);
end

function UITableViewCell:selectedBackgroundView()
    return UIView:get(runtime::invokeMethod(self:id(), "selectedBackgroundView"));
end

function UITableViewCell:setSelectedBackgroundView(view)
    if view then
        view = view:id();
    end
    runtime::invokeMethod(self:id(), "setSelectedBackgroundView:", view);
end

function UITableViewCell:indentationLevel()
    return tonumber(runtime::invokeMethod(self:id(), "indentationLevel"));
end

function UITableViewCell:setIndentationLevel(indentationLevel)
    runtime::invokeMethod(self:id(), "setIndentationLevel:", indentationLevel);
end

function UITableViewCell:indentationWidth()
    return tonumber(runtime::invokeMethod(self:id(), "indentationLevel"));
end

function UITableViewCell:setIndentationWidth(indentationWidth)
    runtime::invokeMethod(self:id(), "setIndentationWidth:", indentationWidth);
end

function UITableViewCell:selectionStyle()
    return tonumber(runtime::invokeMethod(self:id(), "selectionStyle"));
end

function UITableViewCell:setSelectionStyle(selectionStyle)
    runtime::invokeMethod(self:id(), "setSelectionStyle:", selectionStyle);
end

function UITableViewCell:selected()
    return toLuaBool(runtime::invokeMethod(self:id(), "isSelected"));
end

function UITableViewCell:setSelected(selected)
    runtime::invokeMethod(self:id(), "setSelected:", toObjCBool(selected));
end
