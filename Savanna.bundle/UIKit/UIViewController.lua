require "Object"
require "UIView"
require "UINavigationItem"
require "AppContext"
require "CommonUtils"
require "NSArray"
require "UINavigationBar"
require "UIToolbar"
require "StringUtils"

class(UIViewController);
class(UINavigationController, UIViewController);
class(UITabBarController, UIViewController);
class(UITabBarControllerDelegate);

-- constructor
function UIViewController:create(title)
    if title == nil then
        title = "Untitled";
    end
    self = self:get(runtime::invokeClassMethod("LIViewController", "create:", AppContext.current()));
    self:setTitle(title);

    UIViewControllerEventProxyTable[self:id()] = self;
    runtime::invokeMethod(self:id(), "set_loadView", "UIViewController_loadView");
    runtime::invokeMethod(self:id(), "set_viewDidLoad", "UIViewController_viewDidLoad");
    runtime::invokeMethod(self:id(), "set_viewWillAppear", "UIViewController_viewWillAppear");
    runtime::invokeMethod(self:id(), "set_viewDidAppear", "UIViewController_viewDidAppear");
    runtime::invokeMethod(self:id(), "set_viewWillDisappear", "UIViewController_viewWillDisappear");
    runtime::invokeMethod(self:id(), "set_viewDidDisappear", "UIViewController_viewDidDisappear");
    runtime::invokeMethod(self:id(), "set_viewDidPop", "UIViewController_viewDidPop");
    runtime::invokeMethod(self:id(), "set_viewDidDismiss", "UIViewController_viewDidDismiss");
    runtime::invokeMethod(self:id(), "set_didReceiveMemoryWarning", "UIViewController_didReceiveMemoryWarning");
    runtime::invokeMethod(self:id(), "set_shouldAutorotate", "UIViewController_shouldAutorotate");
    runtime::invokeMethod(self:id(), "set_supportedInterfaceOrientations", "UIViewController_supportedInterfaceOrientations");
    runtime::invokeMethod(self:id(), "set_canPerformAction", "UIViewController_canPerformAction");
    
    return self;
end

function UIViewController:dealloc()
    UIViewControllerEventProxyTable[self:id()] = nil;
    super:dealloc();
end

-- instance methods
function UIViewController:setAsRootViewController()
    ui::setRootViewController(vcId);
end

function UIViewController.relatedNavigationController()
    local relatedVCId = ui::getRelatedViewController();
    if string.len(relatedVCId) ~= 0 and Object.objectIsKindOfClass(relatedVCId, "UINavigationController") then
        return UINavigationController:get(relatedVCId);
    end
    return nil;
end

function UIViewController.relatedViewController()
    return UIViewController:get(ui::getRelatedViewController());
end

function UIViewController:pushToRelatedViewController()
    local relatedVCId = ui::getRelatedViewController();
    if self.relatedNavigationController() ~= nil then
        self.relatedNavigationController():pushViewController(self, true);
    elseif string.len(relatedVCId) ~= 0 then
        UIViewController:get(relatedVCId):navigationController():pushViewController(self, true);
    else
        self:setAsRootViewController();
    end
end

function UIViewController:presentViewController(vc, animated)
    local currentDevice = runtime::invokeClassMethod("UIDevice", "currentDevice");
    local systemVersion = runtime::invokeMethod(currentDevice, "systemVersion");
    runtime::releaseObject(currentDevice);
    if StringUtils.compare(systemVersion, "compare:", "5.0") == -1 then
        runtime::invokeMethod(self:id(), "presentModalViewController:animated:", vc:id(), toObjCBool(animated));
    else
        runtime::invokeMethod(self:id(), "presentViewController:animated:completion:", vc:id(), toObjCBool(animated));
    end
    runtime::releaseObject(currentDevice);
end

function UIViewController:dismissViewController(animated)
    local currentDevice = runtime::invokeClassMethod("UIDevice", "currentDevice");
    local systemVersion = runtime::invokeMethod(currentDevice, "systemVersion");
    runtime::releaseObject(currentDevice);
    if StringUtils.compare(systemVersion, "compare:", "5.0") == -1 then
        runtime::invokeMethod(self:id(), "dismissModalViewControllerAnimated:", toObjCBool(animated));
    else
        runtime::invokeMethod(self:id(), "dismissViewControllerAnimated:completion:", toObjCBool(animated));
    end
end

function UIViewController:view()
    local viewId = runtime::invokeMethod(self:id(), "view");

    return UIView:get(viewId);
end

function UIViewController:navigationItem()
    local naviItemId = runtime::invokeMethod(self:id(), "navigationItem");
    return UINavigationItem:get(naviItemId);
