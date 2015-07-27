


wol_cmd	= "python ".. bot_path .."wol.py"


-- WOL 대상 MAC 주소, 각 시스템의 MAC Address 로 변경해서 사용한다.
wol_system	= 	{	
					[1] = '1A:2B:3C:4D:5E:6F', 	-- 데스크탑
					[2] = '00:AA:BB:CC:DD:EE'	-- 서버
				}

function WakeOnLan(user_id, system_idx)
	print('MAC : ' .. wol_system[system_idx] .. '시스템 WOL 요청')

	-- 192.168.0.255 는 사용하는 네트워크의 Broadcast 주소로 변경해서 사용한다.
	ExecuteCommand(wol_cmd .. ' -b 192.168.0.255 ' .. wol_system[system_idx])

	send_msg(user_id, 'MAC : ' .. wol_system[system_idx] .. '시스템 WOL 요청 완료', ok_cb, false)
end

