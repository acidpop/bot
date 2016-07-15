cmd_power_command       = shell_path .. "power.sh "

function ServerPower(user_id, args)
    local command = cmd_power_command .. args
    print(command)
    ExecuteCommand(command)
end