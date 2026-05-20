local WindUI = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/Moon-820/Windi-Trx/refs/heads/main/dist/main.lua"
))()

WindUI:SetTheme("Dark")

local Window = WindUI:CreateWindow({
	Title  = "Nexus Hub",
	Icon   = "solar:star-bold-duotone",
	Folder = "NexusHub",
})

-- ─────────────────────────────────────────────────────────────
--  CARDS
-- ─────────────────────────────────────────────────────────────

local TabCards = Window:Tab({ Title = "Cards", Icon = "solar:widget-bold" })

local SWelcome = TabCards:Section({ Title = "Welcome" })
SWelcome:Card({
	Title    = "Welcome, Player!",
	Desc     = "Nexus Hub v2.0",
	Image    = "rbxassetid://7362423738",
	Color    = Color3.fromHex("#F97316"),
	Callback = function() print("profile") end,
})
SWelcome:Card({
	Title    = "24 871",
	Desc     = "Active members",
	Color    = Color3.fromHex("#7C3AED"),
	Badge    = { Text = "LIVE", Color = Color3.fromHex("#EF4444") },
	Callback = function() end,
})
SWelcome:Card({
	Title    = "Server v2.4.1",
	Desc     = "Last updated 2 hours ago",
	Color    = Color3.fromHex("#0EA5E9"),
	Badge    = { Text = "STABLE", Color = Color3.fromHex("#22C55E") },
	Callback = function() print("server info") end,
})
SWelcome:Card({
	Title    = "Announcement",
	Desc     = "New event dropping this Friday!",
	Color    = Color3.fromHex("#EC4899"),
	Badge    = { Text = "NEW", Color = Color3.fromHex("#F97316") },
	Callback = function() print("announcement") end,
})

local SStatus = TabCards:Section({ Title = "Status" })
SStatus:Card({
	Title    = "Premium",
	Desc     = "Full access enabled",
	Color    = Color3.fromHex("#22C55E"),
	Badge    = { Text = "Active" },
	Callback = function() end,
})
SStatus:Card({
	Title    = "Connected: Player",
	Color    = Color3.fromHex("#0091FF"),
	Image    = "rbxassetid://7362423738",
	Callback = function() end,
})
SStatus:Card({
	Title    = "Anti-AFK",
	Desc     = "Running in background",
	Color    = Color3.fromHex("#A78BFA"),
	Badge    = { Text = "ON", Color = Color3.fromHex("#22C55E") },
	Callback = function() print("anti-afk") end,
})
SStatus:Card({
	Title    = "Auto-Farm",
	Desc     = "Idle since 5 minutes",
	Color    = Color3.fromHex("#F59E0B"),
	Badge    = { Text = "IDLE", Color = Color3.fromHex("#6B7280") },
	Callback = function() print("farm status") end,
})

local SLinks = TabCards:Section({ Title = "Quick Links" })
SLinks:Card({ Title = "Documentation",  Desc = "Full guide on GitHub",    Callback = function() end })
SLinks:Card({ Title = "Discord",         Desc = "Join the community",      Callback = function() end })
SLinks:Card({ Title = "Trello Board",    Desc = "Roadmap & progress",       Callback = function() end })
SLinks:Card({ Title = "Bug Report",      Desc = "Submit an issue",          Callback = function() end })
SLinks:Card({ Title = "Changelog",       Desc = "What's new in v2.0",       Callback = function() end })

local SDyn = TabCards:Section({ Title = "Dynamic Card" })
local DynCard = SDyn:Card({
	Title    = "Module inactive",
	Desc     = "Click to activate",
	Color    = Color3.fromHex("#4B5563"),
	Callback = function() end,
})
DynCard.Callback = function()
	DynCard:SetTitle("Module active")
	DynCard:SetDesc("Running...")
	DynCard:SetColor(Color3.fromHex("#22C55E"))
end

local DynCard2 = SDyn:Card({
	Title    = "Stealth Mode",
	Desc     = "Click to enable",
	Color    = Color3.fromHex("#4B5563"),
	Callback = function() end,
})
local stealthOn = false
DynCard2.Callback = function()
	stealthOn = not stealthOn
	if stealthOn then
		DynCard2:SetTitle("Stealth Mode ON")
		DynCard2:SetDesc("You are invisible")
		DynCard2:SetColor(Color3.fromHex("#1F2937"))
	else
		DynCard2:SetTitle("Stealth Mode")
		DynCard2:SetDesc("Click to enable")
		DynCard2:SetColor(Color3.fromHex("#4B5563"))
	end
