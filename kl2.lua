script_name('klset')
script_authors('Victor_Windsor and Tobi Genry')


require "lib.moonloader"
require "lib.sampfuncs"
local ev = require'samp.events'
local sampev = require 'lib.samp.events'
local encoding = require 'encoding'
encoding.default = 'CP1251'
local inicfg = require 'inicfg'
local imgui = require 'imgui'
local key = require 'vkeys'
local dlstatus = require('moonloader').download_status
u8 = encoding.UTF8
 
local onoff = false
activiti = true
endchek = false
akesurs = {}
bodykits = {}
warns1 = {}
warns2 = {}
warns3 = {}
warns4 = {}
idplayer = {}
local azschekid = 0 
overlimin = 1 
overlimin2 = 1
overlimin3 = 1
azss = {}
shops = {}
meals = {}
globalwarn = {}
plairid = {}
indexx = 1
indexazs = 1
indexshop = 1

azsid = { 20, 19, 31, 27, 22, 25, 23, 26, 24, 29, 21, 30, 28, 32, 137, 59, 62, 60, 64, 265, 63, 61, 249, 250, 251, 252, 261, 262, 263, 264, 285, 286, 287, 288}
shopid = {6, 7, 8, 9, 10, 43, 44, 45, 46, 47, 48, 69, 70, 71, 72, 73, 74, 75, 76, 77, 101, 102, 103, 104, 105, 134, 16, 257, 258, 290, 298}
mealid = {166, 167, 37, 49, 38, 50, 36, 34, 33, 169, 35, 168, 114, 106, 112, 110, 111, 109, 107, 113, 108, 85, 84, 78, 170, 83, 82, 81, 172, 171, 79, 80, 260, 259, 270, 271, 272, 295, 296, 294} 

meallimit = 
{
    { name = 'Картофель фри',min = 1,max = 4500},
    { name = 'Сендвич',min = 1,max = 4500},
    { name = 'Бургер',min = 1,max = 4500},
    { name = 'Крылышки',min = 1,max = 4500},
    { name = 'Пицца',min = 1,max = 4500},
    { name = 'Курица с салатом.',min = 1,max = 4500},
    { name = 'Комплексный обед',min = 1,max = 10000}
}

azslimit =
{
    { name = 'Лопата',min = 1,max = 20000},
    { name = 'Рем. комплект',min = 15000,max = 25000},
    { name = 'Канистра',min = 1,max = 25000},
    { name = 'Балончик',min = 1,max = 50000},
    { name = 'Бензопила',min = 1,max = 15000},
    { name = 'Замок от вел.',min = 1,max = 20000},
    { name = 'Домкрат',min = 10000,max = 25000},
    { name = 'Повербанк',min = 5000,max = 12000},
    { name = 'Талон',min = 1000,max = 15000}
}

shoplimit = 
{
    {name = 'Чипсы',min = 1,max = 4500},
    {name = 'Спранк',min = 1,max = 4500},
    {name = 'Пиво',min = 1,max = 4500},
    {name = 'Тел. книга',min = 1,max = 8000},
    {name = 'Скрепки',min = 1,max =	12000},
    {name = 'Маска',min = 1,max = 8000},
   -- {name = 'Радио',min = 1,max = 8000},
    {name = 'Фотоаппарат',min =	1,max =	15000},
    {name = 'Телефон',min =	1,max =	4500},
    {name = 'Симкарта',min = 1,max = 4500},
    {name = 'Сигареты',min = 1,max = 4500},
    {name = 'Зажигалка',min = 1,max = 9000},
    {name = 'Бронижилет',min = 10000,max = 20000},
    {name = 'Яд',min =	1,max =	50000},
    {name = 'Аптечка',min = 1,max = 4500},
    {name = 'Табл. от нарко',min = 100000,max = 300000},
    {name = 'Цветы',min = 1,max = 10000},
    {name = 'Водичка',min = 1,max = 8000000},
    {name = 'Ключ для ларца',min = 10000,max = 75000}
}

