local obj = {}
obj.__index = obj

obj.name = "MalthesMoveWindow"
obj.version = "0.2"
obj.author = "Malthe Jørgensen <malthe.jorgensen@gmail.com>"
obj.license = "MIT"

-- Inspired by
-- https://gist.github.com/kizzx2/e542fa74b80b7563045a
-- https://gist.github.com/nicwolff/b95cda99e672eeb28911adadbc9b0054

function obj:init()
log = hs.logger.new('moveWindow','debug')

function get_window_under_mouse()
  -- Invoke `hs.application` because `hs.window.orderedWindows()` doesn't do it
  -- and breaks itself
  local _ = hs.application

  local my_pos = hs.geometry.new(hs.mouse.getAbsolutePosition())
  local my_screen = hs.mouse.getCurrentScreen()

  return hs.fnutils.find(hs.window.orderedWindows(), function(w)
    return my_screen == w:screen() and my_pos:inside(w:frame())
  end)
end

dragging_win = nil
dragging_mode = 1
has_already_focused = false

lastCursorPosition = nil
moveTimerHandle = nil
function moveWindow()
    local window = dragging_win
    local frame = window:frame()
    -- local mods = hs.eventtap.checkKeyboardModifiers()

    local currentCursorPosition = hs.mouse.absolutePosition()
    if lastCursorPosition then
        local deltaX = currentCursorPosition.x - lastCursorPosition.x
        local deltaY = currentCursorPosition.y - lastCursorPosition.y

        if not has_already_focused and (deltaX > 0 or deltaX > 0) then
          window:raise()
          window:focus()
          has_already_focused = true
        end

        frame.x = frame.x + deltaX
        frame.y = frame.y + deltaY
        window:setFrame(frame, 0.01) -- 0.01 = 50 ms animation time
    end
    lastCursorPosition = currentCursorPosition
end

function resizeWindow()
    local window = dragging_win
    local frame = window:frame()

    local currentCursorPosition = hs.mouse.absolutePosition()
    if lastCursorPosition then
        local deltaX = currentCursorPosition.x - lastCursorPosition.x
        local deltaY = currentCursorPosition.y - lastCursorPosition.y

        if not has_already_focused and (deltaX > 0 or deltaX > 0) then
          window:raise()
          window:focus()
          has_already_focused = true
        end

        frame.w = frame.w + deltaX
        frame.h = frame.h + deltaY
        window:setFrame(frame, 0.01) -- 0.01 = 50 ms animation time
    end
    lastCursorPosition = currentCursorPosition
end

lastCursorPosition = nil
moveTimerHandle = nil
resizeTimerHandle = nil

flags_event = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(e)
  local flags = e:getFlags()
  if flags.ctrl and flags.shift and dragging_win == nil then
    dragging_win = get_window_under_mouse()
    dragging_mode = 1
    lastCursorPosition = hs.mouse.absolutePosition()
    moveTimerHandle = hs.timer.doEvery(0.03, moveWindow)
  elseif flags.alt and flags.shift and dragging_win == nil then
    dragging_win = get_window_under_mouse()
    dragging_mode = 2
    lastCursorPosition = hs.mouse.absolutePosition()
    resizeTimerHandle = hs.timer.doEvery(0.03, resizeWindow)
  else
    if resizeTimerHandle then
      resizeTimerHandle:stop()
    end
    if moveTimerHandle then
      moveTimerHandle:stop()
    end
    dragging_win = nil
    has_already_focused = false
  end
  return nil
end)
flags_event:start()
end



return obj
