-- 💎 TUMBA MEGA SYSTEM v5.0 - ГЛАВНЫЙ СКРИПТ
-- Этот файл должен называться 'main.lua.txt' в вашем репозитории.
-- Он будет запущен ПОСЛЕ того, как loader.lua скачает все модули.

print("🚀 Запуск основного скрипта Tumba v5...")

local TUMBA_FOLDER = "tumba"

-- 1. --- ФУНКЦИЯ ЗАГРУЗКИ МОДУЛЕЙ ИЗ КЭША ---
-- (loader.lua их скачал, а этот скрипт их прочитает и исполнит)
local function loadModule(path)
    local full_path = TUMBA_FOLDER .. "/" .. path:gsub("/", "_")
    local fileContent, err = pcall(readfile, full_path)
    if not fileContent then
        error("Ошибка чтения кэшированного файла " .. path .. ": " .. (err or "Файл не найден. Запустите лоадер заново."), 0)
    end
    
    local success, module = pcall(loadstring(fileContent, path))
    if not success then
        error("Ошибка загрузки модуля " .. path .. ": " .. module, 0)
    end
    
    local ret = {pcall(module)}
    if not ret[1] then
        error("Ошибка исполнения модуля " .. path .. ": " .. ret[2], 0)
    end
    
    return ret[2] -- Возвращаем то, что вернул модуль (обычно таблицу)
end

-- 2. --- ЗАГРУЗКА ВСЕХ МОДУЛЕЙ ---
print("📥 Загрузка модулей из кэша...")
local Core = loadModule("config/settings.lua.txt")
local Localization = loadModule("modules/localization.lua.txt")
local GUIBuilder = loadModule("modules/gui_builder.lua.txt")
local ESP = loadModule("modules/esp.lua.txt")
local AimAssist = loadModule("modules/aim_assist.lua.txt")
local KitESP = loadModule("modules/kit_esp.lua.txt")
local PlayerManager = loadModule("modules/player_manager.lua.txt")
local Utilities = loadModule("modules/utilities.lua.txt")
print("✅ Все модули загружены.")

-- 3. --- ИНИЦИАЛИЗАЦИЯ СИСТЕМЫ ---
local Mega = Core -- 'Mega' - это главный объект, содержащий все
Mega.Localization = Localization
local GetText = Mega.Localization.GetText

-- Глобальные сервисы
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = game:GetService("Players").LocalPlayer

local TumbaGUI = nil -- Переменная для хранения GUI

-- 4. --- ОПРЕДЕЛЕНИЕ ФУНКЦИЙ-ОБЕРТОК ДЛЯ GUI ---
-- (Многие модули требуют 'Mega', 'GetText' и т.д., эти функции упрощают их вызов)

local function showNotification_wrapper(message)
    Utilities.showNotification(Mega, message)
end

local function Cleanup_wrapper()
    Utilities.Cleanup(Mega)
end

local function recreateKitESP_wrapper()
    KitESP.recreateKitESP(Mega)
end

local function resetKit_wrapper()
    KitESP.resetKit(Mega)
end

local function StartFollow_wrapper(player)
    PlayerManager.StartFollow(Mega, GetText, showNotification_wrapper, player)
end

local function StopFollow_wrapper()
    PlayerManager.StopFollow(Mega, GetText, showNotification_wrapper)
end

-- Функция для открытия/закрытия меню по клавише
local function ToggleMenu()
    if TumbaGUI then
        TumbaGUI.Enabled = not TumbaGUI.Enabled
        if TumbaGUI.Enabled then
            print(GetText("print_menu_open", Mega.VERSION))
        else
            print(GetText("print_menu_closed"))
        end
    end
end

