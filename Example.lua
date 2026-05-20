local WindUI = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/Moon-820/WindUI-Trx/refs/heads/main/dist/main.lua"
))()

WindUI:SetTheme("Dark")

local Window = WindUI:CreateWindow({
	Title  = "Mon Hub",
	Icon   = "solar:star-bold-duotone",
	Folder = "MonHub",
})

local TabCards = Window:Tab({ Title = "Cards", Icon = "solar:widget-bold" })

local SWelcome = TabCards:Section({ Title = "Accueil" })
SWelcome:Card({
	Title    = "Bienvenue, Joueur !",
	Desc     = "Script Hub v1.0",
	Image    = "rbxassetid://7362423738",
	Color    = Color3.fromHex("#F97316"),
	Callback = function() print("profil") end,
})
SWelcome:Card({
	Title    = "12 488",
	Desc     = "Membres actifs",
	Color    = Color3.fromHex("#7C3AED"),
	Badge    = { Text = "LIVE", Color = Color3.fromHex("#EF4444") },
	Callback = function() end,
})

local SStatus = TabCards:Section({ Title = "Statut" })
SStatus:Card({
	Title    = "Premium",
	Desc     = "Accès complet",
	Color    = Color3.fromHex("#22C55E"),
	Badge    = { Text = "Actif" },
	Callback = function() end,
})
SStatus:Card({
	Title    = "Connecté : Joueur",
	Color    = Color3.fromHex("#0091FF"),
	Image    = "rbxassetid://7362423738",
	Callback = function() end,
})

local SLinks = TabCards:Section({ Title = "Liens rapides" })
SLinks:Card({ Title = "Documentation", Desc = "Guide complet sur GitHub", Callback = function() end })
SLinks:Card({ Title = "Discord",        Desc = "Rejoindre le serveur",       Callback = function() end })

local SDyn = TabCards:Section({ Title = "Card dynamique" })
local DynCard = SDyn:Card({
	Title    = "Module inactif",
	Desc     = "Cliquez pour activer",
	Color    = Color3.fromHex("#4B5563"),
	Callback = function() end,
})
DynCard.Callback = function()
	DynCard:SetTitle("Module actif")
	DynCard:SetDesc("En cours d'exécution…")
	DynCard:SetColor(Color3.fromHex("#22C55E"))
end

local TabPB = Window:Tab({ Title = "ProgressBar", Icon = "solar:chart-bold" })

local SPB1 = TabPB:Section({ Title = "Basique" })
SPB1:ProgressBar({ Title = "XP",     Desc = "Level 42", Value = 75, Color = Color3.fromHex("#0091FF") })
SPB1:ProgressBar({ Title = "Santé",  Value = 82, Suffix = " HP",    Color = Color3.fromHex("#22C55E") })
SPB1:ProgressBar({ Title = "Mana",   Value = 55, Suffix = " / 100", Color = Color3.fromHex("#8B5CF6") })

local SPB2 = TabPB:Section({ Title = "Avec Callback" })
local DlBar = SPB2:ProgressBar({
	Title    = "Téléchargement",
	Desc     = "En attente…",
	Value    = 0,
	Color    = Color3.fromHex("#F97316"),
	Callback = function(v) if v >= 100 then print("done") end end,
})

local TabStat = Window:Tab({ Title = "StatCard", Icon = "solar:graph-bold" })

local SStat1 = TabStat:Section({ Title = "Métriques" })
local KillsStat = SStat1:StatCard({
	Title  = "Kills",
	Value  = 0,
	Min    = 0,
	Max    = 50,
	Color  = Color3.fromHex("#EF4444"),
	Trend  = "0%",
	TrendUp = true,
})
local XpStat = SStat1:StatCard({
	Title  = "XP total",
	Value  = 1240,
	Min    = 0,
	Max    = 5000,
	Color  = Color3.fromHex("#A78BFA"),
	Trend  = "+320",
	TrendUp = true,
})
SStat1:StatCard({
	Title   = "K/D Ratio",
	Value   = "—",
	ShowBar = false,
	Color   = Color3.fromHex("#0091FF"),
	Callback = function() print("kd clicked") end,
})

local SStat2 = TabStat:Section({ Title = "Serveur" })
SStat2:StatCard({ Title = "Ping",     Value = 42,   Min = 0, Max = 500,  Color = Color3.fromHex("#22C55E"), Trend = "-8ms",  TrendUp = true  })
SStat2:StatCard({ Title = "FPS",      Value = 60,   Min = 0, Max = 60,   Color = Color3.fromHex("#0091FF"), Trend = "+2",    TrendUp = true  })
SStat2:StatCard({ Title = "Joueurs",  Value = 18,   Min = 0, Max = 24,   Color = Color3.fromHex("#F97316"), Trend = "+3",    TrendUp = true  })

local TabProfile = Window:Tab({ Title = "ProfileCard", Icon = "solar:user-bold" })

local SP1 = TabProfile:Section({ Title = "Joueurs" })
SP1:ProfileCard({
	Name      = "Ethanoj1",
	Role      = "Admin",
	Image     = "rbxassetid://7362423738",
	Status    = "online",
	RoleColor = Color3.fromHex("#EF4444"),
	Callback  = function() print("admin clicked") end,
})
SP1:ProfileCard({
	Name      = "QuantumDev",
	Role      = "Premium",
	Status    = "away",
	RoleColor = Color3.fromHex("#F97316"),
	Callback  = function() end,
})
SP1:ProfileCard({
	Name      = "GhostScript",
	Role      = "Member",
	Status    = "offline",
	RoleColor = Color3.fromHex("#6B7280"),
	Callback  = function() end,
})
SP1:ProfileCard({
	Name      = "LunaRBX",
	Role      = "Developer",
	Status    = "busy",
	RoleColor = Color3.fromHex("#8B5CF6"),
	Callback  = function() end,
})

