local Creator = require("../modules/Creator")
local New = Creator.New
local NewRoundFrame = Creator.NewRoundFrame

local Element = {}

local function fmt(secs)
	secs = math.max(0, math.floor(secs))
	local d = math.floor(secs / 86400)
	local h = math.floor((secs % 86400) / 3600)
	local m = math.floor((secs % 3600) / 60)
	local s = secs % 60
	if d > 0 then
		return string.format("%dd %02d:%02d:%02d", d, h, m, s)
	end
	return string.format("%02d:%02d:%02d", h, m, s)
end

function Element:New(Config)
	local duration = Config.Duration or 0
	local endsAt   = Config.EndsAt or (os.time() + duration)

	local Countdown = {
		__type    = "Countdown",
		Title     = Config.Title or "Countdown",
		Desc      = Config.Desc or nil,
		Color     = Config.Color or Color3.fromHex("#0091FF"),
		Callback  = Config.Callback or function() end,
		Active    = true,
		UIElements = {},
	}

	local UIPadding = Config.Window.ElementConfig.UIPadding
	local UICorner  = Config.Window.ElementConfig.UICorner

	local TitleLabel = New("TextLabel", {
		BackgroundTransparency = 1,
		Text = Countdown.Title,
		TextSize = 16,
		TextXAlignment = "Left",
		TextWrapped = true,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
		ThemeTag = { TextColor3 = "ElementTitle" },
		LayoutOrder = 0,
	})

	local DescLabel = nil
	if Countdown.Desc then
		DescLabel = New("TextLabel", {
			BackgroundTransparency = 1,
			Text = Countdown.Desc,
			TextSize = 13,
			TextXAlignment = "Left",
			TextTransparency = 0.4,
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = "Y",
			FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
			ThemeTag = { TextColor3 = "ElementDesc" },
			LayoutOrder = 1,
		})
	end

	local TimerLabel = New("TextLabel", {
		BackgroundTransparency = 1,
		Text = fmt(math.max(0, endsAt - os.time())),
		TextSize = 26,
		TextXAlignment = "Left",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		FontFace = Font.new(Creator.Font, Enum.FontWeight.Bold),
		TextColor3 = Countdown.Color,
		LayoutOrder = 1,
	})

	local ContentFrame = New("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		BackgroundTransparency = 1,
	}, {
		New("UIListLayout", { Padding = UDim.new(0, 6), FillDirection = "Vertical", SortOrder = "LayoutOrder" }),
		New("Frame", {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = "Y",
			BackgroundTransparency = 1,
			LayoutOrder = 0,
		}, {
			New("UIListLayout", { Padding = UDim.new(0, 2), FillDirection = "Vertical" }),
			TitleLabel,
			DescLabel,
		}),
		TimerLabel,
	})

	local CountdownFrame = NewRoundFrame(UICorner, "Squircle", {
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
			PaddingTop    = UDim.new(0, UIPadding),
			PaddingLeft   = UDim.new(0, UIPadding),
			PaddingRight  = UDim.new(0, UIPadding),
			PaddingBottom = UDim.new(0, UIPadding),
		}),
	})

	local conn
	conn = game:GetService("RunService").Heartbeat:Connect(function()
		if not Countdown.Active then
			conn:Disconnect()
			return
		end
		local rem = endsAt - os.time()
		TimerLabel.Text = fmt(rem)
		if rem <= 0 then
			Countdown.Active = false
			conn:Disconnect()
			Countdown.Callback()
		end
	end)

	Countdown.CountdownFrame = {
		UIElements = { Main = CountdownFrame },
		Index = Config.Index,
		UpdateShape = function() end,
		SetTitle = function(_, text)
			Countdown.Title = text
			TitleLabel.Text = text
		end,
		SetDesc = function(_, text)
			Countdown.Desc = text
			if DescLabel then DescLabel.Text = text or "" end
		end,
		Highlight = function() end,
		Destroy = function()
			Countdown.Active = false
			CountdownFrame:Destroy()
		end,
	}

	function Countdown:SetColor(color)
		Countdown.Color = color
		TimerLabel.TextColor3 = color
	end

	function Countdown:Reset(secs)
		endsAt = os.time() + (secs or duration)
		Countdown.Active = true
		if not conn.Connected then
			conn = game:GetService("RunService").Heartbeat:Connect(function()
				if not Countdown.Active then conn:Disconnect() return end
				local rem = endsAt - os.time()
				TimerLabel.Text = fmt(rem)
				if rem <= 0 then
					Countdown.Active = false
					conn:Disconnect()
					Countdown.Callback()
				end
			end)
		end
	end

	function Countdown:Destroy()
		Countdown.Active = false
		CountdownFrame:Destroy()
	end

	return Countdown.__type, Countdown
end

return Element
