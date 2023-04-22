local InputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

InputService.WindowFocused:Connect(function()
  RunService:Set3dRenderingEnabled(true)
 end)

InputService.WindowFocusReleased:Connect(function()
  RunService:Set3dRenderingEnabled(false)
end)

setfpscap(10)
