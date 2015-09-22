

shell_path = ""


function ShellMode(user_id, cmd, arg)
	local result = ""

	local cmd_arg = cmd .. " " .. arg
	local b1, e1, pattern = string.find(cmd_arg, "rm([ ]*)/")

	print("Shell CMD : " .. cmd_arg)

	if( pattern ~= nil ) then
		send_msg(user_id, "사용 불가 명령", ok_cb, false)
		return
	end


	print("Shell Path : " .. shell_path)
	ExecuteCommand("cd " .. shell_path)

	shell_path = string.gsub(shell_path, "\n", "") 

	result = ExecuteCommand("cd " .. shell_path .. ";" .. cmd_arg)
	print("cmd : " .. cmd .. " result : " .. result)
	if( cmd == "cd" ) then
		shell_path = ExecuteCommand("cd " .. shell_path .. ";" .. cmd_arg .. ";pwd")
		print("Current PATH pwd : " .. shell_path)
	end

	send_msg(user_id, result, ok_cb, false)
end



