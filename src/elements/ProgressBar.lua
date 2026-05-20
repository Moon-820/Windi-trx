local Creator = require("../modules/Creator")
local New = Creator.New
local NewRoundFrame = Creator.NewRoundFrame
local Tween = Creator.Tween

local Element = {}

function Element:New(Config)
	local ProgressBar = {
		__type = "ProgressBar",
		Title = Config.Title or "ProgressBar",
		Desc = Config.Desc or nil,
		Value = math.clamp(Config.Value or 0, 0, 100),
		Suffix = Config.Suffix or "%",
		Color = Config.Color or Color3.fromHex("#0091FF"),
		Locked = Config.Locked or false,
		Callback = Config.Callback or function() end,
		UIElements = {},
	}

	local UIPadding = Config.Window.ElementConfig.UIPadding
	local UICorner = Config.Window.ElementConfig.UICorner

	local TitleLabel = New("TextLabel", {
		BackgroundTransparency = 1,
		Text = ProgressBar.Title,
		TextSize = 17,
		TextXAlignment = "Left",
		TextWrapped = true,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
		ThemeTag = { TextColor3 = "ElementTitle" },
	})

	local DescLabel = New("TextLabel", {
		BackgroundTransparency = 1,
		Text = ProgressBar.Desc or "",
		TextSize = 15,
		TextXAlignment = "Left",
		TextTransparency = 0.3,
		TextWrapped = true,
		Visible = ProgressBar.Desc ~= nil and ProgressBar.Desc ~= "",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
		ThemeTag = { TextColor3 = "ElementDesc" },
	})

	local BarBackground = NewRoundFrame(99, "Squircle", {
		Size = UDim2.new(1, 0, 0, 8),
		ClipsDescendants = true,
		ThemeTag = {
			ImageColor3 = "ElementBackground",
			ImageTransparency = "ElementBackgroundTransparency",
		},
		ImageTransparency = 0.5,
	})

	local BarFill = NewRoundFrame(99, "Squircle", {
		Size = UDim2.new(ProgressBar.Value / 100, 0, 1, 0),
		ImageColor3 = ProgressBar.Color,
		Parent = BarBackground,
	})

	local ValueLabel = New("TextLabel", {
		BackgroundTransparency = 1,
		Text = tostring(math.floor(ProgressBar.Value)) .. ProgressBar.Suffix,
		TextSize = 13,
		TextXAlignment = "Right",
		Size = UDim2.new(1, 0, 0, 14),
		FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
		ThemeTag = { TextColor3 = "ElementDesc" },
		TextTransparency = 0.3,
	})

	local ContentFrame = New("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		BackgroundTransparency = 1,
	}, {
		New("UIListLayout", {
			Padding = UDim.new(0, 8),
			FillDirection = "Vertical",
			SortOrder = "LayoutOrder",
		}),
		New("Frame", {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = "Y",
			BackgroundTransparency = 1,
			LayoutOrder = 0,
		}, {
			New("UIListLayout", { Padding = UDim.new(0, 4), FillDirection = "Vertical" }),
			TitleLabel,
			DescLabel,
		}),
		New("Frame", {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = "Y",
			BackgroundTransparency = 1,
			LayoutOrder = 1,
		}, {
			New("UIListLayout", { Padding = UDim.new(0, 4), FillDirection = "Vertical" }),
			ValueLabel,
			BarBackground,
		}),
	})

	local ProgressBarFrame = NewRoundFrame(UICorner, "Squircle", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		Parent = Config.Parent,
		ThemeTag = {
			ImageColor3 = "ElementBackground",
			ImageTransparency = "ElementBackgroundTransparency",
		},
	}, {
		ContentFrame,
		New("UIPadding", {
			PaddingTop = UDim.new(0, UIPadding),
			PaddingLeft = UDim.new(0, UIPadding),
			PaddingRight = UDim.new(0, UIPadding),
			PaddingBottom = UDim.new(0, UIPadding),
		}),
	})

	ProgressBar.ProgressBarFrame = {
		UIElements = { Main = ProgressBarFrame },
		Index = Config.Index,
		UpdateShape = function() end,
		SetTitle = function(_, text)
			ProgressBar.Title = text
			TitleLabel.Text = text
		end,
		SetDesc = function(_, text)
			ProgressBar.Desc = text
			DescLabel.Text = text or ""
			DescLabel.Visible = text ~= nil and text ~= ""
		end,
		Highlight = function() end,
		Destroy = function()
			ProgressBarFrame:Destroy()
		end,
	}

	function ProgressBar:Set(value)
		value = math.clamp(value, 0, 100)
		ProgressBar.Value = value
		Tween(BarFill, 0.3, {
			Size = UDim2.new(value / 100, 0, 1, 0),
		}, Enum.EasingStyle.Quint):Play()
		ValueLabel.Text = tostring(math.floor(value)) .. ProgressBar.Suffix
		ProgressBar.Callback(value)
	end

	function ProgressBar:SetColor(color)
		ProgressBar.Color = color
		BarFill.ImageColor3 = color
	end

	function ProgressBar:Lock()
		ProgressBar.Locked = true
	end

	function ProgressBar:Unlock()
		ProgressBar.Locked = false
	end

	function ProgressBar:Destroy()
		ProgressBarFrame:Destroy()
	end

	return ProgressBar.__type, ProgressBar
end

return Element
