local Creator = require("../modules/Creator")
local New = Creator.New
local NewRoundFrame = Creator.NewRoundFrame

local Element = {}

local E_COLORS = {
	success = Color3.fromHex("#22C55E"),
	warning = Color3.fromHex("#F97316"),
	error   = Color3.fromHex("#EF4444"),
	info    = Color3.fromHex("#0091FF"),
	default = Color3.fromHex("#6B7280"),
}

function Element:New(Config)
	local Timeline = {
		__type     = "Timeline",
		Title      = Config.Title or "Timeline",
		Entries    = Config.Entries or {},
		MaxEntries = Config.MaxEntries or 8,
		UIElements = {},
	}

	local UIPadding = Config.Window.ElementConfig.UIPadding
	local UICorner  = Config.Window.ElementConfig.UICorner

	local TitleLabel = New("TextLabel", {
		BackgroundTransparency = 1,
		Text = Timeline.Title,
		TextSize = 15,
		TextXAlignment = "Left",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
		ThemeTag = { TextColor3 = "ElementTitle" },
	})

	local ListFrame = New("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		BackgroundTransparency = 1,
	}, {
		New("UIListLayout", {
			Padding = UDim.new(0, 6),
			FillDirection = "Vertical",
			SortOrder = "LayoutOrder",
		}),
	})

	local entryFrames = {}

	local function makeEntry(e, idx)
		local ec = E_COLORS[e.Type or "default"] or E_COLORS.default

		local Dot = New("Frame", {
			Size = UDim2.new(0, 8, 0, 8),
			BackgroundColor3 = ec,
			BorderSizePixel = 0,
		}, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) })

		local Txt = New("TextLabel", {
			BackgroundTransparency = 1,
			Text = e.Text or "",
			TextSize = 13,
			TextXAlignment = "Left",
			TextWrapped = true,
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = "Y",
			FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
			ThemeTag = { TextColor3 = "ElementTitle" },
		})

		local Ts = New("TextLabel", {
			BackgroundTransparency = 1,
			Text = e.Time or "",
			TextSize = 11,
			TextXAlignment = "Right",
			TextTransparency = 0.5,
			Size = UDim2.new(0, 0, 0, 0),
			AutomaticSize = "XY",
			FontFace = Font.new(Creator.Font, Enum.FontWeight.Regular),
			ThemeTag = { TextColor3 = "ElementDesc" },
		})

		local Row = New("Frame", {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = "Y",
			BackgroundTransparency = 1,
			LayoutOrder = idx,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 8),
				FillDirection = "Horizontal",
				VerticalAlignment = "Center",
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
			}),
			Dot, Txt, Ts,
		})

		Row.Parent = ListFrame
		table.insert(entryFrames, Row)
		return Row
	end

	for idx, e in ipairs(Timeline.Entries) do
		makeEntry(e, idx)
	end

	local Inner = New("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		BackgroundTransparency = 1,
	}, {
		New("UIListLayout", {
			Padding = UDim.new(0, 8),
			FillDirection = "Vertical",
			SortOrder = "LayoutOrder",
		}),
		TitleLabel,
		ListFrame,
	})

	local TimelineFrame = NewRoundFrame(UICorner, "Squircle", {
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

	Timeline.TimelineFrame = {
		UIElements = { Main = TimelineFrame },
		Index = Config.Index,
		UpdateShape = function() end,
		SetTitle = function(_, t) Timeline.Title = t TitleLabel.Text = t end,
		SetDesc = function() end,
		Highlight = function() end,
		Destroy = function() TimelineFrame:Destroy() end,
	}

	function Timeline:Add(e)
		if #entryFrames >= Timeline.MaxEntries then
			entryFrames[1]:Destroy()
			table.remove(entryFrames, 1)
		end
		table.insert(Timeline.Entries, e)
		makeEntry(e, #entryFrames + 1)
	end

	function Timeline:Clear()
		for _, f in ipairs(entryFrames) do f:Destroy() end
		entryFrames = {}
		Timeline.Entries = {}
	end

	function Timeline:Destroy()
		TimelineFrame:Destroy()
	end

	return Timeline.__type, Timeline
end

return Element
