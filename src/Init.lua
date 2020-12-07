-- Init global
AAddonReminder = {}
AAddonReminder.FRAMES = {}
AAddonReminder.VERSION = GetAddOnMetadata("Anthracite-Addon-Reminder", "Version")
AAddonReminder.AUTHOR = GetAddOnMetadata("Anthracite-Addon-Reminder", "Author")

AAddonReminder.INTERNAL = {}
AAddonReminder.INTERNAL.GetCurrentTime = function() -- Get current date and transform it to time
    local currentDate = date("%Y-%m-%d %H:%M:%S");
    local y, m, d, Hr, Min, Sec = currentDate:match '(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)';

    local currentTime = time
            { year = y, month = m, day = d,
            hour = Hr, min = Min, sec = Sec };

    return currentTime;
end

-- Event handler
AAddonReminder.EVENTHANDLER = function(self, event, arg1, arg2, ...)
    if event == "ADDON_LOADED" and arg1 == "Anthracite-Addon-Reminder" then

       local currentTime = AAddonReminder.INTERNAL.GetCurrentTime();

        -- If (reset or new addon) or nextFire time has passed
        if AMR_AddonReminder_NextFire == nil or AMR_AddonReminder_NextFire < currentTime then

            -- Show message
            AAddonReminder.FRAMES['reminder']:Show();

            AMR_AddonReminder_LastFire = currentTime;
        end
    end
end