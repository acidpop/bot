

-- SQLite3 를 이용하여 tgbot.db 파일 DB를 관리 한다.

tgbot_db_path = '/home/pi/tg/bot/tgbot.db '
sqlite_cmd = 'sqlite3 ' .. tgbot_db_path




function SendMsgForQueryResult(user_id, query, front_msg)
	local command = sqlite_cmd .. query

    print('sqlite command : ' .. command)
	local handle = io.popen(command)
	local result = handle:read("*a")
	handle:close()

    local msg = ''

    if ( result == '' ) then
    	msg = front_msg .. "\n" .. "검색 결과가 없습니다"
		send_msg(user_id, msg, ok_cb, false)
	else
		msg = front_msg .. "\n\n" .. result
		send_msg(user_id, msg, ok_cb, false)
	end
end

-- return query count, query result
function GetQueryResult(query)
	local command = sqlite_cmd .. query

    print('sqlite command : ' .. command)
	local handle = io.popen(command)
	local result = handle:read("*a")
	handle:close()

	local linecnt = StringLineCount(result)
	local n = tonumber(linecnt)

	return n, result
end
