-- print object
function po(object)
    if not object then
        print("nil");
        return;
    end
    if object.id then
        utils::printObject(object:id());
    else
        utils::printObject(object);
    end
end

-- print objc object properties
function pd(object)
    if object.id then
        utils::printObjectDescription(object:id());
    else
        utils::printObjectDescription(object);
    end
end

-- safty release
function safety_release(obj)
    if obj and obj.release then
        obj:release();
    end
end

function safety_release_list(list)
    for i, v in pairs(list) do
        safety_release(obj);
    end
end

-- convert lua bool to objc bool
function toObjCBool(b)
    if b ~= nil then
        if b then
            return "YES";
        else
            return "NO";
        end
    else
        return "NO";
    end
end

-- common language utils
function toLuaBool(b)
    return b == "YES" or b == "true";
end

function isObjCObject(objId)
    return utils::isObjCObject(objId);
end

function newObjCObject(className)
    local objId = runtime::invokeClassMethod(className, "new");
    if string.len(objId) ~= 0 then
        runtime::invokeMethod(objId, "autorelease");
        runtime::releaseObject(objId);
        return objId;
    end
    return nil;
end

function toCStruct(...)
    local str = "";
    for i, v in pairs(arg) do
        if i ~= 'n' then
            str = str..","..v
        end
    end
    local strLen = string.len(str);
    if strLen ~= 0 then
        str = string.sub(str, 2, strLen);
    end
    
    return str;
end

function unpackCStruct(struct)
    return unpack(stringTableToNumberTable(stringSplit(struct, ",")));
end

function stringSplit(str, split_char)
    local sub_str_tab = {};
    while (true) do
        local pos = string.find(str, split_char);
        if (not pos) then
            sub_str_tab[#sub_str_tab + 1] = str;
            break;
        end
        local sub_str = string.sub(str, 1, pos - 1);
        sub_str_tab[#sub_str_tab + 1] = sub_str;
        str = string.sub(str, pos + 1, #str);
    end
    
    return sub_str_tab;
end

function stringTableToNumberTable(tbl)
    for i = 1, #tbl do
        tbl[i] = tonumber(tbl[i]);
    end
    return tbl;
end

-- print table
local print = print
local tconcat = table.concat
local tinsert = table.insert
local srep = string.rep
local type = type
local pairs = pairs
local tostring = tostring
local next = next
 
function print_r(root)
	local cache = {  [root] = "." }
	local function _dump(t,space,name)
		local temp = {}
		for k,v in pairs(t) do
			local key = tostring(k)
			if cache[v] then
				tinsert(temp,"+" .. key .. " {" .. cache[v].."}")
			elseif type(v) == "table" then
				local new_key = name .. "." .. key
				cache[v] = new_key
				tinsert(temp,"+" .. key .. _dump(v,space .. (next(t,k) and "|" or " " ).. srep(" ",#key),new_key))
			else
				tinsert(temp,"+" .. key .. " [" .. tostring(v).."]")
			end
		end
		return tconcat(temp,"\n"..space)
	end
	print(_dump(root, "",""))
end