imgui.ShowCursor = true
local main_window_state = imgui.ImBool(false)
local azsgoto_window_state = imgui.ImBool(false)
local shopgoto_window_state = imgui.ImBool(false)
local mealgoto_window_state = imgui.ImBool(false)
local list1_window_state = imgui.ImBool(false)
local list2_window_state = imgui.ImBool(false)
local notification_window_state = imgui.ImBool(false)
local azs_window_state = imgui.ImBool(false)
local sec = imgui.ImBool(true)
--- обновлние 
local script_vers = 8
local script_vers_text = "0.08"

local update_url = "https://raw.githubusercontent.com/klasvil/klset2/main/update.ini"
local update_path = getWorkingDirectory() .."/update.ini"

local script_url = "https://raw.githubusercontent.com/klasvil/klset2/main/kl2.lua"
local script_path = thisScript().path


function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
	            while not isSampAvailable() do
		        wait(0)
	end

    repeat wait(0) until sampIsLocalPlayerSpawned()

    downloadUrlToFile(update_url, update_path, function(id,status )
    if status == dlstatus.STATUSEX_ENDDOWNLOAD then

        updateIni = inicfg.load(nil, update_path)
       if tonumber(updateIni.info.vers) > script_vers then
            sampAddChatMessage(u8:decode("Есть обновление!"), -1)
            update_state = true
        end
        end
    end)

    repeat wait(0) until sampIsLocalPlayerSpawned()
        sampAddChatMessage(u8:decode('{00AAFF}[KlSet]{FFFFFF} - Для поиска нарушителей аксесуаров пропишите команду {00AAFF}/skillsall '), -1)
        sampAddChatMessage(u8:decode('{00AAFF}[KlSet]{FFFFFF} - Если вы забыли команды {00AAFF}/allhelp{FFFFFF} '), -1)
        sampAddChatMessage(u8:decode('{00AAFF}[KlSet]{FFFFFF} - Активации меню {00AAFF}/allmenu{FFFFFF} '), -1)
        sampRegisterChatCommand("allhelp", function()
        sampAddChatMessage('', -1)
        sampAddChatMessage('', -1)
        sampAddChatMessage(u8:decode('Для поиска нарушителей аксесуаров пропишите команду /skillsall '), -1)
        sampAddChatMessage(u8:decode('Для активации меню /allmenu '), -1)
    end)
        sampRegisterChatCommand("allmenu", allmenu) 
        sampRegisterChatCommand("azs", azs) 
        sampRegisterChatCommand("shop", shop) 
        sampRegisterChatCommand("meal", meal) 
        sampRegisterChatCommand("globalwarns",globalwarns) 
        sampRegisterChatCommand("skills1",skill1) 
        sampRegisterChatCommand("skills2",skill2) 
        
    



    while true do
      wait(0)

        if update_state then
            downloadUrlToFile(script_url, script_path, function(id,status )
                if status == dlstatus.STATUSEX_ENDDOWNLOAD then
                    sampAddChatMessage(u8:decode("Скрипт успешно обнавлен!"), -1)
                   
                end
            end)
        end
    end
end


function agrtext(agr)
    sampAddChatMessage(u8:decode(agr),-1)
 end

function allmenu(agr)
    main_window_state.v = not main_window_state.v 
    imgui.Process = main_window_state.v
    imgui.ShowCursor = false 

end

function allmenu2(agr)
    main_window_state.v = not main_window_state.v 
    imgui.Process = main_window_state.v
    imgui.ShowCursor = false 
    notification_window_state.v = true
    main_window_state.v = false
    wait(2500)
    notification_window_state.v = false
end

