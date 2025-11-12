-- Система локализации
local CurrentLanguage = "en" -- По умолчанию

local Strings = {
    -- Уведомления
    ["notify_enabled"] = { ru = "ВКЛЮЧЕНО", en = "ENABLED" },
    ["notify_disabled"] = { ru = "ВЫКЛЮЧЕНО", en = "DISABLED" },
    ["notify_kit_esp_updated"] = { ru = "Kit ESP обновлен", en = "Kit ESP updated" },
    ["notify_kit_esp_on"] = { ru = "Kit ESP включен", en = "Kit ESP enabled" },
    ["notify_kit_esp_off"] = { ru = "Kit ESP выключен", en = "Kit ESP disabled" },
    ["notify_follow_start"] = { ru = "Слежение за %s включено", en = "Following %s enabled" },
    ["notify_follow_stop"] = { ru = "Слежение отключено", en = "Following disabled" },
    ["notify_config_saved"] = { ru = "Конфиг сохранен (#%d)", en = "Config saved (#%d)" },
    ["notify_config_loaded"] = { ru = "Конфиг загружен", en = "Config loaded" },
    ["notify_config_not_found"] = { ru = "Конфиг не найден", en = "Config not found" },
    ["notify_settings_reset"] = { ru = "Настройки сброшены", en = "Settings reset" },
    ["notify_keybind_set"] = { ru = "%s привязана к %s", en = "%s bound to %s" },
    ["notify_fov_color_changed"] = { ru = "🎨 Цвет FOV изменен", en = "🎨 FOV color changed" },
    ["notify_team_color_changed"] = { ru = "🎨 Цвет команды изменен", en = "🎨 Team color changed" },
    ["notify_enemy_color_changed"] = { ru = "🎨 Цвет врага изменен", en = "🎨 Enemy color changed" },
    ["notify_theme_changed"] = { ru = "🎨 Цветовая тема изменена", en = "🎨 Theme color changed" },
    ["notify_chat_cleared"] = { ru = "🧹 Чат очищен", en = "🧹 Chat cleared" },
    ["notify_screenshot"] = { ru = "📸 Скриншот сохранен", en = "📸 Screenshot saved" },
    ["notify_reload"] = { ru = "🔄 Скрипт перезагружается...", en = "🔄 Script reloading..." },
    ["notify_cleanup"] = { ru = "🗑️ Скрипт выгружен", en = "🗑️ Script unloaded" },
    
    -- Ключи для вкладок
    ["tab_home"] = { ru = "🏠 ГЛАВНАЯ", en = "🏠 HOME" },
    ["tab_esp"] = { ru = "👁️ ESP", en = "👁️ ESP" },
    ["tab_aim"] = { ru = "🎯 AIM", en = "🎯 AIM" },
    ["tab_player"] = { ru = "⚡ ИГРОК", en = "⚡ PLAYER" },
    ["tab_combat"] = { ru = "🎮 БОЙ", en = "🎮 COMBAT" },
    ["tab_visuals"] = { ru = "🌈 ВИЗУАЛЫ", en = "🌈 VISUALS" },
    ["tab_users"] = { ru = "👥 ИГРОКИ", en = "👥 PLAYERS" },
    ["tab_utils"] = { ru = "🔧 УТИЛИТЫ", en = "🔧 UTILITIES" },
    ["tab_settings"] = { ru = "⚙️ НАСТРОЙКИ", en = "⚙️ SETTINGS" },

    -- GUI
    ["title_bar"] = { ru = "💎 TUMBA MEGA SYSTEM v%s 💎", en = "💎 TUMBA MEGA SYSTEM v%s 💎" },
    ["title_bar_with_tab"] = { ru = "💎 %s - TUMBA MEGA SYSTEM 💎", en = "💎 %s - TUMBA MEGA SYSTEM 💎" },
    ["keybind_listening"] = { ru = "Нажмите клавишу...", en = "Press a key..." },
    ["keybind_none"] = { ru = "Нет привязки", en = "None" },
    ["keybind_current"] = { ru = "%s: %s", en = "%s: %s" },
    ["slider_label"] = { ru = "%s: %s", en = "%s: %s" },
    ["dropdown_label"] = { ru = " %s:", en = " %s:" },

    -- Вкладка: Главная
    ["section_status"] = { ru = "💎 СИСТЕМНЫЙ СТАТУС", en = "💎 SYSTEM STATUS" },
    ["toggle_autosave"] = { ru = "🔄 Авто-сохранение конфигов", en = "🔄 Auto-save configs" },
    ["toggle_perf_mode"] = { ru = "⚡ Режим производительности", en = "⚡ Performance Mode" },
    ["section_quick_access"] = { ru = "🚀 БЫСТРЫЙ ДОСТУП", en = "🚀 QUICK ACCESS" },
    ["button_esp_toggle"] = { ru = "👁️ ВКЛ/ВЫКЛ ESP", en = "👁️ TOGGLE ESP" },
    ["button_aim_toggle"] = { ru = "🎯 ВКЛ/ВЫКЛ Aim Assist", en = "🎯 TOGGLE Aim Assist" },
    ["button_speed_toggle"] = { ru = "⚡ ВКЛ/ВЫКЛ Speed Hack", en = "⚡ TOGGLE Speed Hack" },
    ["section_stats"] = { ru = "📊 СТАТИСТИКА СИСТЕМЫ", en = "📊 SYSTEM STATISTICS" },
    ["stats_label"] = { ru = "📈 СТАТИСТИКА:\n🎯 Убийств: %d\n💀 Смертей: %d\n🎮 Время игры: %dм\n💾 Конфигов сохранено: %d", en = "📈 STATISTICS:\n🎯 Kills: %d\n💀 Deaths: %d\n🎮 Play Time: %dm\n💾 Config Saves: %d" },

    -- Вкладка: ESP
    ["section_esp_main"] = { ru = "👁️ ОСНОВНЫЕ НАСТРОЙКИ ESP (Игроки)", en = "👁️ MAIN ESP SETTINGS (Players)" },
    ["toggle_esp"] = { ru = "Включить ESP", en = "Enable ESP" },
    ["section_esp_visuals"] = { ru = "⚙️ НАСТРОЙКИ ВИЗУАЛОВ", en = "⚙️ VISUALS SETTINGS" },
    ["toggle_esp_boxes"] = { ru = "Показывать боксы", en = "Show Boxes" },
    ["toggle_esp_names"] = { ru = "Показывать имена", en = "Show Names" },
    ["toggle_esp_health"] = { ru = "Показывать здоровье", en = "Show Health" },
    ["toggle_esp_distance"] = { ru = "Показывать дистанцию", en = "Show Distance" },
    ["toggle_esp_tracers"] = { ru = "Показывать трейсеры", en = "Show Tracers" },
    ["toggle_esp_team"] = { ru = "Показывать команду", en = "Show Team" },
    ["slider_esp_max_dist"] = { ru = "Макс. дистанция ESP", en = "Max ESP Distance" },
    ["section_esp_colors"] = { ru = "🎨 ЦВЕТА ESP", en = "🎨 ESP COLORS" },
    ["button_team_color"] = { ru = "🎨 Изменить цвет команды", en = "🎨 Change Team Color" },
    ["button_enemy_color"] = { ru = "🎨 Изменить цвет врага", en = "🎨 Change Enemy Color" },
    ["section_kit_esp"] = { ru = "🛠️ KIT ESP (Ресурсы и Киты)", en = "🛠️ KIT ESP (Resources & Kits)" },
    ["toggle_kit_esp"] = { ru = "Включить Kit ESP", en = "Enable Kit ESP" },
    ["section_kit_filters"] = { ru = "⚙️ ФИЛЬТРЫ", en = "⚙️ FILTERS" },
    ["toggle_kit_iron"] = { ru = "Показывать: Руда (Iron)", en = "Show: Ore (Iron)" },
    ["toggle_kit_bee"] = { ru = "Показывать: Пчелиные соты (Bee)", en = "Show: Honeycomb (Bee)" },
    ["toggle_kit_essence"] = { ru = "Показывать: Эссенция (Nature Essence)", en = "Show: Essence (Nature Essence)" },
    ["toggle_kit_thorns"] = { ru = "Показывать: Шипы (Thorns)", en = "Show: Thorns" },
    ["toggle_kit_mushrooms"] = { ru = "Показывать: Грибы (Mushrooms)", en = "Show: Mushrooms" },
    ["toggle_kit_critstar"] = { ru = "Показывать: Звезда Крита (Crit Star)", en = "Show: Crit Star" },
    ["toggle_kit_vitstar"] = { ru = "Показывать: Звезда Жизни (Vitality Star)", en = "Show: Vitality Star" },
    ["button_kit_esp_apply"] = { ru = "🔄 Применить и Обновить Kit ESP", en = "🔄 Apply and Refresh Kit ESP" },

    -- Вкладка: Aim
    ["section_aim_main"] = { ru = "🎯 ОСНОВНЫЕ НАСТРОЙКИ AIM", en = "🎯 MAIN AIM SETTINGS" },
    ["toggle_aim"] = { ru = "Включить Aim Assist", en = "Enable Aim Assist" },
    ["section_aim_settings"] = { ru = "⚙️ НАСТРОЙКИ ПАРАМЕТРОВ", en = "⚙️ PARAMETER SETTINGS" },
    ["toggle_aim_show_fov"] = { ru = "Показывать FOV", en = "Show FOV" },
    ["button_aim_fov_color"] = { ru = "🎨 Изменить цвет FOV", en = "🎨 Change FOV Color" },
    ["dropdown_aim_target"] = { ru = "Цель прицела", en = "Aim Target" },
    ["dropdown_aim_target_head"] = { ru = "Head (Голова)", en = "Head" },
    ["dropdown_aim_target_upper"] = { ru = "UpperTorso (Верхняя часть тела)", en = "UpperTorso" },
    ["dropdown_aim_target_lower"] = { ru = "LowerTorso (Нижняя часть тела)", en = "LowerTorso" },
    ["dropdown_aim_target_root"] = { ru = "HumanoidRootPart (Центр)", en = "HumanoidRootPart (Center)" },
    ["slider_aim_fov"] = { ru = "FOV прицела", en = "Aim FOV" },
    ["slider_aim_smooth"] = { ru = "Плавность", en = "Smoothness" },
    ["slider_aim_range"] = { ru = "Дальность", en = "Range" },
    ["section_aim_key"] = { ru = "🎯 КЛАВИША AIM", en = "🎯 AIM KEY" },
    ["keybind_aim"] = { ru = "🔑 Изменить клавишу Aim", en = "🔑 Change Aim Key" },
    ["toggle_aim_silent"] = { ru = "Тихий прицел", en = "Silent Aim" },
    ["toggle_aim_prediction"] = { ru = "Предсказание движения", en = "Movement Prediction" },

    -- Вкладка: Игрок
    ["section_player_movement"] = { ru = "⚡ ДВИЖЕНИЕ", en = "⚡ MOVEMENT" },
    ["toggle_speed"] = { ru = "Спидхак", en = "Speedhack" },
    ["slider_speed"] = { ru = "Скорость", en = "Speed" },
    ["toggle_fly"] = { ru = "Режим полета", en = "Fly Mode" },
    ["toggle_inf_jump"] = { ru = "Бесконечный прыжок", en = "Infinite Jump" },
    ["section_player_defense"] = { ru = "🛡️ ЗАЩИТА", en = "🛡️ DEFENSE" },
    ["toggle_godmode"] = { ru = "Режим бога", en = "God Mode" },
    ["toggle_noclip"] = { ru = "Ноклип", en = "Noclip" },

    -- Вкладка: Бой
    ["section_combat_auto"] = { ru = "🎯 АВТОМАТИЗАЦИЯ", en = "🎯 AUTOMATION" },
    ["toggle_triggerbot"] = { ru = "Триггер-бот", en = "Trigger Bot" },
    ["toggle_autoshoot"] = { ru = "Авто-стрельба", en = "Auto Shoot" },
    ["toggle_rapidfire"] = { ru = "Быстрая стрельба", en = "Rapid Fire" },
    ["section_combat_accuracy"] = { ru = "🎯 ТОЧНОСТЬ", en = "🎯 ACCURACY" },
    ["toggle_norecoil"] = { ru = "Нет отдачи", en = "No Recoil" },
    ["toggle_nospread"] = { ru = "Нет разброса", en = "No Spread" },

    -- Вкладка: Визуалы
    ["section_visuals_env"] = { ru = "🌍 ОКРУЖЕНИЕ", en = "🌍 ENVIRONMENT" },
    ["button_visuals_settings"] = { ru = "⚙️ Настроить Визуалы Среды (NoFog, Brightness, Shadows)", en = "⚙️ Adjust Environment Visuals (NoFog, Brightness, Shadows)" },
    ["toggle_nofog"] = { ru = "Убрать туман", en = "Remove Fog" },
    ["toggle_fullbright"] = { ru = "Яркое освещение", en = "Full Bright" },
    ["toggle_nightmode"] = { ru = "Ночной режим", en = "Night Mode" },
    ["toggle_removeshadows"] = { ru = "Убрать тени", en = "Remove Shadows" },

    -- Вкладка: Утилиты
    ["section_utils_tools"] = { ru = "🔧 ИНСТРУМЕНТЫ", en = "🔧 TOOLS" },
    ["button_clear_chat"] = { ru = "🧹 Очистить игровой чат", en = "🧹 Clear Game Chat" },
    ["button_screenshot"] = { ru = "📸 Сделать скриншот", en = "📸 Take Screenshot" },
    ["button_server_info"] = { ru = "🔍 Информация об сервере", en = "🔍 Server Info" },
    ["section_utils_fun"] = { ru = "🎪 РАЗВЛЕЧЕНИЯ", en = "🎪 MISC" },
    ["toggle_fame_spam"] = { ru = "Спам в чат", en = "Chat Spam" },
    ["button_reload_script"] = { ru = "🔄 Релоад скрипта", en = "🔄 Reload Script" },

    -- Вкладка: Настройки
    ["section_settings_appearance"] = { ru = "🎨 ВНЕШНИЙ ВИД", en = "🎨 APPEARANCE" },
    ["button_change_theme"] = { ru = "🌈 Сменить цветовую тему", en = "🌈 Change Color Theme" },
    ["keybind_menu"] = { ru = "🔑 Изменить клавишу меню", en = "🔑 Change Menu Key" },
    ["section_settings_config"] = { ru = "💾 УПРАВЛЕНИЕ КОНФИГАМИ", en = "💾 CONFIG MANAGEMENT" },
    ["button_config_save"] = { ru = "💾 Сохранить конфиг", en = "💾 Save Config" },
    ["button_config_load"] = { ru = "📂 Загрузить конфиг", en = "📂 Load Config" },
    ["button_config_reset"] = { ru = "🔄 Сбросить настройки", en = "🔄 Reset Settings" },
    ["button_cleanup"] = { ru = "🗑️ Очистить и выгрузить скрипт", en = "🗑️ Cleanup and Unload Script" },

    -- Вкладка: Игроки
    ["section_player_list"] = { ru = "👥 СПИСОК ИГРОКОВ НА СЕРВЕРЕ", en = "👥 SERVER PLAYER LIST" },
    ["button_stop_follow"] = { ru = "❌ Отключить слежение", en = "❌ Stop Following" },
    ["playerlist_name"] = { ru = "ИМЯ", en = "NAME" },
    ["playerlist_team"] = { ru = "КОМАНДА", en = "TEAM" },
    ["playerlist_hp"] = { ru = "HP", en = "HP" },
    ["playerlist_dist"] = { ru = "ДИСТ.", en = "DIST." },
    ["playerlist_team_none"] = { ru = "НЕТ", en = "NONE" },
    ["playerlist_hp_dead"] = { ru = "HP: DEAD", en = "HP: DEAD" },
    ["playerlist_hp_format"] = { ru = "HP: %d", en = "HP: %d" },
    ["playerlist_dist_none"] = { ru = "ДИСТ: ---", en = "DIST: ---" },
    ["playerlist_dist_format"] = { ru = "ДИСТ: %dм", en = "DIST: %dm" },

    -- Сообщения в консоль (print)
    ["print_esp_on"] = { ru = "👁️ ESP: ВКЛЮЧЕН", en = "👁️ ESP: ENABLED" },
    ["print_esp_off"] = { ru = "👁️ ESP: ВЫКЛЮЧЕН", en = "👁️ ESP: DISABLED" },
    ["print_aim_on"] = { ru = "🎯 Aim Assist: ВКЛЮЧЕН", en = "🎯 Aim Assist: ENABLED" },
    ["print_aim_off"] = { ru = "🎯 Aim Assist: ВЫКЛЮЧЕН", en = "🎯 Aim Assist: DISABLED" },
    ["print_aim_active"] = { ru = "🎯 Aim Assist АКТИВИРОВАН", en = "🎯 Aim Assist ACTIVATED" },
    ["print_aim_inactive"] = { ru = "🎯 Aim Assist ДЕАКТИВИРОВАН", en = "🎯 Aim Assist DEACTIVATED" },
    ["print_speed_on"] = { ru = "⚡ Speed Hack: %s единиц", en = "⚡ Speed Hack: %s units" },
    ["print_speed_off"] = { ru = "⚡ Speed Hack: 16 единиц", en = "⚡ Speed Hack: 16 units" },
    ["print_load_success"] = { ru = "🔥 TUMBA MEGA SYSTEM v%s УСПЕШНО ЗАГРУЖЕН!", en = "🔥 TUMBA MEGA SYSTEM v%s LOADED SUCCESSFULLY!" },
    ["print_created_by"] = { ru = "💎 Создано: %s", en = "💎 Created by: %s" },
    ["print_for"] = { ru = "🎯 Специально для: %s", en = "🎯 Especially for: %s" },
    ["print_build_date"] = { ru = "📅 Сборка: %s", en = "📅 Build: %s" },
    ["print_menu_key"] = { ru = "🎮 Используйте %s для открытия меню", en = "🎮 Use %s to open the menu" },
    ["print_esp_ready"] = { ru = "👁️ ESP готов к использованию", en = "👁️ ESP is ready to use" },
    ["print_kit_esp_ready"] = { ru = "🛠️ Kit ESP добавлен и готов к использованию", en = "🛠️ Kit ESP added and ready to use" },
    ["print_aim_ready"] = { ru = "🎯 Aim Assist готов (Нажми %s для активации)", en = "🎯 Aim Assist ready (Press %s to activate)" },
    ["print_all_ready"] = { ru = "⚡ Все функции активированы!", en = "⚡ All functions activated!" },
    ["print_menu_open"] = { ru = "🚀 TUMBA MEGA SYSTEM v%s АКТИВИРОВАН", en = "🚀 TUMBA MEGA SYSTEM v%s ACTIVATED" },
    ["print_menu_navigate"] = { ru = "📁 Используйте вкладки для навигации", en = "📁 Use tabs to navigate" },
    ["print_menu_closed"] = { ru = "📱 Меню закрыто", en = "📱 Menu closed" },

    -- Другое
    ["esp_studs"] = { ru = "%d studs", en = "%d studs" },
    ["esp_hp"] = { ru = "HP: %d", en = "HP: %d" },
}

local function GetText(key, ...)
    local lang = CurrentLanguage
    local str = Strings[key]

    if str and str[lang] then
        local text = str[lang]
        local args = {...}
        if #args > 0 then
            local success, result = pcall(string.format, text, ...)
            if success then
                return result
            else
                return text
            end
        else
            return text
        end
    else
        return key
    end
end

return {
    CurrentLanguage = CurrentLanguage,
    SetLanguage = function(lang) CurrentLanguage = lang end,
    GetText = GetText
}
