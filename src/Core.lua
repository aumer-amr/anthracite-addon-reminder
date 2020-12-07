local FRAMES = AAddonReminder.FRAMES;
local EVENTHANDLER = AAddonReminder.EVENTHANDLER;
local VERSION = AAddonReminder.VERSION;
local AUTHOR = AAddonReminder.AUTHOR;
local INTERNAL = AAddonReminder.INTERNAL;

-- Basic info
local screenWidth = GetScreenWidth() * UIParent:GetEffectiveScale();
local screenHeight = GetScreenHeight() * UIParent:GetEffectiveScale();

-- Setup frame
local reminderFrame = CreateFrame("Frame", nil, UIParent);
reminderFrame:SetWidth(600); 
reminderFrame:SetHeight(1);
reminderFrame:SetAlpha(.90);
reminderFrame:SetPoint("CENTER", 0, (screenHeight / 2) - 100);

reminderFrame.text = reminderFrame:CreateFontString(nil, "ARTWORK");
reminderFrame.text:SetFont("Fonts\\FRIZQT__.TTF", 32, "OUTLINE");
reminderFrame.text:SetPoint("CENTER", 0, 0);
reminderFrame.text:SetShadowOffset(1, -1);
reminderFrame.text:SetTextColor(255, 0, 0, 1);
reminderFrame.text:SetText("Backup interface & WTF folder, update addons!");
reminderFrame:Hide();
FRAMES['reminder'] = reminderFrame;

-- Setup events
reminderFrame:RegisterEvent("ADDON_LOADED");
reminderFrame:RegisterEvent("PLAYER_LOGOUT");
reminderFrame:SetScript("OnEvent", EVENTHANDLER);

-- Setup slash cli
SLASH_AAddonReminder1 = "/anar"
function SlashCmdList.AAddonReminder(msg, editbox)
    if msg == "confirm" then -- Confirm backups & updates, remove message from screen
        if AMR_AddonReminder_NextFire ~= nil and AMR_AddonReminder_NextFire > INTERNAL.GetCurrentTime() then
            DEFAULT_CHAT_FRAME:AddMessage("|cFF70BF44ANAR:|r Nothing to confirm.");
        else
            reminderFrame:Hide();
        
            -- Calculate new fire time and store data
            local nextFireTime = INTERNAL.GetCurrentTime() + 7*24*60*60;

            AMR_AddonReminder_NextFire = nextFireTime;

            DEFAULT_CHAT_FRAME:AddMessage("|cFF70BF44ANAR:|r Confirmed, will ask again in 7 days.");
        end
    elseif msg == "show" then -- Show message
        reminderFrame:Show();
    elseif msg == "reset" then -- Reset time
        AMR_AddonReminder_NextFire = nil;
        AMR_AddonReminder_LastFire = nil;
        DEFAULT_CHAT_FRAME:AddMessage("|cFF70BF44ANAR:|r Reminder date reset, please /reload.");
    elseif msg == "debug" then -- Show debug data, or initialize if not
        DEFAULT_CHAT_FRAME:AddMessage("|cFF70BF44ANAR debug:|r");
        DEFAULT_CHAT_FRAME:AddMessage("|cFF70BF44>|r Version: " .. VERSION);
        DEFAULT_CHAT_FRAME:AddMessage("|cFF70BF44>|r Author: " .. AUTHOR);
        
        if AMR_AddonReminder_NextFire == nil then
            DEFAULT_CHAT_FRAME:AddMessage("|cFF70BF44>|r Next trigger not set");
        else
            DEFAULT_CHAT_FRAME:AddMessage("|cFF70BF44>|r Next trigger will be at " .. AMR_AddonReminder_NextFire);
        end

        if AMR_AddonReminder_LastFire == nil then
            DEFAULT_CHAT_FRAME:AddMessage("|cFF70BF44>|r Last trigger not set");
        else
            DEFAULT_CHAT_FRAME:AddMessage("|cFF70BF44>|r Last trigger was at " .. AMR_AddonReminder_LastFire);
        end
    else -- Show this help
        DEFAULT_CHAT_FRAME:AddMessage("|cFF70BF44Anthracite Addon Reminder " .. VERSION .. "|r by " .. AUTHOR);
        DEFAULT_CHAT_FRAME:AddMessage("|cFF70BF44---------------------|r");
        DEFAULT_CHAT_FRAME:AddMessage("|cFF70BF44>|r /anar confirm - You've updated & backed up your interface/addons, won't show the message for 7 days.");
        DEFAULT_CHAT_FRAME:AddMessage("|cFF70BF44>|r /anar show - This will show the message on the screen.");
        DEFAULT_CHAT_FRAME:AddMessage("|cFF70BF44>|r /anar reset - Reset the timer, upon next reload or addon loading it will show the message.");
        DEFAULT_CHAT_FRAME:AddMessage("|cFF70BF44>|r /anar debug - Output some debug data for Aumer in case of problems.");
    end
end