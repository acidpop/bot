


function save_file(extra, success, file)
    if success then
        print(file)    ---filename where the media is stored
        print(extra[0])    ---sender name
        print(extra[1])    ---msg.id
        print(extra[2])    ---msg.date
        --the extra[] values where these, which where written to the a = {}
        --array. Later you can include code here to handle
        --the specific
        ---media files.
        print('split file path')
        if ( file == false ) then
            print('unknown file')
            return
        end
        fullpath,filename,extension = splitfilename(file)
        -- 확장자가 torrent 라면 NAS 로 torrent 파일을 전송한다.
        if extension == 'torrent' then
            -- file 변수에 전체 경로가 있으므로 transmission 의 watch-dir 경로에 move 하면 된다
            local move_cmd = 'mv ' .. file .. ' /transmission_watchdir'
            ExecuteCommand(move_cmd)
        end

    end
end


-- 동영상, 또는 Audio 파일을 수신 받으면 비정상적으로 작동한다.
function RecvFile(msg)
	if msg.media.type == 'photo' then
        a = {}
        a[0] = msg.from.print_name
        a[1] = msg.id
        a[2] = msg.date
        load_photo(msg.id, save_file, a)
        print("Receive Photo!!")
        return
    elseif msg.media.type == 'document' then
        a = {}
        a[0] = msg.from.print_name
        a[1] = msg.id
        a[2] = msg.date
        load_document(msg.id, save_file, a)
        print("Receive File!!")
        return
    end
end
