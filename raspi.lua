

cmd_still		= shell_path .. "stillcamera.sh"
still_img_path 	= temp_path .. "tele.jpg"
cmd_rec_video	= shell_path .. "rec_video.sh"	-- background 로 실행
cmd_systeminfo 	= shell_path .. "systeminfo.sh"
systeminfo_text = temp_path .. "sysinfo.txt"


-- 라즈베리파이 시스템 정보 조회
function SendSystemInfo(user_id)
	print('System Info : ' .. user_id)
	os.execute(cmd_systeminfo .. " " .. systeminfo_text)
    send_text(user_id, systeminfo_text, ok_cb, false)
end

-- 라즈베리파이 사진 촬영 및 전송
function TakePhoto(user_id)
	send_msg(user_id, '사진을 촬영합니다', ok_cb, true)
	local cmd = cmd_still .. " " .. temp_path .. "tele.jpg"
	print('Take Photo : ' .. cmd)
    os.execute(cmd)
    send_typing(user_id, 7, ok_cb, true)
    send_photo(user_id, still_img_path, ok_cb, false)
end


-- 동영상 기능은 현재 인코딩 부분이 정상적으로 안됨
--[[
function TakeVideo(user_id, arg)
	if( arg == "" ) then
		send_msg(user_id, '동영상 [record_sec] 형태로 입력하세요', ok_cb, true)
		return
	end
	send_msg(user_id, '동영상을 촬영합니다', ok_cb, true)

    os.execute(cmd_rec_video .. " " .. user_id .. " " .. arg .. " &")
end
]]--



