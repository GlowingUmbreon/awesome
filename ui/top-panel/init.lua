local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

configuration = require("configuration.config")
require("widgets.top-panel")

local keyboard_layout = require("keyboard_layoutt")
local kbdcfg = keyboard_layout.kbdcfg({ type = "tui" })

kbdcfg.add_primary_layout("Qwerty", "Q", "")
kbdcfg.add_primary_layout("Colemak", "C", "colemak")

kbdcfg.bind()
kbdcfg.widget:buttons(awful.util.table.join(
	awful.button({}, 1, function()
		kbdcfg.switch_next()
	end),
	awful.button({}, 3, function()
		kbdcfg.menu:toggle()
	end)
))

systray = wibox.widget.systray()
systray.visible = false

date = wibox.widget.textclock(" %a %b %d ")
time = wibox.widget.textclock("%H:%M",30)

local TopPanel = function(s)
	-- Wiboxes are much more flexible than wibars simply for the fact that there are no defaults, however if you'd rather have the ease of a wibar you can replace this with the original wibar code
	local panel = wibox({
		ontop = true,
		screen = s,
		height = configuration.toppanel_height,
		width = s.geometry.width-10,
		position = "top",
		x = s.geometry.x+5,
		y = s.geometry.y+5,
		stretch = false,
		bg = beautiful.background,
		fg = beautiful.fg_normal,
		struts = {
			top = configuration.toppanel_height,
		},
	})

	panel:struts({
		top = configuration.toppanel_height+10,
	})
	--

	panel:setup({
		layout = wibox.layout.stack,
		{
			layout = wibox.layout.align.horizontal,
			{ -- Left widgets
				layout = wibox.layout.fixed.horizontal,
				--mylauncher,
				s.mytaglist,
				s.mypromptbox,
			},
			nil,
			{
				layout = wibox.layout.fixed.horizontal,
				systray,
				date,
			},
		},
		
		--s.mytasklist, -- Middle widget
		--s.mylayoutbox,
		--kbdcfg,
		{ -- Right widgets
			--layout = wibox.layout.fixed.horizontal,
			layout = wibox.container.place,
			valign = "center",
			halign = "center",
			time,
		},
	})

	return panel
end

return TopPanel