end

-- ─────────────────────────────────────────────────────────────
--  PROGRESSBAR
-- ─────────────────────────────────────────────────────────────

local TabPB = Window:Tab({ Title = "Progress", Icon = "solar:chart-bold" })

local SPB1 = TabPB:Section({ Title = "Player Stats" })
SPB1:ProgressBar({ Title = "XP",         Desc = "Level 42",       Value = 75,  Color = Color3.fromHex("#0091FF") })
SPB1:ProgressBar({ Title = "Health",     Value = 82,  Suffix = " HP",           Color = Color3.fromHex("#22C55E") })
SPB1:ProgressBar({ Title = "Mana",       Value = 55,  Suffix = " / 100",        Color = Color3.fromHex("#8B5CF6") })
SPB1:ProgressBar({ Title = "Stamina",    Value = 90,  Suffix = "%",             Color = Color3.fromHex("#F59E0B") })
SPB1:ProgressBar({ Title = "Armor",      Value = 40,  Suffix = " pts",          Color = Color3.fromHex("#64748B") })
SPB1:ProgressBar({ Title = "Hunger",     Value = 60,  Desc = "Eat something",   Color = Color3.fromHex("#F97316") })
SPB1:ProgressBar({ Title = "Reputation", Value = 33,  Suffix = " / 100",        Color = Color3.fromHex("#EC4899") })

local SPB2 = TabPB:Section({ Title = "Farm Progress" })
SPB2:ProgressBar({ Title = "Gold farmed",   Value = 20, Suffix = " / 500",   Color = Color3.fromHex("#EAB308") })
SPB2:ProgressBar({ Title = "Kills today",   Value = 45, Suffix = " / 100",   Color = Color3.fromHex("#EF4444") })
SPB2:ProgressBar({ Title = "Quest",         Value = 70, Desc = "Main quest",  Color = Color3.fromHex("#0EA5E9") })

local SPB3 = TabPB:Section({ Title = "Download" })
local DlBar = SPB3:ProgressBar({
	Title    = "Downloading",
	Desc     = "Waiting...",
	Value    = 0,
	Color    = Color3.fromHex("#F97316"),
	Callback = function(v) if v >= 100 then print("done") end end,
})

-- ─────────────────────────────────────────────────────────────
--  STATCARD
-- ─────────────────────────────────────────────────────────────

local TabStat = Window:Tab({ Title = "Stats", Icon = "solar:graph-bold" })

local SStat1 = TabStat:Section({ Title = "Combat" })
local KillsStat = SStat1:StatCard({
	Title   = "Kills",
	Value   = 0,
	Min     = 0,
	Max     = 50,
	Color   = Color3.fromHex("#EF4444"),
	Trend   = "0%",
	TrendUp = true,
})
SStat1:StatCard({
	Title   = "Deaths",
	Value   = 2,
	Min     = 0,
	Max     = 50,
	Color   = Color3.fromHex("#F97316"),
	Trend   = "+2",
	TrendUp = false,
})
SStat1:StatCard({
	Title    = "K/D Ratio",
	Value    = "—",
	ShowBar  = false,
	Color    = Color3.fromHex("#0091FF"),
	Callback = function() print("kd clicked") end,
})
SStat1:StatCard({
	Title   = "Assists",
	Value   = 7,
	Min     = 0,
	Max     = 50,
	Color   = Color3.fromHex("#A78BFA"),
	Trend   = "+7",
	TrendUp = true,
})
SStat1:StatCard({
	Title   = "Damage dealt",
	Value   = 3420,
	Min     = 0,
	Max     = 10000,
	Color   = Color3.fromHex("#F59E0B"),
	Trend   = "+340",
	TrendUp = true,
})

local SStat2 = TabStat:Section({ Title = "Economy" })
SStat2:StatCard({ Title = "Gold",      Value = 1200, Min = 0, Max = 5000,  Color = Color3.fromHex("#EAB308"), Trend = "+200",  TrendUp = true  })
SStat2:StatCard({ Title = "Gems",      Value = 45,   Min = 0, Max = 200,   Color = Color3.fromHex("#EC4899"), Trend = "+5",    TrendUp = true  })
SStat2:StatCard({ Title = "Debt",      Value = 300,  Min = 0, Max = 1000,  Color = Color3.fromHex("#EF4444"), Trend = "-50",   TrendUp = false })
SStat2:StatCard({ Title = "Trades",    Value = 14,   Min = 0, Max = 100,   Color = Color3.fromHex("#0EA5E9"), Trend = "+3",    TrendUp = true  })