local SP2 = TabProfile:Section({ Title = "ProfileCard dynamique" })
local MyProfile = SP2:ProfileCard({
	Name      = "Moi",
	Role      = "Invité",
	Status    = "offline",
	RoleColor = Color3.fromHex("#6B7280"),
	Callback  = function() end,
})

local TabTL = Window:Tab({ Title = "Timeline", Icon = "solar:history-bold" })

local STL1 = TabTL:Section({ Title = "Activité récente" })
local Feed = STL1:Timeline({
	Title = "Fil d'activité",
	Entries = {
		{ Time = "maintenant", Text = "Script chargé avec succès",        Type = "success" },
		{ Time = "1s ago",     Text = "Connexion au serveur établie",      Type = "info"    },
		{ Time = "3s ago",     Text = "Anti-AFK activé",                   Type = "info"    },
		{ Time = "10s ago",    Text = "Tentative de reconnexion",          Type = "warning" },
		{ Time = "1m ago",     Text = "Session précédente terminée",       Type = "default" },
	},
	MaxEntries = 10,
})

local STL2 = TabTL:Section({ Title = "Changelog v1.0" })
STL2:Timeline({
	Title = "Nouveautés",
	Entries = {
		{ Time = "v1.0", Text = "Ajout de StatCard, ProfileCard, Timeline", Type = "success" },
		{ Time = "v0.9", Text = "Ajout de ProgressBar et Card",             Type = "info"    },
		{ Time = "v0.8", Text = "Correction du bug de débordement de barre",Type = "warning" },
		{ Time = "v0.7", Text = "Suppression de Notification et KeyValue",  Type = "default" },
	},
})

local TabCW = Window:Tab({ Title = "Countdown", Icon = "solar:clock-bold" })
local SCW = TabCW:Section({ Title = "Timers" })
SCW:Countdown({ Title = "Prochain reset", Desc = "Kills & stats", Duration = 3600, Color = Color3.fromHex("#0091FF"), Callback = function() print("reset") end })
SCW:Countdown({ Title = "Event exclusif", Desc = "Rejoins vite !", Duration = 300,  Color = Color3.fromHex("#F97316"), Callback = function() print("event fini") end })
SCW:Countdown({ Title = "Ban temporaire", Duration = 86400, Color = Color3.fromHex("#EF4444"), Callback = function() print("ban levé") end })

local TabDash = Window:Tab({ Title = "Dashboard", Icon = "solar:layers-bold" })

TabDash:ProfileCard({
	Name      = "Joueur",
	Role      = "Premium",
	Image     = "rbxassetid://7362423738",
	Status    = "online",
	RoleColor = Color3.fromHex("#22C55E"),
	Callback  = function() end,
})

local SDash1 = TabDash:Section({ Title = "Stats" })
local HpStat  = SDash1:StatCard({ Title = "Santé", Value = 100, Min = 0, Max = 100, Color = Color3.fromHex("#22C55E"), Trend = "100%", TrendUp = true })
local XpDStat = SDash1:StatCard({ Title = "XP",    Value = 0,   Min = 0, Max = 1000, Color = Color3.fromHex("#A78BFA"), Trend = "0%",   TrendUp = true })
local HpBar   = SDash1:ProgressBar({ Title = "Santé", Value = 100, Suffix = " HP", Color = Color3.fromHex("#22C55E") })

local SDash2 = TabDash:Section({ Title = "Actions" })
SDash2:Card({
	Title    = "Soigner (+25 HP)",
	Color    = Color3.fromHex("#22C55E"),
	Callback = function()
		local v = math.min(100, HpBar.Value + 25)
		HpBar:Set(v)
		HpStat:SetValue(v, tostring(v) .. " HP")
	end,
})
SDash2:Card({
	Title    = "Gagner 50 XP",
	Color    = Color3.fromHex("#A78BFA"),
	Callback = function()
		local v = math.min(1000, XpDStat.Value + 50)
		XpDStat:SetValue(v, tostring(v) .. " XP")
	end,
})

local SDash3 = TabDash:Section({ Title = "Journal" })
local DashFeed = SDash3:Timeline({ Title = "Événements", MaxEntries = 6 })

task.spawn(function()
	task.wait(1)
	for i = 1, 10 do
		task.wait(0.25)
		DlBar:Set(i * 10)
	end
	DlBar:SetTitle("Téléchargement terminé !")
	DlBar:SetDesc("v1.0 installée")
	DlBar:SetColor(Color3.fromHex("#22C55E"))

	task.wait(0.5)
	local kills = 0
	local function addKill()
		kills += 1
		KillsStat:SetValue(kills, tostring(kills) .. " kills")
		KillsStat:SetTrend("+" .. kills, true)
		Feed:Add({ Time = "now", Text = "Kill #" .. kills, Type = "success" })
		DashFeed:Add({ Time = "now", Text = "Kill #" .. kills .. " enregistré", Type = "success" })
	end
	for _ = 1, 8 do
		task.wait(0.6)
		addKill()
	end

	task.wait(0.5)
	MyProfile:SetStatus("online")
	MyProfile:SetRole("Vérifié", Color3.fromHex("#22C55E"))
	DashFeed:Add({ Time = "now", Text = "Profil vérifié", Type = "info" })
end)
