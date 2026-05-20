local Creator = require("../modules/Creator")
local New = Creator.New
local NewRoundFrame = Creator.NewRoundFrame
local Tween = Creator.Tween

local Element = {}

function Element:New(Config)
	local StatCard = {
		__type    = "StatCard",
		Title     = Config.Title or "Stat",
		Value     = Config.Value or "0",
		Desc      = Config.Desc or nil,
		Trend     = Config.Trend or nil,
		TrendUp   = Config.TrendUp ~= false,
		Color     = Config.Color or Color3.fromHex("#0091FF"),
		Min       = Config.Min or 0,
		Max       = Config.Max or 100,
		ShowBar   = Config.ShowBar ~= false,
		Callback  = Config.Callback or function() end,
		UIElements = {},
	}

	local UIPadding = Config.Window.ElementConfig.UIPadding
	local UICorner  = Config.Window.ElementConfig.UICorner

	local ValueLabel = New("TextLabel", {
		BackgroundTransparency = 1,
		Text = tostring(StatCard.Value),
		TextSize = 28,
		TextXAlignment = "Left",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		FontFace = Font.new(Creator.Font, Enum.FontWeight.Bold),
		TextColor3 = StatCard.Color,
	})

	local TitleLabel = New("TextLabel", {
		BackgroundTransparency = 1,
		Text = StatCard.Title,
		TextSize = 13,
		TextXAlignment = "Left",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
		ThemeTag = { TextColor3 = "ElementTitle" },
		TextTransparency = 0.3,
	})

	local TrendLabel = nil
	if StatCard.Trend then
		local tcolor = StatCard.TrendUp and Color3.fromHex("#22C55E") or Color3.fromHex("#EF4444")
		TrendLabel = New("TextLabel", {
			BackgroundTransparency = 1,
			Text = (StatCard.TrendUp and "↑ " or "↓ ") .. tostring(StatCard.Trend),
			TextSize = 12,
			TextXAlignment = "Right",
			Size = UDim2.new(0, 0, 0, 0),
			AutomaticSize = "XY",
			FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
			TextColor3 = tcolor,
		})
	end

	local BarBackground = nil
	local BarFill = nil
	if StatCard.ShowBar then
		local ratio = math.clamp(
			(tonumber(tostring(StatCard.Value)) or 0) - StatCard.Min,
			0, StatCard.Max - StatCard.Min
		) / math.max(1, StatCard.Max - StatCard.Min)

		BarBackground = New("Frame", {
			Size = UDim2.new(1, 0, 0, 5),
			ClipsDescendants = true,
			BackgroundTransparency = 0.88,
			ThemeTag = { BackgroundColor3 = "ElementTitle" },
		}, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) })

		BarFill = New("Frame", {
			Size = UDim2.new(ratio, 0, 1, 0),
			BackgroundColor3 = StatCard.Color,
			Parent = BarBackground,
		}, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) })
	end

	local TopRow = New("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		BackgroundTransparency = 1,
	}, {
		New("UIListLayout", {
			FillDirection = "Horizontal",
			VerticalAlignment = "Center",
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
		}),
		ValueLabel,
		TrendLabel,
	})

	local Inner = New("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		BackgroundTransparency = 1,
	}, {
		New("UIListLayout", { Padding = UDim.new(0, 4), FillDirection = "Vertical", SortOrder = "LayoutOrder" }),
		TopRow,
		TitleLabel,
		BarBackground,
	})

	local StatCardFrame = NewRoundFrame(UICorner, "Squircle", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		Parent = Config.Parent,
		ThemeTag = {
			ImageColor3 = "ElementBackground",
			ImageTransparency = "ElementBackgroundTransparency",
		},
	}, {
		Inner,
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
		Parent = StatCardFrame,
	})
	Btn.MouseButton1Click:Connect(function() StatCard.Callback() end)

	StatCard.StatCardFrame = {
		UIElements = { Main = StatCardFrame },
		Index = Config.Index,
		UpdateShape = function() end,
		SetTitle = function(_, t) StatCard.Title = t TitleLabel.Text = t end,
		SetDesc = function() end,
		Highlight = function() end,
		Destroy = function() StatCardFrame:Destroy() end,
	}

	function StatCard:SetValue(v, raw)
		StatCard.Value = v
		ValueLabel.Text = raw or tostring(v)
		if BarFill then
			local ratio = math.clamp(
				(tonumber(tostring(v)) or 0) - StatCard.Min,
				0, StatCard.Max - StatCard.Min
			) / math.max(1, StatCard.Max - StatCard.Min)
			Tween(BarFill, 0.3, { Size = UDim2.new(ratio, 0, 1, 0) }, Enum.EasingStyle.Quint):Play()
		end
		StatCard.Callback(v)
	end

	function StatCard:SetTrend(t, up)
		StatCard.Trend = t
		StatCard.TrendUp = up ~= false
		if TrendLabel then
			TrendLabel.TextColor3 = StatCard.TrendUp and Color3.fromHex("#22C55E") or Color3.fromHex("#EF4444")
			TrendLabel.Text = (StatCard.TrendUp and "↑ " or "↓ ") .. tostring(t)
		end
	end

	function StatCard:SetColor(c)
		StatCard.Color = c
		ValueLabel.TextColor3 = c
		if BarFill then BarFill.BackgroundColor3 = c end
	end

	function StatCard:Destroy()
		StatCardFrame:Destroy()
	end

	return StatCard.__type, StatCard
end

return Element