local SStat3 = TabStat:Section({ Title = "Server" })
local XpStat = SStat3:StatCard({
	Title   = "Total XP",
	Value   = 1240,
	Min     = 0,
	Max     = 5000,
	Color   = Color3.fromHex("#A78BFA"),
	Trend   = "+320",
	TrendUp = true,
})
SStat3:StatCard({ Title = "Ping",    Value = 42,  Min = 0, Max = 500,  Color = Color3.fromHex("#22C55E"), Trend = "-8ms", TrendUp = true  })
SStat3:StatCard({ Title = "FPS",     Value = 60,  Min = 0, Max = 60,   Color = Color3.fromHex("#0091FF"), Trend = "+2",   TrendUp = true  })
SStat3:StatCard({ Title = "Players", Value = 18,  Min = 0, Max = 24,   Color = Color3.fromHex("#F97316"), Trend = "+3",   TrendUp = true  })
SStat3:StatCard({ Title = "Uptime",  Value = 99,  Min = 0, Max = 100,  Color = Color3.fromHex("#22C55E"), Trend = "99%",  TrendUp = true  })

-- ─────────────────────────────────────────────────────────────
--  PROFILECARD
-- ─────────────────────────────────────────────────────────────

local TabProfile = Window:Tab({ Title = "Players", Icon = "solar:user-bold" })

local SP1 = TabProfile:Section({ Title = "Staff" })
SP1:ProfileCard({
	Name      = "Ethanoj1",
	Role      = "Owner",
	Image     = "rbxassetid://7362423738",
	Status    = "online",
	RoleColor = Color3.fromHex("#EF4444"),
	Callback  = function() print("owner clicked") end,
})
SP1:ProfileCard({
	Name      = "NexusAdmin",
	Role      = "Admin",
	Status    = "online",
	RoleColor = Color3.fromHex("#F97316"),
	Callback  = function() end,
})
SP1:ProfileCard({
	Name      = "ModeratorX",
	Role      = "Moderator",
	Status    = "away",
	RoleColor = Color3.fromHex("#EAB308"),
	Callback  = function() end,
})
SP1:ProfileCard({
	Name      = "SupportBot",
	Role      = "Support",
	Status    = "busy",
	RoleColor = Color3.fromHex("#0EA5E9"),
	Callback  = function() end,
})

local SP2 = TabProfile:Section({ Title = "Community" })
SP2:ProfileCard({
	Name      = "QuantumDev",
	Role      = "Premium",
	Status    = "away",
	RoleColor = Color3.fromHex("#A78BFA"),
	Callback  = function() end,
})
SP2:ProfileCard({
	Name      = "GhostScript",
	Role      = "Member",
	Status    = "offline",
	RoleColor = Color3.fromHex("#6B7280"),
	Callback  = function() end,
})
SP2:ProfileCard({
	Name      = "LunaRBX",
	Role      = "Developer",
	Status    = "busy",
	RoleColor = Color3.fromHex("#8B5CF6"),
	Callback  = function() end,
})
SP2:ProfileCard({
	Name      = "StarlightFX",
	Role      = "VIP",
	Status    = "online",
	RoleColor = Color3.fromHex("#EC4899"),
	Callback  = function() end,
})
SP2:ProfileCard({
	Name      = "IronClad99",
	Role      = "Veteran",
	Status    = "away",
	RoleColor = Color3.fromHex("#F59E0B"),
	Callback  = function() end,
})

local SP3 = TabProfile:Section({ Title = "Dynamic Profile" })
local MyProfile = SP3:ProfileCard({
	Name      = "Me",
	Role      = "Guest",
	Status    = "offline",
	RoleColor = Color3.fromHex("#6B7280"),
	Callback  = function() end,
})

-- ─────────────────────────────────────────────────────────────
--  TIMELINE
-- ─────────────────────────────────────────────────────────────

local TabTL = Window:Tab({ Title = "Timeline", Icon = "solar:history-bold" })

local STL1 = TabTL:Section({ Title = "Live Feed" })
local Feed = STL1:Timeline({
	Title = "Activity Feed",
	Entries = {
		{ Time = "now",    Text = "Script loaded successfully",         Type = "success" },
		{ Time = "1s ago", Text = "Server connection established",      Type = "info"    },
		{ Time = "3s ago", Text = "Anti-AFK activated",                 Type = "info"    },
		{ Time = "5s ago", Text = "Auto-farm initialized",              Type = "info"    },
		{ Time = "10s ago",Text = "Reconnection attempt",               Type = "warning" },
		{ Time = "15s ago",Text = "Latency spike detected (230ms)",     Type = "warning" },
		{ Time = "30s ago",Text = "Previous session ended",             Type = "default" },
		{ Time = "1m ago", Text = "Config file loaded",                 Type = "success" },
		{ Time = "2m ago", Text = "Hub injected",                       Type = "success" },
	},
	MaxEntries = 15,
})

