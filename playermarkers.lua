PLUGIN = nul

local PLAYERS_JSON = "webadmin/files/players.json"

function Initialize(Plugin)
	Plugin:SetName("PlayerMarkers")
	Plugin:SetVersion(1)

	PLUGIN = Plugin

	LOG("Initialized " .. Plugin:GetName() .. " v." .. Plugin:GetVersion())

	cPluginManager:AddHook(cPluginManager.HOOK_TICK, OnTick)

	return true
end

function OnDisable()
	LOG("Disabled " .. PLUGIN:GetName())
end

local nextDueFileGeneration = 0
local lastTick = 0

function OnTick(TimeDelta)
	lastTick = lastTick + TimeDelta
	if (nextDueFileGeneration <= lastTick) then
		nextDueFileGeneration = lastTick + 5000
		local players = {}
		cRoot:Get():ForEachPlayer(function(a_Player)
			table.insert(players, {
				username = a_Player:GetName(),
				world = a_Player:GetWorld():GetName(),
				x = a_Player:GetPosition().x,
				y = a_Player:GetPosition().y,
				z = a_Player:GetPosition().z
			})
		end)

		json = cJson:Serialize({players=players}, { indentation="" })
		f = io.open(PLAYERS_JSON .. ".tmp", "w")
		f:write(json)
		f:close()
		cFile:Rename(PLAYERS_JSON .. ".tmp", PLAYERS_JSON)
	end
end