end

function UIViewController:navigationController()
    local ncId = runtime::invokeMethod(self:id(), "navigationController");
    return UINavigationController:get(ncId);
end

function UIViewController:setWaiting(waiting)
    
    if waiting then
        runtime::invokeClassMethod("LIWaiting", "showWaiting:inView:", "YES", self:view():id());
    else
        runtime::invokeClassMethod("LIWaiting", "showWaiting:inView:", "NO", self:view():id());
    end
    
end

function UIViewController:setLoading(loading)
    if loading then
        runtime::invokeClassMethod("LIWaiting", "showLoading:inView:", "YES", self:view():id());
    else
        runtime::invokeClassMethod("LIWaiting", "showLoading:inView:", "NO", self:view():id());
    end
    
end

function UIViewController:setTitle(title)
    runtime::invokeMethod(self:id(), "setTitle:", title);
end

function UIViewController:title()
    return runtime::invokeMethod(self:id(), "title");
end

function UIViewController:setHidesBottomBarWhenPushed(hide)
    runtime::invokeMethod(self:id(), "setHidesBottomBarWhenPushed:", toObjCBool(hide));
end

function UIViewController:setToolbarItems(items)
    runtime::invokeMethod(self:id(), "setToolbarItems:", items:id());
end

function UIViewController:toolbarItems()
    local objId = runtime::invokeMethod(self:id(), "toolbarItems");
    if string.len(objId) ~= 0 then
        return NSArray:get(objId);
    end
end

function UIViewController:tabBarController()
    local tabBarId = runtime::invokeMethod(self:id(), "tabBarController");
    return UITabBarController:get(tabBarId);
end

-- override methods
function UIViewController:loadView()
end

function UIViewController:viewDidLoad()
end

function UIViewController:viewWillAppear()
end

function UIViewController:viewDidAppear()
end

function UIViewController:viewWillDisappear()
end

function UIViewController:viewDidDisappear()
end

function UIViewController:didReceiveMemoryWarning()
end

function UIViewController:canPerformAction(actionName, senderId)
    return toLuaBool(runtime::invokeMethod(self:id(), "defaultPerformAction:withSender:", actionName, senderId));
end

function UIViewController:shouldAutorotate()
    return false;
end

function UIViewController:supportedInterfaceOrientations()
    return 30;--UIInterfaceOrientationMaskAll
end

function UIViewController:viewDidPop()
    
end

function UIViewController:viewDidDismiss()
    
end

function UIViewController:contentSizeForViewInPopover()
    return unpackCStruct(runtime::invokeMethod(self:id(), "contentSizeForViewInPopover"));
end

function UIViewController:setContentSizeForViewInPopover(width, height)
    runtime::invokeMethod(self:id(), "setContentSizeForViewInPopover:", width..","..height);
end

-- event proxy

UIViewControllerEventProxyTable = {};

function UIViewController_loadView(vcId)
    local vc = UIViewControllerEventProxyTable[vcId];
    if vc then
        vc:loadView();
    end
end

function UIViewController_viewDidLoad(vcId)
    local vc = UIViewControllerEventProxyTable[vcId];
    if vc then
        vc:viewDidLoad();
    end
end

function UIViewController_viewWillAppear(vcId)
    local vc = UIViewControllerEventProxyTable[vcId];
    if vc then
        vc:viewWillAppear();
    end
end

function UIViewController_viewDidAppear(vcId)
    local vc = UIViewControllerEventProxyTable[vcId];
    if vc then
        vc:viewDidAppear();
    end
end

function UIViewController_viewWillDisappear(vcId)
    local vc = UIViewControllerEventProxyTable[vcId];
    if vc then
        vc:viewWillDisappear();
    end
end

function UIViewController_viewDidDisappear(vcId)
    local vc = UIViewControllerEventProxyTable[vcId];
    if vc then
        vc:viewDidDisappear();
    end
end

function UIViewController_didReceiveMemoryWarning(vcId)
    local vc = UIViewControllerEventProxyTable[vcId];
    if vc then
        vc:didReceiveMemoryWarning();
    end
end

function UIViewController_shouldAutorotate(vcId)
    local vc = UIViewControllerEventProxyTable[vcId];
    if vc then
        local should = toObjCBool(vc:shouldAutorotate());
        return should;
    end
end

function UIViewController_supportedInterfaceOrientations(vcId)
    local vc = UIViewControllerEventProxyTable[vcId];
    if vc then        
        local b = vc:supportedInterfaceOrientations();
        return b;
    end
end