local STL2 = TabTL:Section({ Title = "Changelog" })
STL2:Timeline({
	Title = "What's new",
	Entries = {
		{ Time = "v2.0", Text = "Full rewrite — new UI, better performance", Type = "success" },
		{ Time = "v1.9", Text = "Added Countdown, dynamic cards",             Type = "info"    },
		{ Time = "v1.8", Text = "Added StatCard, ProfileCard, Timeline",      Type = "info"    },
		{ Time = "v1.7", Text = "Added ProgressBar and Card",                 Type = "info"    },
		{ Time = "v1.6", Text = "Fixed progress bar overflow bug",            Type = "warning" },
		{ Time = "v1.5", Text = "Removed deprecated KeyValue component",      Type = "default" },
		{ Time = "v1.4", Text = "Theme engine overhaul",                      Type = "success" },
		{ Time = "v1.3", Text = "Critical crash on load fixed",               Type = "warning" },
		{ Time = "v1.2", Text = "Initial public release",                     Type = "default" },
	},
})

local STL3 = TabTL:Section({ Title = "Server Events" })
STL3:Timeline({
	Title = "Server Log",
	Entries = {
		{ Time = "just now", Text = "Player IronClad99 joined",         Type = "info"    },
		{ Time = "1m ago",   Text = "Boss spawn triggered",             Type = "warning" },
		{ Time = "3m ago",   Text = "Trade between LunaRBX & Ghost",   Type = "default" },
		{ Time = "5m ago",   Text = "Server restart completed",         Type = "success" },
		{ Time = "12m ago",  Text = "Exploit attempt detected & kicked",Type = "warning" },
		{ Time = "20m ago",  Text = "Event: Double XP started",         Type = "success" },
	},
	MaxEntries = 10,
})

-- ─────────────────────────────────────────────────────────────
--  COUNTDOWN
-- ─────────────────────────────────────────────────────────────

local TabCW = Window:Tab({ Title = "Timers", Icon = "solar:clock-bold" })

local SCW1 = TabCW:Section({ Title = "Resets" })
SCW1:Countdown({ Title = "Daily reset",     Desc = "Kills & stats",       Duration = 3600,  Color = Color3.fromHex("#0091FF"), Callback = function() print("daily reset") end })
SCW1:Countdown({ Title = "Weekly reset",    Desc = "Ranked leaderboard",  Duration = 86400, Color = Color3.fromHex("#A78BFA"), Callback = function() print("weekly reset") end })
SCW1:Countdown({ Title = "Boss respawn",    Desc = "World boss incoming", Duration = 1800,  Color = Color3.fromHex("#EF4444"), Callback = function() print("boss respawn") end })
SCW1:Countdown({ Title = "Shop refresh",    Desc = "New items available", Duration = 7200,  Color = Color3.fromHex("#EAB308"), Callback = function() print("shop refresh") end })

local SCW2 = TabCW:Section({ Title = "Events" })
SCW2:Countdown({ Title = "Exclusive event",  Desc = "Join now!",           Duration = 300,   Color = Color3.fromHex("#F97316"), Callback = function() print("event ended") end })
SCW2:Countdown({ Title = "Double XP",        Desc = "Farm while you can",  Duration = 900,   Color = Color3.fromHex("#22C55E"), Callback = function() print("double xp ended") end })
SCW2:Countdown({ Title = "PvP Tournament",   Desc = "Register now",        Duration = 600,   Color = Color3.fromHex("#EC4899"), Callback = function() print("tournament start") end })

local SCW3 = TabCW:Section({ Title = "Penalties" })
SCW3:Countdown({ Title = "Temp ban",         Duration = 86400, Color = Color3.fromHex("#EF4444"), Callback = function() print("ban lifted") end })
SCW3:Countdown({ Title = "Trade cooldown",   Desc = "Too many trades",     Duration = 600,   Color = Color3.fromHex("#F59E0B"), Callback = function() print("cooldown ended") end })

-- ─────────────────────────────────────────────────────────────
--  DASHBOARD
-- ─────────────────────────────────────────────────────────────

