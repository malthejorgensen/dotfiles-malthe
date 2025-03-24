
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

  -- app:mainWindow():moveToUnit'[0.0,0.0,0.5,0.5]'
  -- app:mainWindow():moveToUnit'[0.33,0.33,0.66,0.66]'
  app:mainWindow():setTopLeft(hs.geometry.point(400,0))
  app:mainWindow():setSize(hs.geometry.size(800,400))
end)

hs.loadSpoon("MalthesMoveWindow")