-- 5. --- ГЛАВНАЯ ФУНКЦИЯ ИНИЦИАЛИЗАЦИИ ---
-- (Вызывается после выбора языка)
local function InitializeTumba(language)
    Mega.Localization.SetLanguage(language)
    print(GetText("print_load_success", Mega.VERSION))
    print(GetText("print_created_by", Mega.DEVELOPER))
    print(GetText("print_for", Mega.SPECIAL_THANKS))
    print(GetText("print_build_date", Mega.BUILD_DATE))

    -- Создаем ГУИ
    TumbaGUI = GUIBuilder.CreateMainGUI(
        Mega,
        GetText,
        showNotification_wrapper,
        ToggleMenu,
        recreateKitESP_wrapper,
        resetKit_wrapper,
        nil, -- CreateESP (не используется в gui_builder)
        nil, -- StartAimLoop (не используется в gui_builder)
        nil, -- StopAimLoop (не используется в gui_builder)
        StartFollow_wrapper,
        StopFollow_wrapper,
        Cleanup_wrapper,
        PlayerManager.UpdatePlayerList -- Передаем реальную функцию
    )
    
    -- КРИТИЧЕСКИЙ ШАГ: Сохраняем GUI в Mega, чтобы другие модули его нашли
    Mega.Objects.GUI = TumbaGUI

    -- Инициализируем все модули
    print(GetText("print_esp_ready"))
    ESP.InitESP(Mega, GetText)
    
    print(GetText("print_kit_esp_ready"))
    KitESP.InitKitESP(Mega, TumbaGUI) -- KitESP требует TumbaGUI как родителя
    
    print(GetText("print_aim_ready", Mega.States.Keybinds.AimAssist))
    AimAssist.InitAimAssist(Mega, GetText)
    
    -- Запускаем PlayerManager. Он запустит циклы GodMode, Fly и т.д. ОДИН РАЗ,
    -- если они были сохранены как 'true'.
    PlayerManager.InitPlayerManager(Mega, GetText, showNotification_wrapper, ToggleMenu)
    
    -- Запускаем циклы Утилит (AutoSave, Visuals)
    Utilities.AutoSaveConfig(Mega)
    Utilities.NoFog(Mega)
    Utilities.FullBright(Mega)
    Utilities.NightMode(Mega)
    Utilities.RemoveShadows(Mega)
    Utilities.FameSpam(Mega)

    -- Назначаем главную клавишу меню
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode.Name == Mega.States.Keybinds.Menu then
            ToggleMenu()
        end
    end)
    
    -- *** ФИКС ДЛЯ СЛОМАННОГО СПИСКА ИГРОКОВ ***
    -- InitPlayerManager запускает цикл, который вызывает UpdatePlayerList БЕЗ аргументов.
    -- Это вызывает ошибку. Этот новый цикл будет работать ПРАВИЛЬНО.
    local PlayerListContainer = TumbaGUI:FindFirstChild("MainFrame"):FindFirstChild("ContentContainer"):FindFirstChild(GetText("tab_users") .. "Content"):FindFirstChild("PlayersList")
    local ListLayout = PlayerListContainer and PlayerListContainer:FindFirstChild("UIListLayout")
    local PlayerItemTemplate = PlayerListContainer and PlayerListContainer:FindFirstChild("PlayerItemTemplate")

    RunService.Heartbeat:Connect(function()
        if TumbaGUI and TumbaGUI.Enabled and PlayerListContainer and PlayerListContainer.Visible then
            if ListLayout and PlayerItemTemplate then
                -- Этот вызов правильный, он передает нужные элементы GUI
                PlayerManager.UpdatePlayerList(Mega, GetText, PlayerListContainer, ListLayout, PlayerItemTemplate)
            end
        end
    end)
    
    print(GetText("print_all_ready"))
    print(GetText("print_menu_key", Mega.States.Keybinds.Menu))
end

-- 6. --- ЗАПУСК: СНАЧАЛА ВЫБОР ЯЗЫКА ---
local LanguagePrompt = GUIBuilder.CreateLanguagePrompt(function(lang)
    -- Когда язык выбран, запускаем Tumba и удаляем окно выбора
    InitializeTumba(lang)
    LanguagePrompt:Destroy()
end)