local TabDash = Window:Tab({ Title = "Dashboard", Icon = "solar:layers-bold" })

TabDash:ProfileCard({
	Name      = "Player",
	Role      = "Premium",
	Image     = "rbxassetid://7362423738",
	Status    = "online",
	RoleColor = Color3.fromHex("#22C55E"),
	Callback  = function() end,
})

local SDash1 = TabDash:Section({ Title = "Live Stats" })
local HpStat  = SDash1:StatCard({ Title = "Health",   Value = 100, Min = 0, Max = 100,  Color = Color3.fromHex("#22C55E"), Trend = "100%", TrendUp = true })
local XpDStat = SDash1:StatCard({ Title = "XP",       Value = 0,   Min = 0, Max = 1000, Color = Color3.fromHex("#A78BFA"), Trend = "0%",   TrendUp = true })
local GoldStat = SDash1:StatCard({ Title = "Gold",    Value = 0,   Min = 0, Max = 5000, Color = Color3.fromHex("#EAB308"), Trend = "0",    TrendUp = true })
local HpBar   = SDash1:ProgressBar({ Title = "Health", Value = 100, Suffix = " HP",     Color = Color3.fromHex("#22C55E") })
local XpBar   = SDash1:ProgressBar({ Title = "XP",     Value = 0,   Suffix = " / 1000", Color = Color3.fromHex("#A78BFA") })

local SDash2 = TabDash:Section({ Title = "Actions" })
SDash2:Card({
	Title    = "Heal (+25 HP)",
	Color    = Color3.fromHex("#22C55E"),
	Callback = function()
		local v = math.min(100, HpBar.Value + 25)
		HpBar:Set(v)
		HpStat:SetValue(v, tostring(v) .. " HP")
	end,
})
SDash2:Card({
	Title    = "Take Damage (-15 HP)",
	Color    = Color3.fromHex("#EF4444"),
	Callback = function()
		local v = math.max(0, HpBar.Value - 15)
		HpBar:Set(v)
		HpStat:SetValue(v, tostring(v) .. " HP")
	end,
})
SDash2:Card({
	Title    = "Gain 50 XP",
	Color    = Color3.fromHex("#A78BFA"),
	Callback = function()
		local v = math.min(1000, XpDStat.Value + 50)
		XpDStat:SetValue(v, tostring(v) .. " XP")
		XpBar:Set(v / 10)
	end,
})
SDash2:Card({
	Title    = "Earn 100 Gold",
	Color    = Color3.fromHex("#EAB308"),
	Callback = function()
		local v = math.min(5000, GoldStat.Value + 100)
		GoldStat:SetValue(v, "+" .. v .. " G")
	end,
})
SDash2:Card({
	Title    = "Reset Stats",
	Color    = Color3.fromHex("#EF4444"),
	Callback = function()
		HpBar:Set(100)
		HpStat:SetValue(100, "100 HP")
		XpDStat:SetValue(0, "0 XP")
		XpBar:Set(0)
		GoldStat:SetValue(0, "0 G")
	end,
})

local SDash3 = TabDash:Section({ Title = "Event Log" })
local DashFeed = SDash3:Timeline({ Title = "Events", MaxEntries = 10 })

-- ─────────────────────────────────────────────────────────────
--  ASYNC
-- ─────────────────────────────────────────────────────────────

task.spawn(function()
	task.wait(1)

	for i = 1, 10 do
		task.wait(0.25)
		DlBar:Set(i * 10)
	end
	DlBar:SetTitle("Download complete!")
	DlBar:SetDesc("v2.0 installed")
	DlBar:SetColor(Color3.fromHex("#22C55E"))

	task.wait(0.5)

	local kills = 0
	local function addKill()
		kills += 1
		KillsStat:SetValue(kills, tostring(kills) .. " kills")
		KillsStat:SetTrend("+" .. kills, true)
		Feed:Add({ Time = "now", Text = "Kill #" .. kills,                    Type = "success" })
		DashFeed:Add({ Time = "now", Text = "Kill #" .. kills .. " recorded", Type = "success" })
	end

	for _ = 1, 12 do
		task.wait(0.5)
		addKill()
	end

	task.wait(0.5)
	MyProfile:SetStatus("online")
	MyProfile:SetRole("Verified", Color3.fromHex("#22C55E"))
	DashFeed:Add({ Time = "now", Text = "Profile verified", Type = "info" })
	Feed:Add({ Time = "now", Text = "Profile verified",     Type = "info" })
end)
