PLUGIN = nul

function Initialize(Plugin)
  Plugin:SetName("PlayerMarkers")
  Plugin:SetVersion(1)
  
  PLUGIN = Plugin
  
  LOG("Initialized " .. Plugin:GetName() .. " v." .. Plugin:GetVersion())
  
  return true
end

function OnDisable()
  LOG("Shutting down " .. PLUGIN:GetName())
end
