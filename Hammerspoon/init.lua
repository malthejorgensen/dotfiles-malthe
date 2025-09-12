function postitionQuakeTerminal(window, screenSize)
    local windowSize = hs.geometry.size(800,400)
    local fromLeft = (screenSize.w / 2) - (windowSize.w / 2)
    -- Position and size window
    window:setTopLeft(hs.geometry.point(fromLeft,0))
    window:setSize(windowSize)
end


-- "Quake" terminal for WezTerm
-- From: https://github.com/kovidgoyal/kitty/issues/45#issuecomment-568920629
hs.hotkey.bind({"ctrl"}, "§", function()
    local app = hs.application.get("WezTerm")
    if app then
        if not app:mainWindow() then
            app:selectMenuItem({"WezTerm", "New Window"})
        elseif app:isFrontmost() then
            app:hide()
        else
            app:activate()
        end
    else
        hs.application.launchOrFocus("WezTerm")

        app = hs.application.get("WezTerm")
    end

    local window = app:mainWindow()

    -- If we have more than 1 screen put the terminal on the large screen (assumed to be `screens[2]`)
    -- You'd think you could just run `positionQuakeTerminal()` before the below code and do away with
    -- the `else`-branch. But that produces a lot of flashing of the terminal window, whereas this
    -- structure of the code does not.
    local screens = hs.screen.allScreens()
    if #screens > 1 then
        local currentScreen = window:screen()
        local targetScreen = screens[2]

        if currentScreen ~= targetScreen then
            postitionQuakeTerminal(window)
            window:moveToScreen(targetScreen, false, true, 0)
        end
    else
        local currentScreen = window:screen()
        local targetScreen = screens[2]
        local screenSize = currentScreen:frame()
        postitionQuakeTerminal(window, screenSize)
    end
end)

hs.loadSpoon("MalthesMoveWindow")
