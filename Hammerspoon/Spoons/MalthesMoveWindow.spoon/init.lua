local obj = {}
obj.__index = obj

obj.name = "MalthesMoveWindow"
obj.version = "0.2"
obj.author = "Malthe Jørgensen <malthe.jorgensen@gmail.com>"
obj.license = "MIT"

function obj:init()
log = hs.logger.new('moveWindow','debug')

lastCursorPosition = nil
moveTimerHandle = nil
function moveWindow()
    local window = hs.window.frontmostWindow()
    local frame = window:frame()

    local currentCursorPosition = hs.mouse.absolutePosition()
    if lastCursorPosition then
        local deltaX = currentCursorPosition.x - lastCursorPosition.x
        local deltaY = currentCursorPosition.y - lastCursorPosition.y

        frame.x = frame.x + deltaX
        frame.y = frame.y + deltaY
        window:setFrame(frame, 0.01) -- 0.01 = 50 ms animation time
    end
    lastCursorPosition = currentCursorPosition

    -- key repeat version
    -- if moveTimerHandle then
    --     moveTimerHandle:stop()
    -- end
    -- moveTimerHandle = hs.timer.doAfter(0.3, function() lastCursorPosition = nil end)
end
-- hs.hotkey.bind({"ctrl"}, "w", nil, nil, function() -- key repeat version

hs.hotkey.bind({"ctrl"}, "w",
function() -- key press
    -- log.i("Ctrl + W pressed")
    lastCursorPosition = hs.mouse.absolutePosition()
    moveTimerHandle = hs.timer.doEvery(0.03, moveWindow)
end,
function() -- key release
    -- log.i("Ctrl + W released")
    if moveTimerHandle then
      moveTimerHandle:stop()
    end
end)


resizeTimerHandle = nil
function resizeWindow()
    local window = hs.window.frontmostWindow()
    local frame = window:frame()

    local currentCursorPosition = hs.mouse.absolutePosition()
    if lastCursorPosition then
        local deltaX = currentCursorPosition.x - lastCursorPosition.x
        local deltaY = currentCursorPosition.y - lastCursorPosition.y

        frame.w = frame.w + deltaX
        frame.h = frame.h + deltaY
        window:setFrame(frame, 0.01) -- 0.01 = 50 ms animation time
    end
    lastCursorPosition = currentCursorPosition

    -- key repeat version
    -- if resizeTimerHandle then
    --     resizeTimerHandle:stop()
    -- end
    -- resizeTimerHandle = hs.timer.doAfter(0.3, function() lastCursorPosition = nil end)
end
-- hs.hotkey.bind({"ctrl"}, "w", nil, nil, function() -- key repeat version

lastCursorPosition = nil
resizeTimerHandle = nil
hs.hotkey.bind({"option"}, "w",
function() -- key press
    -- log.i("Ctrl + W pressed")
    lastCursorPosition = hs.mouse.absolutePosition()
    resizeTimerHandle = hs.timer.doEvery(0.03, resizeWindow)
end,
function() -- key release
    -- log.i("Ctrl + W released")
    if resizeTimerHandle then
      resizeTimerHandle:stop()
    end
end)
end

return obj