function UIViewController_canPerformAction(vcId, actionName, senderId)
    local vc = UIViewControllerEventProxyTable[vcId];
    if vc then
        local b = vc:canPerformAction(actionName, senderId);
        return toObjCBool(b);
    end
    return toObjCBool(true);
end

function UIViewController_viewDidPop(vcId)
    local vc = UIViewControllerEventProxyTable[vcId];
    if vc then
        vc:viewDidPop();
    end
end
    
function UIViewController_viewDidDismiss(vcId)
    local vc = UIViewControllerEventProxyTable[vcId];
    if vc then
        vc:viewDidDismiss();
    end
end

--[[ --------------------------------------------------------------------------------------------------------------------------------- ]]
-- constructor
function UINavigationController:create(rootVc--[[option]])
    if rootVc ~= nil then
        local ncId = runtime::invokeClassMethod("LINavigationController", "create", AppContext.current());
        local nc = self:get(ncId);
        
        nc:pushViewController(rootVc, false);
        
        return nc;
    end
    return nil;
end

-- instance methods
function UINavigationController:pushViewController(vc, animated--[[option]])
    if animated == nil then
        animated = true;
    end
    runtime::invokeMethod(self:id(), "pushViewController:animated:", vc:id(), toObjCBool(animated));
end

function UINavigationController:toolbarHidden()
    return toLuaBool(runtime::invokeMethod(self:id(), "toolbarHidden"));
end

function UINavigationController:setToolbarHidden(hidden, animated)
    runtime::invokeMethod(self:id(), "setToolbarHidden:animated:", toObjCBool(hidden), toObjCBool(animated));
end

function UINavigationController:navigationBarHidden()
    return toLuaBool(runtime::invokeMethod(self:id(), "navigationBarHidden"));
end

function UINavigationController:setNavigationBarHidden(hidden, animated)
    runtime::invokeMethod(self:id(), "setNavigationBarHidden:animated", toObjCBool(hidden), toObjCBool(animated));
end

function UINavigationController:navigationBar()
    return UINavigationBar:get(runtime::invokeMethod(self:id(), "navigationBar"));
end

function UINavigationController:toolbar()
    return UIToolbar:get(runtime::invokeMethod(self:id(), "toolbar"));
end

--[[ --------------------------------------------------------------------------------------------------------------------------------- ]]
function UITabBarController:create()
    local objId = runtime::invokeClassMethod("LITabBarController", "create:", AppContext.current());
    return self:get(objId);
end

function UITabBarController:get(objId)
    local obj = super:get(objId);
    UITabBarControllerEventProxyTable[objId] = obj;
    
    return obj;
end

function UITabBarController:delloc()
    UITabBarControllerEventProxyTable[self:id()] = nil;
    super:dealloc();
end

function UITabBarController:setDelegate(delegate)
    self.delegate = delegate;
    
    if delegate and delegate.shouldSelectViewController then
        runtime::invokeMethod(self:id(), "setShouldSelectViewController:", "UITabBarController_shouldSelectViewController");
    else
        runtime::invokeMethod(self:id(), "setShouldSelectViewController:", "");
    end
    
    if delegate and delegate.didSelectViewController then
        runtime::invokeMethod(self:id(), "setDidSelectViewController:", "UITabBarController_didSelectViewController");
    else
        runtime::invokeMethod(self:id(), "setDidSelectViewController:", "");
    end
end

function UITabBarController:setViewControllers(viewControllers)
    runtime::invokeMethod(self:id(), "setViewControllers:", viewControllers:id());
end

function UITabBarController:viewControllers()
    local vcsId = runtime::invokeMethod(self:id(), "viewControllers");
    if string.len(vcsId) ~= 0 then
        return NSArray:get(vcsId);
    end
end

function UITabBarController:setSelectedIndex(selectedIndex)
    runtime::invokeMethod(self:id(), "setSelectedIndex:", selectedIndex);
end

function UITabBarController:selectedIndex()
    return tonumber(runtime::invokeMethod(self:id(), "selectedIndex"));
end


function UITabBarControllerDelegate:shouldSelectViewController(tabBarController)
    return true;
end

function UITabBarControllerDelegate:didSelectViewController(tabBarController)
end

UITabBarControllerEventProxyTable = {};

function UITabBarController_shouldSelectViewController(objId)
    local obj = UITabBarControllerEventProxyTable[objId];
    if obj and obj.delegate then
        return toObjCBool(obj.delegate:shouldSelectViewController(obj));
    end
end

function UITabBarController_didSelectViewController(objId)
    local obj = UITabBarControllerEventProxyTable[objId];
    if obj and obj.delegate then
        toObjCBool(obj.delegate:didSelectViewController(obj));
    end
end
