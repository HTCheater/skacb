function init()
    local file = io.open(gg.EXT_FILES_DIR .. '/Il2CppExplorer.lua', 'r')

    if file == nil then
        response = gg.makeRequest('https://github.com/HTCheater/Il2CppExplorer/releases/latest/download/Il2CppExplorer.lua')
        if response.code ~= 200 then
            print('Check internet connection')
            os.exit()
        end
        file = io.open(gg.EXT_FILES_DIR .. '/Il2CppExplorer.lua', 'w')
        file:write(response.content)
    else
        checksumResponse = gg.makeRequest('https://github.com/HTCheater/Il2CppExplorer/releases/latest/download/Il2CppExplorer.checksum')
        if checksumResponse.code ~= 200 then
            print('Check internet connection')
            os.exit()
        end
        file:close()
        file = io.open(gg.EXT_FILES_DIR .. '/Il2CppExplorer.lua', 'rb')
        local size = file:seek('end')
        local checksum = 0
        file:seek('set', 0)
        while file:seek() < size do
            checksum = checksum + file:read(1):byte()
        end
        if (checksumResponse.content ~= tostring(checksum)) then
            os.remove(gg.EXT_FILES_DIR .. '/Il2CppExplorer.lua')
            init()
        end
    end
    file:close()

    framework = loadfile(gg.EXT_FILES_DIR .. '/Il2CppExplorer.lua')
    framework()
end

init()

-- Did you expect to see some overcomplicated stuff?
-- Just don't initialize Ano, lol
explorer.editFunction(nil, 'LoginUser', {'RET'}, {'BX LR'})