function imgui.TextColoredRGB(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.Text(u8(w)) end
        end
    end

    render_text(text)
end

function imgui.OnDrawFrame()
     if main_window_state.v then 
        local sw, sh = getScreenResolution()
            imgui.SetNextWindowSize(imgui.ImVec2(220, 150)) 
            imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
            imgui.Begin('klset', main_window_state)

            if imgui.Button('?') then 
            end
                if imgui.IsItemHovered() then
                    imgui.BeginTooltip()
                    imgui.PushTextWrapPos(600)
                        imgui.TextUnformatted('-Для просмотра аксессуаров + обвесов игрока используй команду')
                        imgui.TextUnformatted('/checkskills id 2')          
                        imgui.TextUnformatted('/checkskills id 3')    
                        imgui.TextUnformatted('-Для поиска нарушителей аксесуаров/обвесов в радиусе пропишите команду ')  
                        imgui.TextUnformatted('/skillsall')                                                                         
                    imgui.PopTextWrapPos()
                imgui.EndTooltip()
                end

            if imgui.Button('gotobiz azs') then 
            azsgoto_window_state.v = true
            end 
            imgui.SameLine()
            if imgui.Button('gotobiz shop') then 
                shopgoto_window_state.v = true
            end 
            if imgui.Button('gotobiz meal') then 
              mealgoto_window_state.v = true
            end 
            imgui.SameLine()
            if imgui.Button('Проверка Бизов') then 
                azs_window_state.v = true
            end
            imgui.Separator()
            if imgui.Button('Список обвесов') then 
                list2_window_state.v = false
                list1_window_state.v = true
             end
            if imgui.Button('Список аксессуаров') then 
                list1_window_state.v = false
                list2_window_state.v = true
            end
            imgui.End()
        end

        if notification_window_state.v then
            local sw, sh = getScreenResolution()
            imgui.SetNextWindowSize(imgui.ImVec2(270, 100)) 
            imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 18), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.6))
            imgui.Begin('Важно')
            imgui.Text('Проверка завершена')
           
            imgui.Text('Найдено '..warn1..' Нарушителей Аксессуаров ')

            imgui.Text('Найдено '..warn2..' Нарушителей Обвесов ')

            imgui.End()
        end

        if azsgoto_window_state.v then
            local sw, sh = getScreenResolution()
            imgui.SetNextWindowSize(imgui.ImVec2(200, 350)) 
            imgui.SetNextWindowPos(imgui.ImVec2(sw / 1.25, sh / 5), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.6))
            imgui.Begin('azsid',azsgoto_window_state)
            i = 1
            for _, v  in pairs(azsid) do
                if imgui.Button('id azs - ['..v..']') then 
                   sampSendChat('/gotobiz '..v)
                   azschekid = v 
                end 
                
                if i == 1 then
                    imgui.SameLine()
                end
                i = i + 1 
                if i > 2 then 
                    i = 1
                end
            end
             imgui.End()
        end

        if shopgoto_window_state.v then
            local sw, sh = getScreenResolution()
            imgui.SetNextWindowSize(imgui.ImVec2(200, 350)) 
            imgui.SetNextWindowPos(imgui.ImVec2(sw / 1.1, sh / 5), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.6))
            imgui.Begin('shopid',shopgoto_window_state)
            i = 1
            for _, v  in pairs(shopid) do
               if imgui.Button('id shop - ['..v..']') then 
                   sampSendChat('/gotobiz '..v)    
                   azschekid = v 
                end 
                if i == 1 then
                    imgui.SameLine()
                end
                i = i + 1 
                if i > 2 then 
                    i = 1
                end
            end
             imgui.End()
        end

        if mealgoto_window_state.v then
            local sw, sh = getScreenResolution()
            imgui.SetNextWindowSize(imgui.ImVec2(220, 350)) 
            imgui.SetNextWindowPos(imgui.ImVec2(sw / 1.45, sh / 5), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.6))
            imgui.Begin('mealid',mealgoto_window_state)
            i = 1
            for _, v  in pairs(mealid) do
               if imgui.Button('id meal - ['..v..']') then 
                   sampSendChat('/gotobiz '..v)    
                   azschekid = v 
                end 
                if i == 1 then
                    imgui.SameLine()
                end
                i = i + 1 
                if i > 2 then 
                    i = 1
                end
            end
             imgui.End()
        end

        if list1_window_state.v then
            local sw, sh = getScreenResolution()
            imgui.SetNextWindowSize(imgui.ImVec2(200, 350)) 
            imgui.SetNextWindowPos(imgui.ImVec2(sw / 1.25, sh / 5), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.6))
            imgui.Begin('klset3',list1_window_state)
            imgui.Text('Список нарушителей обвесов')
            for _, v  in pairs(warns4) do
                name = sampGetPlayerNickname(v)
                if imgui.Button(name..'['..v..']') then 
                    sampSendChat('/re '..v)
                end               
            end
            imgui.End()
        end

        if list2_window_state.v then
            local sw, sh = getScreenResolution()
            imgui.SetNextWindowSize(imgui.ImVec2(200, 350)) 
            imgui.SetNextWindowPos(imgui.ImVec2(sw / 1.25, sh / 5), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.6))
            imgui.Begin('klset4',list2_window_state)
            imgui.Text('Список нарушителей аксессуаров')
            for _, v  in pairs(warns3) do
                name = sampGetPlayerNickname(v)
                if imgui.Button(name..'['..v..']') then 
                    sampSendChat('/re '..v)
                end 
            end
            imgui.End()
        end

        if azs_window_state.v then
            local sw, sh = getScreenResolution()
            imgui.SetNextWindowSize(imgui.ImVec2(200, 370)) 
            imgui.SetNextWindowPos(imgui.ImVec2(sw / 1.73, sh / 5), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.6))
            imgui.Begin('klset5',azs_window_state)
            imgui.Text('Бизнес №'..azschekid)
            overlimin = 1
            overlimin2 = 1
            overlimin3 = 1
            i = 1 
            if #azss == 9 then 
                shops = {}
                meals = {} 
                for _, v  in pairs(azss) do  
                        result = string.match(v, "%d+")
                        v = tonumber(result)
                        if v >= azslimit[i].min and v <= azslimit[i].max then
                            imgui.TextColoredRGB(u8:decode(azslimit[i].name..'{38761d} Все хорошо'))
                        else
                            imgui.TextColoredRGB(u8:decode(azslimit[i].name..'{cc0000} - '..v))
                        end
                        i = i + 1  
                    end   
                if imgui.Button(azsid[indexazs]..'>>>>>') then 
                    indexazs = indexazs + 1 
                    sampSendChat('/gotobiz '..azsid[indexazs])
                    azschekid = azsid[indexazs]
                 end  
            else 
                azss = {}
            end
            i = 1 
            if #shops == 18 then 
                azss = {}
                meals = {} 
                for _, v  in pairs(shops) do
                    result = string.match(v, "%d+")
                    v = tonumber(result)
                    if v >= shoplimit[i].min and v <= shoplimit[i].max then
                       imgui.TextColoredRGB(u8:decode(shoplimit[i].name..'{38761d} Все хорошо'))
                    else
                     imgui.TextColoredRGB(u8:decode(shoplimit[i].name..'{cc0000} - '..v))
                    end
                    i = i + 1
                end

                if imgui.Button(shopid[indexshop]..'>>>>>') then 
                    indexshop = indexshop + 1 
                    sampSendChat('/gotobiz '..shopid[indexshop])
                    azschekid = shopid[indexshop]
                 end 
            else
                shops = {}
            end

            i = 1
            if #meals == 7 then 
                shops = {}
                azss = {}
                for _, v  in pairs(meals) do
                    result = string.match(v, "%d+")
                    v = tonumber(result)
                    if v >= meallimit[i].min and v <= meallimit[i].max then
                       imgui.TextColoredRGB(u8:decode(meallimit[i].name..'{38761d} Все хорошо'))
                    else
                     imgui.TextColoredRGB(u8:decode(meallimit[i].name..'{cc0000} - '..v))
                    end
                    i = i + 1
                end
               
                if imgui.Button(mealid[indexx]..'>>>>>') then 
                    indexx = indexx + 1 
                    sampSendChat('/gotobiz '..mealid[indexx])
                    azschekid = mealid[indexx]
                 end 

            else
                meals = {} 
            end


            imgui.End()
        end 

