local Creator = require("../modules/Creator")
local New = Creator.New
local NewRoundFrame = Creator.NewRoundFrame

local Element = {}

function Element:New(Config)
	local Card = {
		__type = "Card",
		Title = Config.Title or "Card",
		Desc = Config.Desc or nil,
		Color = Config.Color or nil,
		Image = Config.Image or nil,
		Badge = Config.Badge or nil,
		Callback = Config.Callback or function() end,
		UIElements = {},
	}

	local UIPadding = Config.Window.ElementConfig.UIPadding
	local UICorner = Config.Window.ElementConfig.UICorner

	local TitleLabel = New("TextLabel", {
		BackgroundTransparency = 1,
		Text = Card.Title,
		TextSize = 16,
		TextXAlignment = "Left",
		TextWrapped = true,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		FontFace = Font.new(Creator.Font, Enum.FontWeight.Bold),
		TextColor3 = Card.Color and Color3.new(1, 1, 1) or nil,
		ThemeTag = not Card.Color and { TextColor3 = "ElementTitle" } or nil,
		LayoutOrder = 0,
	})

	local DescLabel = nil
	if Card.Desc ~= nil and Card.Desc ~= "" then
		DescLabel = New("TextLabel", {
			BackgroundTransparency = 1,
			Text = Card.Desc,
			TextSize = 13,
			TextXAlignment = "Left",
			TextTransparency = 0.35,
			TextWrapped = true,
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = "Y",
			FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
			TextColor3 = Card.Color and Color3.new(1, 1, 1) or nil,
			ThemeTag = not Card.Color and { TextColor3 = "ElementDesc" } or nil,
			LayoutOrder = 1,
		})
	end

	local TextContent = New("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		BackgroundTransparency = 1,
		LayoutOrder = 2,
	}, {
		New("UIListLayout", { Padding = UDim.new(0, 3), FillDirection = "Vertical", SortOrder = "LayoutOrder" }),
		TitleLabel,
		DescLabel,
	})

	local AvatarFrame = nil
	if Card.Image then
		AvatarFrame = New("ImageLabel", {
			Size = UDim2.new(0, 36, 0, 36),
			BackgroundTransparency = 0.85,
			BackgroundColor3 = Color3.new(1, 1, 1),
			Image = Card.Image,
			ScaleType = Enum.ScaleType.Crop,
			LayoutOrder = 1,
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 8) }),
		})
	end

	local BadgeFrame = nil
	if Card.Badge then
		local badgeColor = Card.Badge.Color or Color3.fromHex("#ffffff")
		BadgeFrame = New("Frame", {
			Size = UDim2.new(0, 0, 0, 26),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundColor3 = badgeColor,
			BackgroundTransparency = Card.Color and 0.25 or 0,
			LayoutOrder = 3,
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 6) }),
			New("UIPadding", {
				PaddingLeft = UDim.new(0, 8),
				PaddingRight = UDim.new(0, 8),
				PaddingTop = UDim.new(0, 2),
				PaddingBottom = UDim.new(0, 2),
			}),
			New("TextLabel", {
				BackgroundTransparency = 1,
				Text = tostring(Card.Badge.Text or ""),
				TextSize = 13,
				TextColor3 = Color3.new(1, 1, 1),
				Size = UDim2.new(0, 0, 1, 0),
				AutomaticSize = Enum.AutomaticSize.X,
				FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
			}),
		})
	end

	local RowFrame = New("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
	}, {
		New("UIListLayout", {
			Padding = UDim.new(0, 10),
			FillDirection = "Horizontal",
			VerticalAlignment = "Center",
			SortOrder = "LayoutOrder",
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
		}),
		AvatarFrame,
		TextContent,
		BadgeFrame,
	})

	local CardFrame
	if Card.Color then
		CardFrame = New("Frame", {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Card.Color,
			Parent = Config.Parent,
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, UICorner) }),
			RowFrame,
			New("UIPadding", {
				PaddingTop = UDim.new(0, UIPadding),
				PaddingLeft = UDim.new(0, UIPadding),
				PaddingRight = UDim.new(0, UIPadding),
				PaddingBottom = UDim.new(0, UIPadding),
			}),
		})
	else
		CardFrame = NewRoundFrame(UICorner, "Squircle", {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Parent = Config.Parent,
			ThemeTag = {
				ImageColor3 = "ElementBackground",
				ImageTransparency = "ElementBackgroundTransparency",
			},
		}, {
			RowFrame,
			New("UIPadding", {
				PaddingTop = UDim.new(0, UIPadding),
				PaddingLeft = UDim.new(0, UIPadding),
				PaddingRight = UDim.new(0, UIPadding),
				PaddingBottom = UDim.new(0, UIPadding),
			}),
		})
	end

	local ClickButton = New("ImageButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		ZIndex = 10,
		Parent = CardFrame,
	})
	ClickButton.MouseButton1Click:Connect(function()
		Card.Callback()
	end)

	Card.CardFrame = {
		UIElements = { Main = CardFrame },
		Index = Config.Index,
		UpdateShape = function() end,
		SetTitle = function(_, text)
			Card.Title = text
			TitleLabel.Text = text
		end,
		SetDesc = function(_, text)
			Card.Desc = text
			if DescLabel then
				DescLabel.Text = text or ""
				DescLabel.Visible = text ~= nil and text ~= ""
			end
		end,
		SetBadge = function(_, text)
			if BadgeFrame then
				local lbl = BadgeFrame:FindFirstChildWhichIsA("TextLabel")
				if lbl then lbl.Text = tostring(text) end
			end
		end,
		Highlight = function() end,
		Destroy = function()
			CardFrame:Destroy()
		end,
	}

	function Card:SetColor(color)
		Card.Color = color
		CardFrame.BackgroundColor3 = color
	end

	function Card:Destroy()
		CardFrame:Destroy()
	end

	return Card.__type, Card
end

return Element
