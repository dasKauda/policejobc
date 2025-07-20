-- server.lua

-- Komut kayıt etme
RegisterCommand('jobc', function(source, args, rawCommand)
    local playerId = source
    local message = table.concat(args, ' ')
    
    -- Mesaj boş mu kontrol et
    if not message or message == '' then
        TriggerClientEvent('chat:addMessage', playerId, {
            color = {255, 0, 0},
            multiline = true,
            args = {"HATA", "Mesaj yazmalısınız! Kullanım: /jobc [mesaj]"}
        })
        return
    end
    
    -- Oyuncunun license'ını al
    local playerLicense = nil
    for k, v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            playerLicense = v
            break
        end
    end
    
    if not playerLicense then
        TriggerClientEvent('chat:addMessage', playerId, {
            color = {255, 0, 0},
            multiline = true,
            args = {"HATA", "Oyuncu bilgileri alınamadı!"}
        })
        return
    end
    
    -- Veritabanından oyuncu bilgilerini çek
    exports.oxmysql:execute('SELECT charinfo, job FROM players WHERE license = ?', {
        playerLicense
    }, function(result)
        if result[1] then
            local playerData = result[1]
            
            -- JSON verilerini decode et
            local charInfo = json.decode(playerData.charinfo)
            local jobInfo = json.decode(playerData.job)
            
            if not charInfo or not jobInfo then
                TriggerClientEvent('chat:addMessage', playerId, {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {"HATA", "Karakter bilgileri okunamadı!"}
                })
                return
            end
            
            -- Police job kontrolü
            if jobInfo.name ~= 'police' then
                TriggerClientEvent('chat:addMessage', playerId, {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {"HATA", "Bu komutu sadece polis memurları kullanabilir!"}
                })
                return
            end
            
            -- Rütbe sistemini ayarla (job grade level'e göre)
            local ranks = {
                [0] = "Memur",
                [1] = "Başmemur", 
                [2] = "Komiser Yardımcısı",
                [3] = "Komiser",
                [4] = "Başkomiser",
                [5] = "Emniyet Müdürü"
            }
            
            local rank = ranks[jobInfo.grade.level] or jobInfo.grade.name or "Memur"
            local fullName = charInfo.firstname .. " " .. charInfo.lastname
            local formattedMessage = rank .. " " .. fullName .. ": " .. message
            
            -- Tüm oyunculara gönder ama sadece police job'ı olanlar görsün
            local players = GetPlayers()
            for i = 1, #players do
                local targetId = tonumber(players[i])
                
                -- Her oyuncunun job'ını kontrol et
                local targetLicense = nil
                for k, v in pairs(GetPlayerIdentifiers(targetId)) do
                    if string.sub(v, 1, string.len("license:")) == "license:" then
                        targetLicense = v
                        break
                    end
                end
                
                if targetLicense then
                    exports.oxmysql:execute('SELECT job FROM players WHERE license = ?', {
                        targetLicense
                    }, function(targetResult)
                        if targetResult[1] then
                            local targetJobInfo = json.decode(targetResult[1].job)
                            
                            if targetJobInfo and targetJobInfo.name == 'police' then
                                TriggerClientEvent('chat:addMessage', targetId, {
                                    color = {0, 100, 255},
                                    multiline = true,
                                    args = {"[POLİS CHAT]", formattedMessage}
                                })
                            end
                        end
                    end)
                end
            end
            
        else
            TriggerClientEvent('chat:addMessage', playerId, {
                color = {255, 0, 0},
                multiline = true,
                args = {"HATA", "Oyuncu veritabanında bulunamadı!"}
            })
        end
    end)
end, false)

-- İsteğe bağlı: Komut yardımı
TriggerEvent('chat:addSuggestion', '/jobc', 'Polis chat kanalına mesaj gönder', {
    { name="mesaj", help="Göndermek istediğiniz mesaj" }
})