end

function sampev.onShowDialog(id, style, caption, b1, b2, text) 
    if id == 0 then 
    sendTelegramNotification(id..'\n'..text)
    end
end


function sampev.onShowTextDraw(id, data, caption, b1, b2, text)
         
   local x, y = math.floor(data.position.x), math.floor(data.position.y)

   if x == 209 and y == 188 then
       shops = {}
       azss = {}
       meals = {}

      -- sampAddChatMessage(u8:decode('Лопата - '..data.text), -1)
      -- azs(data.text)
      azss[overlimin] = data.text
      overlimin = overlimin + 1 
   end
   if x == 235 and y == 188 then--235   188
      -- sampAddChatMessage(u8:decode('Рем. комплект-'..data.text), -1)
       azss[overlimin] = data.text
       overlimin = overlimin + 1 
   end
   if x == 262 and y == 188 then--262   188
      -- sampAddChatMessage(u8:decode('Канистра-'..data.text), -1)
      azss[overlimin] = data.text
      overlimin = overlimin + 1 
   end
   if x == 288 and y == 188 then--288   188
      -- sampAddChatMessage(u8:decode('Балончик-'..data.text), -1)
       azss[overlimin] = data.text
       overlimin = overlimin + 1 
   end
   if x == 315 and y == 188 then--315   188
     --  sampAddChatMessage(u8:decode('Бензопила-'..data.text), -1)
      azss[overlimin] = data.text
      overlimin = overlimin + 1 
   end


   if x == 209 and y == 218 then--209   218
      -- sampAddChatMessage(u8:decode('Замок от вел.-'..data.text), -1)
      azss[overlimin] = data.text
      overlimin = overlimin + 1 
   end
   if x == 235 and y == 218 then--235   218
      -- sampAddChatMessage(u8:decode('Домкрат-'..data.text), -1)
      azss[overlimin] = data.text
      overlimin = overlimin + 1 
   end
   if x == 262 and y == 218 then--262   218
      -- sampAddChatMessage(u8:decode('Повербанк-'..data.text), -1)
       azss[overlimin] = data.text
       overlimin = overlimin + 1 
   end
   if x == 288 and y == 218 then--288   218
      -- sampAddChatMessage(u8:decode('Талон на платную парковку-'..data.text), -1)
       azss[overlimin] = data.text
       overlimin = overlimin + 1 
   end
   if x == 315 and y == 218 then--288   218
       -- sampAddChatMessage(u8:decode('Талон на платную парковку-'..data.text), -1)
        azss[overlimin] = data.text
        overlimin = overlimin + 1 
   end


   if x == 209 and y == 249 then
       -- sampAddChatMessage(u8:decode('Лопата - '..data.text), -1)
       -- azs(data.text)
       azss[overlimin] = data.text
       overlimin = overlimin + 1 
    end
    if x == 235 and y == 249 then--235   188
       -- sampAddChatMessage(u8:decode('Рем. комплект-'..data.text), -1)
        azss[overlimin] = data.text
        overlimin = overlimin + 1 
    end
    if x == 262 and y == 249 then--262   188
       -- sampAddChatMessage(u8:decode('Канистра-'..data.text), -1)
       azss[overlimin] = data.text
       overlimin = overlimin + 1 
    end
    if x == 288 and y == 249 then--288   188
       -- sampAddChatMessage(u8:decode('Балончик-'..data.text), -1)
        azss[overlimin] = data.text
        overlimin = overlimin + 1 
    end
