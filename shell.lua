

shell_path = ""


function ShellMode(user_id, cmd, arg)
	local result = ""

	print("Shell Path : " .. shell_path)
	ExecuteCommand("cd " .. shell_path)

	shell_path = string.gsub(shell_path, "\n", "") 

	result = ExecuteCommand("cd " .. shell_path .. ";" .. cmd .. " " .. arg)
	print("cmd : " .. cmd .. " result : " .. result)
	if( cmd == "cd" ) then
	shell_path = ExecuteCommand("cd " .. shell_path .. ";" .. cmd .. " " .. arg .. ";pwd")
	print("Current PATH pwd : " .. shell_path)
	end

	send_msg(user_id, result, ok_cb, false)
end



