local Creator = require("../modules/Creator")
local New = Creator.New
local NewRoundFrame = Creator.NewRoundFrame

local Element = {}

local STATUS_COLORS = {
	online  = Color3.fromHex("#22C55E"),
	offline = Color3.fromHex("#6B7280"),
	away    = Color3.fromHex("#F97316"),
	busy    = Color3.fromHex("#EF4444"),
}

function Element:New(Config)
	local ProfileCard = {
		__type    = "ProfileCard",
		Name      = Config.Name or "Player",
		Role      = Config.Role or nil,
		Image     = Config.Image or nil,
		Status    = Config.Status or "online",
		RoleColor = Config.RoleColor or Color3.fromHex("#0091FF"),
		Callback  = Config.Callback or function() end,
		UIElements = {},
	}

	local UIPadding = Config.Window.ElementConfig.UIPadding
	local UICorner  = Config.Window.ElementConfig.UICorner

	local Avatar
	if ProfileCard.Image then
		Avatar = New("ImageLabel", {
			Size = UDim2.new(0, 42, 0, 42),
			Image = ProfileCard.Image,
			BackgroundColor3 = Color3.fromHex("#1e293b"),
			BackgroundTransparency = 0,
			ScaleType = Enum.ScaleType.Crop,
		}, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) })
	else
		Avatar = New("Frame", {
			Size = UDim2.new(0, 42, 0, 42),
			BackgroundColor3 = ProfileCard.RoleColor,
			BackgroundTransparency = 0.7,
		}, {
			New("UICorner", { CornerRadius = UDim.new(1, 0) }),
			New("TextLabel", {
				BackgroundTransparency = 1,
				Text = string.upper(string.sub(ProfileCard.Name, 1, 1)),
				TextSize = 20,
				TextColor3 = Color3.new(1, 1, 1),
				Size = UDim2.new(1, 0, 1, 0),
				FontFace = Font.new(Creator.Font, Enum.FontWeight.Bold),
			}),
		})
	end

	local StatusDot = New("Frame", {
		Size = UDim2.new(0, 10, 0, 10),
		BackgroundColor3 = STATUS_COLORS[ProfileCard.Status] or STATUS_COLORS.online,
		BorderSizePixel = 0,
	}, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) })

	local NameLabel = New("TextLabel", {
		BackgroundTransparency = 1,
		Text = ProfileCard.Name,
		TextSize = 16,
		TextXAlignment = "Left",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		FontFace = Font.new(Creator.Font, Enum.FontWeight.Bold),
		ThemeTag = { TextColor3 = "ElementTitle" },
	})

	local RoleBadge = nil
	if ProfileCard.Role then
		RoleBadge = New("Frame", {
			Size = UDim2.new(0, 0, 0, 20),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundColor3 = ProfileCard.RoleColor,
			BackgroundTransparency = 0.15,
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 5) }),
			New("UIPadding", {
				PaddingLeft   = UDim.new(0, 7),
				PaddingRight  = UDim.new(0, 7),
				PaddingTop    = UDim.new(0, 1),
				PaddingBottom = UDim.new(0, 1),
			}),
			New("TextLabel", {
				BackgroundTransparency = 1,
				Text = ProfileCard.Role,
				TextSize = 12,
				TextColor3 = Color3.new(1, 1, 1),
				Size = UDim2.new(0, 0, 1, 0),
				AutomaticSize = Enum.AutomaticSize.X,
				FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
			}),
		})
	end

	local StatusRow = New("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		BackgroundTransparency = 1,
	}, {
		New("UIListLayout", {
			Padding = UDim.new(0, 6),
			FillDirection = "Horizontal",
			VerticalAlignment = "Center",
		}),
		StatusDot,
		RoleBadge,
	})

	local TextStack = New("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		BackgroundTransparency = 1,
	}, {
		New("UIListLayout", { Padding = UDim.new(0, 4), FillDirection = "Vertical" }),
		NameLabel,
		StatusRow,
	})

	local Row = New("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		BackgroundTransparency = 1,
	}, {
		New("UIListLayout", {
			Padding = UDim.new(0, 12),
			FillDirection = "Horizontal",
			VerticalAlignment = "Center",
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
		}),
		Avatar,
		TextStack,
	})

	local ProfileCardFrame = NewRoundFrame(UICorner, "Squircle", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		Parent = Config.Parent,
		ThemeTag = {
			ImageColor3 = "ElementBackground",
			ImageTransparency = "ElementBackgroundTransparency",
		},
	}, {
		Row,
		New("UIPadding", {
			PaddingTop    = UDim.new(0, UIPadding),
			PaddingLeft   = UDim.new(0, UIPadding),
			PaddingRight  = UDim.new(0, UIPadding),
			PaddingBottom = UDim.new(0, UIPadding),
		}),
	})

	local Btn = New("ImageButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		ZIndex = 10,
		Parent = ProfileCardFrame,
	})
	Btn.MouseButton1Click:Connect(function() ProfileCard.Callback() end)

	ProfileCard.ProfileCardFrame = {
		UIElements = { Main = ProfileCardFrame },
		Index = Config.Index,
		UpdateShape = function() end,
		SetTitle = function(_, t) ProfileCard.Name = t NameLabel.Text = t end,
		SetDesc = function() end,
		Highlight = function() end,
		Destroy = function() ProfileCardFrame:Destroy() end,
	}

	function ProfileCard:SetStatus(s)
		ProfileCard.Status = s
		StatusDot.BackgroundColor3 = STATUS_COLORS[s] or STATUS_COLORS.online
	end

	function ProfileCard:SetRole(r, c)
		ProfileCard.Role = r
		if RoleBadge then
			local lbl = RoleBadge:FindFirstChildWhichIsA("TextLabel")
			if lbl then lbl.Text = r end
			if c then RoleBadge.BackgroundColor3 = c end
		end
	end

	function ProfileCard:Destroy()
		ProfileCardFrame:Destroy()
	end

	return ProfileCard.__type, ProfileCard
end

return Element