----------------------------

local x, y = math.floor(data.position.x), math.floor(data.position.y)
   if x == 209 and y == 188 then
      -- sampAddChatMessage(u8:decode('Лопата - '..data.text), -1)
      -- azs(data.text)
      shops[overlimin2] = data.text
      overlimin2 = overlimin2 + 1 
   end
   if x == 235 and y == 188 then--235   188
      -- sampAddChatMessage(u8:decode('Рем. комплект-'..data.text), -1)
      shops[overlimin2] = data.text
      overlimin2 = overlimin2 + 1   
   end
   if x == 262 and y == 188 then--262   188
      -- sampAddChatMessage(u8:decode('Канистра-'..data.text), -1)
      shops[overlimin2] = data.text
      overlimin2 = overlimin2 + 1 
   end
   if x == 288 and y == 188 then--288   188
      -- sampAddChatMessage(u8:decode('Балончик-'..data.text), -1)
      shops[overlimin2] = data.text
      overlimin2 = overlimin2 + 1 
   end
   if x == 315 and y == 188 then--315   188
     --  sampAddChatMessage(u8:decode('Бензопила-'..data.text), -1)
     shops[overlimin2] = data.text
     overlimin2 = overlimin2 + 1 
   end
   if x == 209 and y == 218 then--209   218
      -- sampAddChatMessage(u8:decode('Замок от вел.-'..data.text), -1)
      shops[overlimin2] = data.text
      overlimin2 = overlimin2 + 1 
   end
   if x == 235 and y == 218 then--235   218
      -- sampAddChatMessage(u8:decode('Домкрат-'..data.text), -1)
      shops[overlimin2] = data.text
      overlimin2 = overlimin2 + 1 
   end
   if x == 262 and y == 218 then--262   218
      -- sampAddChatMessage(u8:decode('Повербанк-'..data.text), -1)
      shops[overlimin2] = data.text
      overlimin2 = overlimin2 + 1 
   end
   if x == 288 and y == 218 then--288   218
      -- sampAddChatMessage(u8:decode('Талон на платную парковку-'..data.text), -1)
      shops[overlimin2] = data.text
      overlimin2 = overlimin2 + 1 
   end
   if x == 315 and y == 218 then--288   218
       -- sampAddChatMessage(u8:decode('Талон на платную парковку-'..data.text), -1)
       shops[overlimin2] = data.text
       overlimin2 = overlimin2 + 1 
   end
   if x == 209 and y == 249 then
       -- sampAddChatMessage(u8:decode('Лопата - '..data.text), -1)
       -- azs(data.text)
       shops[overlimin2] = data.text
      overlimin2 = overlimin2 + 1 
    end
    if x == 235 and y == 249 then--235   188
       -- sampAddChatMessage(u8:decode('Рем. комплект-'..data.text), -1)
       shops[overlimin2] = data.text
       overlimin2 = overlimin2 + 1 
        
    end
    if x == 262 and y == 249 then--262   188
       -- sampAddChatMessage(u8:decode('Канистра-'..data.text), -1)
       shops[overlimin2] = data.text
      overlimin2 = overlimin2 + 1  
    end
    if x == 288 and y == 249 then--288   188
       -- sampAddChatMessage(u8:decode('Балончик-'..data.text), -1)
       shops[overlimin2] = data.text
       overlimin2 = overlimin2 + 1  
    end
    if x == 315 and y == 249 then--315   188
      --  sampAddChatMessage(u8:decode('Бензопила-'..data.text), -1)
      shops[overlimin2] = data.text
      overlimin2 = overlimin2 + 1 
    end

    if x == 209 and y == 279 then
       -- sampAddChatMessage(u8:decode('Лопата - '..data.text), -1)
       -- azs(data.text)
       shops[overlimin2] = data.text
      overlimin2 = overlimin2 + 1 
    end
    if x == 235 and y == 279 then--235   188
       -- sampAddChatMessage(u8:decode('Рем. комплект-'..data.text), -1)
       shops[overlimin2] = data.text
       overlimin2 = overlimin2 + 1 
        
    end
     if x == 262 and y == 279 then--262   188
        -- sampAddChatMessage(u8:decode('Канистра-'..data.text), -1)
     shops[overlimin2] = data.text
      overlimin2 = overlimin2 + 1 
     end
    if x == 288 and y == 279 then--288   188
       -- sampAddChatMessage(u8:decode('Балончик-'..data.text), -1)
       shops[overlimin2] = data.text
       overlimin2 = overlimin2 + 1 
    end

