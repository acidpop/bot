--[[
    Telegram CLI 공통적으로 사용 하는 함수 정의
        2015.07.22
-- by http://blog.acidpop.kr
]]--


-- msg 라는 변수에 어떤 값이 있는지 확인 하기 위해 변수 내부를 출력하는 함수이다.
function vardump(value, depth, key)
    local linePrefix = ""
    local spaces = ""

    if key ~= nil then
    linePrefix = "["..key.."] = "
    end

    if depth == nil then
    depth = 0
    else
    depth = depth + 1
    for i=1, depth do spaces = spaces .. "  " end
    end

    if type(value) == 'table' then
        mTable = getmetatable(value)
    if mTable == nil then
        print(spaces ..linePrefix.."(table) ")
    else
        print(spaces .."(metatable) ")
        value = mTable
    end
    for tableKey, tableValue in pairs(value) do
        vardump(tableValue, depth, tableKey)
    end
    elseif type(value) == 'function' or 
        type(value) == 'thread' or 
        type(value) == 'userdata' or
        value == nil
    then
        print(spaces..tostring(value))
    else
        print(spaces..linePrefix.."("..type(value)..") "..tostring(value))
    end
end



-- Full Path 를 path, filename, extension 3종류로 나누는 기능
function splitfilename(strfilename)
   -- Returns the Path, Filename, and Extension as 3 values
  return string.match(strfilename, "(.-)([^\\]-([^\\%.]+))$")
end

-- 문자열의 앞뒤 공백을 없애는 함수
function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end





-- 문자열을 space 기준으로 잘라 command와 argument를 나누는 함수
function split_command(str)
    local cmd=""
    local arg=""
    local arg_cnt=1

    for s in string.gmatch(str, "[^%s]+") do
        if ( arg_cnt == 1 ) then
            cmd = s
        else
            arg = arg .." ".. s
        end
        arg_cnt = arg_cnt + 1
    end

    cmd = trim(cmd)
    arg = trim(arg)

    return cmd, arg
end



string.split = function(str, delim, limit)
    local t = {}
    local tt = {}
    local ck = false or limit
    
    while true do
        if str == nil then break end
        local fn = function(t, str, delim)
        local idx = select(2, string.find(str, delim))
    
        if idx == nil then
            table.insert(t, string.sub(str, 0))
            return nil
        else
            table.insert(t, string.sub(str, 0, idx - 1))
            return string.sub(str, idx + 1)
        end 
    end
    str = fn(t, str, delim);
    end
    if not ck then return t end
    
    if limit > table.maxn(t) then print("테이블보다 정한 길이가 큽니다.") return t
    else
        for i = 1, limit do
            table.insert(tt, t[i])
        end
        
        return tt
    end
end


-- 문자열의 라인 수 반환
function StringLineCount(str)
  return # str:gsub("[^\n]", "")
end


-- 현재 실행중인 Telegram CLI 의 Process ID를 얻는 함수
function GetMyPID()
  local command = "ps -e | grep tele | awk '{print $1}'"
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()
  return result;
end



function ExecuteCommand(command)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()
    return result
end



--[[
한글 문자열(UTF-8)을 한 글자씩 분리 해주는 함수
Usage :

  local arr = UTF8ToCharArray("한글 테스트 입니다");
 
  for k,v in pairs(arr) do
      print(k, v);
  end
]]--
function UTF8ToCharArray(str)
   local charArray = {};
   local iStart = 0;
   local strLen = str:len();
   
   local function bit(b)
       return 2 ^ (b - 1);
   end

    local function hasbit(w, b)
        return w % (b + b) >= b;
    end
    
    local checkMultiByte = function(i)
        if (iStart ~= 0) then
            charArray[#charArray + 1] = str:sub(iStart, i - 1);
            iStart = 0;
        end        
    end
    
    for i = 1, strLen do
        local b = str:byte(i);
        local multiStart = hasbit(b, bit(7)) and hasbit(b, bit(8));
        local multiTrail = not hasbit(b, bit(7)) and hasbit(b, bit(8));
 
        if (multiStart) then
            checkMultiByte(i);
            iStart = i;
            
        elseif (not multiTrail) then
            checkMultiByte(i);
            charArray[#charArray + 1] = str:sub(i, i);
        end
    end
    
    -- process if last character is multi-byte
    checkMultiByte(strLen + 1);
 
    return charArray;
end

