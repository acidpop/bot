--[[
	Web API 관련 기능은 이곳에 정의한다

	2015.07.16
-- by http://blog.acidpop.kr 
]]--




function GetWether(user_id, arg)

	-- 한글 동네 이름으로 동네 code 를 검색하는 Query
	local query = '"SELECT code || \'00|\' || SIDO || \' \' || GUGUN || \' \' || DONG FROM kma_dongne WHERE dong LIKE \'%' .. arg .. '%\';"'
	local wether_cmd = shell_path .. 'getwether.sh'
	local command = ''
	local msg = ''

	print(query)

	local n
	local result = {}

	-- 2015/10/07 argument null check added
	if ( arg == nil or arg == '' ) then
		print('get wethere argument is null string, user : ' .. user_id)
		return
	end

	n, result = GetQueryResult(query)

	print(type(n))
	if  n == 0  then
		print('동네 못 찾음')
		send_msg(user_id, arg .. " 동네 이름을 찾을 수 없습니다", ok_cb, false)
		return
	end

	print(result)

	-- 검색된 동네가 여러곳 존재 한다면 모두 출력
	for code, addr in string.gmatch(result, "(.-)|(.-)\n") do
		print(code .. " : " .. addr)
		command = wether_cmd .. " " .. code
		local handle = io.popen(command)
		local result = handle:read("*a")
		msg = addr .. " 날씨\r\n\r\n" .. result
		handle:close()
		send_msg(user_id, msg, ok_cb, false)
	end



end