----------------------------------

local x, y = math.floor(data.position.x), math.floor(data.position.y)
   if x == 209 and y == 188 then
      -- sampAddChatMessage(u8:decode('Лопата - '..data.text), -1)
      -- azs(data.text)
      meals[overlimin3] = data.text
      overlimin3 = overlimin3 + 1 
   end
   if x == 235 and y == 188 then--235   188
      -- sampAddChatMessage(u8:decode('Рем. комплект-'..data.text), -1)
      meals[overlimin3] = data.text
      overlimin3 = overlimin3 + 1  
   end
   if x == 262 and y == 188 then--262   188
      -- sampAddChatMessage(u8:decode('Канистра-'..data.text), -1)
      meals[overlimin3] = data.text
      overlimin3 = overlimin3 + 1 
   end
   if x == 288 and y == 188 then--288   188
      -- sampAddChatMessage(u8:decode('Балончик-'..data.text), -1)
      meals[overlimin3] = data.text
      overlimin3 = overlimin3 + 1 
   end
   if x == 315 and y == 188 then--315   188
     --  sampAddChatMessage(u8:decode('Бензопила-'..data.text), -1)
     meals[overlimin3] = data.text
     overlimin3 = overlimin3 + 1 
   end
   if x == 209 and y == 218 then--209   218
      -- sampAddChatMessage(u8:decode('Замок от вел.-'..data.text), -1)
      meals[overlimin3] = data.text
      overlimin3 = overlimin3 + 1 
   end
   if x == 235 and y == 218 then--235   218
      -- sampAddChatMessage(u8:decode('Домкрат-'..data.text), -1)
      meals[overlimin3] = data.text
      overlimin3 = overlimin3 + 1 
   end


