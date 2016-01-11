

dir_smart_torrent	= "/home/pi/tg/bot/"
cmd_torrent_search	= shell_path .. "tdget.sh"
torrent_watch_dir	= "/home/pi/watch_dir"

torrent_search_table = { }   -- Torrent 검색목록 
torrent_title_table = { }    -- Torrent 검색 목록 테이블에서 제목만 추출하여 저장하는 테이블 
torrent_file_table = { }     -- Torrent 검색 목록 테이블에서 File 링크만 추출하여 저장하는테이블 


function AddMagnetLink(user_id, magnetlink)
	send_msg(user_id, "마그넷 링크 추가를 요청합니다", ok_cb, false)

	local cmd  = 'transmission-cli ' .. magnetlink

	print ('Magnet Add : ' .. cmd)
	
	ExecuteCommand(cmd)

	send_msg(user_id, 'magnet 링크를 추가하였습니다', ok_cb, false)
end



-- Table Item Clear
function ClearTorrentTable()
    for k,v in pairs(torrent_search_table) do
          torrent_search_table[k] = nil
    end

    for k,v in pairs(torrent_title_table) do
          torrent_title_table[k] = nil
    end
        
    for k,v in pairs(torrent_file_table) do
          torrent_file_table[k] = nil
    end
end

-- Torrent Search
function SearchTorrent(user_id, arg)
    print ("Torrent Search : ", arg)
    local trimArg = arg:match( "^%s*(.-)%s*$" )
    local command = cmd_torrent_search .. " \"" .. trimArg .. "\""
    print(command)
    local result = ExecuteCommand(command)
	
	-- 기존의 검색 결과를 삭제
    ClearTorrentTable()

    print ("[" .. result .. "]")

    if ( result == "" ) then    -- 검색 결과가 빈 문자열이면
	   send_msg(user_id, "[" .. arg .. "] 토렌트를 찾을 수 없습니다", ok_cb, false)
	else
    -- 출력된 result 문자열을 개행문자 기준으로 분리하여 테이블에 순차적으로 insert 한다.
    -- result 문자열은 다음의 형식을 가진다.
    -- torrent 제목 \n
    -- torrent link \n
	torrent_search_table = string.split(result, "\n")

    -- torrent_search_table 에서 각각 File 이름과 Torrent Link를 추출한다.
	local title_msg
	local temp_msg
	local idx = 1
	for i, v in ipairs(torrent_search_table) do
        if( i % 2 == 0 ) then
            if( v ~= "" ) then
	           table.insert(torrent_file_table, v)
            end
            else
					if( v ~= "" ) then
						temp_msg = "[" .. idx .. "] " .. v
						table.insert(torrent_title_table, temp_msg)
						idx = idx + 1
					end
				end
			end
            
            -- torrent_title_table 에 있는 각 아이템 뒤에 개행문자를 추가하여 문자열을 가져온다. 
			title_msg = table.concat(torrent_title_table, "\r\n")

            send_msg(user_id, title_msg, ok_cb, false)
		end
end


function DownloadTorrent(user_id, arg)
	print("다운로드 인덱스 : ", arg)
    local idx = tonumber(arg)
    print("Table idx[" .. arg .. "] : " .. torrent_file_table[idx])
	
    local torrent_url = torrent_file_table[idx]

    -- url 형식이 magnet 형식이라면 AddMagnetLink 함수를 이용한다.
    if ( string.sub(torrent_url, 0, 8) == "magnet:?" ) then
        send_msg(user_id, "다운로드 링크가 magnet 입니다.", ok_cb, false)
        AddMagnetLink(user_id, torrent_url)
        return
    end

	local file_name = string.match(torrent_url, "[^*]([^/]+)$")
    print(torrent_title_table[idx])
	print(torrent_file_table[idx])
    print(file_name)

    local downmsg = "torrent file Download Start : " .. torrent_title_table[idx]

    send_msg(user_id, downmsg, ok_cb, false)

    local result = url_download(torrent_watch_dir, torrent_file_table[idx])

    if( result == nil ) then
        send_msg(user_id, "torrent file Download Fail", ok_cb, false)
    else
        send_msg(user_id, "torrent file Download Success", ok_cb, false)
    end
end


function SendTorrentSearchList(user_id)
	if #torrent_search_table == 0 then
        send_msg(user_id, "검색된 토렌트가 없습니다.", ok_cb, false)
    else
        local title_msg
        title_msg = table.concat(torrent_title_table, "\r\n")

        send_msg(user_id, title_msg, ok_cb, false)
    end
end


