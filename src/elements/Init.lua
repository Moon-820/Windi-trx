return {
	Elements = {
		Paragraph   = require("./Paragraph"),
		Button      = require("./Button"),
		Toggle      = require("./Toggle"),
		Slider      = require("./Slider"),
		Keybind     = require("./Keybind"),
		Input       = require("./Input"),
		Dropdown    = require("./Dropdown"),
		Code        = require("./Code"),
		Colorpicker = require("./Colorpicker"),
		Section     = require("./Section"),
		Divider     = require("./Divider"),
		Space       = require("./Space"),
		Image       = require("./Image"),
		Group       = require("./Group"),
		HStack      = require("./HStack"),
		VStack      = require("./VStack"),
		ProgressBar = require("./ProgressBar"),
		Card        = require("./Card"),
		StatCard    = require("./StatCard"),
		ProfileCard = require("./ProfileCard"),
		Timeline    = require("./Timeline"),
		Countdown   = require("./Countdown"),
	},
	Load = function(tbl, Container, Elements, Window, WindUI, OnElementCreateFunction, ElementsModule, UIScale, Tab)
		for name, module in next, Elements do
			tbl[name] = function(self, config)
				config = config or {}
				config.Tab            = Tab or tbl
				config.ParentType     = tbl.__type
				config.ParentTable    = tbl
				config.Index          = #tbl.Elements + 1
				config.GlobalIndex    = #Window.AllElements + 1
				config.Parent         = Container
				config.Window         = Window
				config.WindUI         = WindUI
				config.UIScale        = UIScale
				config.ElementsModule = ElementsModule

				local elementInstance, content = module:New(config)

				if config.Flag and typeof(config.Flag) == "string" then
					if Window.CurrentConfig then
						Window.CurrentConfig:Register(config.Flag, content)
						if Window.PendingConfigData and Window.PendingConfigData[config.Flag] then
							local data = Window.PendingConfigData[config.Flag]
							local ConfigManager = Window.ConfigManager
							if ConfigManager.Parser[data.__type] then
								task.defer(function()
									local ok, err = pcall(function()
										ConfigManager.Parser[data.__type].Load(content, data)
									end)
									if ok then
										Window.PendingConfigData[config.Flag] = nil
									else
										warn("[ WindUI ] Failed to apply config for '" .. config.Flag .. "': " .. tostring(err))
									end
								end)
							end
						end
					else
						Window.PendingFlags = Window.PendingFlags or {}
						Window.PendingFlags[config.Flag] = content
					end
				end

				local frame
				for key, value in next, content do
					if typeof(value) == "table" and key ~= "ElementFrame" and key:match("Frame$") then
						frame = value
						break
					end
				end

				if frame then
					content.ElementFrame = frame.UIElements.Main
					function content:SetTitle(t)    return frame.SetTitle and frame:SetTitle(t) end
					function content:SetDesc(d)     return frame.SetDesc  and frame:SetDesc(d)  end
					function content:SetImage(i, s) return frame.SetImage and frame:SetImage(i, s) end
					function content:Highlight()    frame:Highlight() end
					function content:Destroy()
						frame:Destroy()
						table.remove(Window.AllElements, config.GlobalIndex)
						table.remove(tbl.Elements, config.Index)
						if Tab then table.remove(Tab.Elements, config.Index) end
						tbl:UpdateAllElementShapes(tbl)
					end
				end

				Window.AllElements[config.Index] = content
				tbl.Elements[config.Index]       = content
				if Tab then Tab.Elements[config.Index] = content end

				if Window.NewElements then tbl:UpdateAllElementShapes(tbl) end
				if OnElementCreateFunction then OnElementCreateFunction(content, tbl.Elements) end
				return content
			end
		end

		function tbl:UpdateAllElementShapes(bbb)
			for i, element in next, bbb.Elements do
				local frame
				for key, value in pairs(element) do
					if typeof(value) == "table" and key:match("Frame$") then
						frame = value
						break
					end
				end
				if frame then
					frame.Index = i
					if frame.UpdateShape then frame.UpdateShape(bbb) end
				end
			end
		end
	end,
}