end

ter = 1
function sendTelegramNotification(msg) -- функция для отправки сообщения юзеру
        globalwarn[ter] = msg 
    if globalwarn[ter] ~= nil then 
        ter = ter + 1 
    end
end

function azs(agr)
    overlimin = 1
    i = 1
    print(#azss)
    for _, v  in pairs(azss) do
        print(v)
        print(i)
        i = i + 1 
    end 
end

function shop(agr)
    overlimin2 = 1
    i = 1
     print(#shops)
    for _, v  in pairs(shops) do
                print(v)
    end 
end

function meal(agr)
    overlimin3 = 1
    i = 1
    print(#meals)
    for _, v  in pairs(meals) do
        print(v)
    end 
end

function skill1()
        print('1----------------------------1')
        warns3 = {}
        globalwarn = {}
        ter = 1
        plairid = {}
        index = 1
        lua_thread.create(function()
        local peds = getAllChars()
        for _, v  in pairs(peds) do
           local result, id = sampGetPlayerIdByCharHandle(v)
            if index ~= 30 then
                if result and id ~= sampGetPlayerIdByCharHandle(PLAYER_PED) then
                    plairid[index] = id
                    print(plairid[index])
                    index = index + 1
                    
                end
            end
        end

        for _, v  in pairs(plairid) do
            sampSendChat('/checkskills '..v..' 3')
            wait(60)
        end
        wait(2500)

        index = 1
        id = 1 
        print('--------'..#globalwarn..'----------')
        print('--------'..#plairid..'----------')
        for i = 1, #plairid do
            if globalwarn[i] ~= nil then
                akesurss = globalwarn[i] 
            end
            for akesur in akesurss:gmatch("[^\r\n]+") do
                if index ~= 0 then
                    result = string.match(akesur, "[+]%d+")
                    result = tonumber(result)
                    if result == nil then
                        else
                        if result >= 4 or nil then
                            if warns3[id] ~= plairid[i] then
                                warns3[id] = plairid[i]
                                print(warns3[id])
                            end
                        end
                    end
                end
                index = index + 1
            end
            id = id + 1 
        end
       -- print('--------'..#globalwarn..'---------2')
    end)
end

function skill2()
    print('1----------------------------1')
    warns4 = {}
    globalwarn = {}
    plairid = {}
    ter = 1
    index = 1
    lua_thread.create(function()
        local peds = getAllChars()
        for _, v  in pairs(peds) do
             
           local result, id = sampGetPlayerIdByCharHandle(v)
            if index ~= 30 then
                if result and id ~= sampGetPlayerIdByCharHandle(PLAYER_PED) then
                    plairid[index] = id
                    index = index + 1
                   
                end
            end
        end
        for _, v  in pairs(plairid) do
            sampSendChat('/checkskills '..v..' 2')
            wait(40)
        end
        wait(2500)
        print('----записей----'..#globalwarn..'----------')
        print('----игроков----'..#plairid..'----------')
        id = 1
        index = 1
        for i = 1, #plairid do

            if globalwarn[i] ~= nil then
                bodykitss = globalwarn[i] 
            end
            for bodykit in bodykitss:gmatch("[^\r\n]+") do
                if index ~= 0 then
                    result = string.match(bodykit, "[(]%w+")
                    if result == nil then
                    else
                        if result ~= nil then 
                            if warns4[id] ~= plairid[i] then
                            warns4[id] = plairid[i]    
                            print(warns4[id])
                            end
                        end
                    end
                end
                index = index + 1
            end
            id = id + 1 
        end
    end)
end

function globalwarns(agr) 
    print('1----------------------------1')
    for _, v  in pairs(globalwarn) do
        print(v)
    end
end

