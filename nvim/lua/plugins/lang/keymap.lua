vim.filetype.add({
	pattern = {
		["*.keymap"] = "dts",
	},
})

return {
	{
		"codethread/qmk.nvim",
		opts = function()
			local keys = {
				["&bt BT_SEL"] = "BT",
				["&bt BT_CLR"] = "BT forget",
				["&sys_reset"] = "⏻",

				SPACE = "⎵",
				LSHFT = "⇧",
				LCMD = "⌘",
				LALT = "⌥",
				RSHFT = "⇧",
				RCMD = "⌘",
				RALT = "⌥",
				RET = "↩",
				-- BSPC = "⌫",
				DEL = "⌦",
				CAPS = "⇪",
				RCTRL = "⌃",
				LCTRL = "⌃",
				TAB = "⇥",
				LEFT = "←",
				UP = "↑",
				RIGHT = "→",
				DOWN = "↓",
				C_PP = "⏸",
				ESC = "⎋",

				-- LSHFT = "󰘶 ",
				-- LCMD = "󰘳 ",
				-- LCTRL = "󰘴 ",
				-- LALT = "󰘵 ",
				-- RET = "󱞥 ",
				BSPC = "󰁮",
				-- DEL = "󰹾 ",
				-- LEFT = "",
				-- DOWN = "",
				-- UP = "",
				-- RIGHT = "",
				-- TAB = "󰌒 ",
				-- ESC = "ESC",
			}

			for i = 1, 6 do
				keys["&sl " .. i] = "STICKY " .. i
				keys["&tog " .. i] = "TOGGLE " .. i
				keys["&to " .. i] = "TO " .. i
				keys["&mo " .. i] = "(" .. i .. ")"
			end

			return {
				name = "",
				variant = "zmk",
				layout = {
					"x x x x x x _ _ _ x x x x x x",
					"x x x x x x _ _ _ x x x x x x",
					"x x x x x x _ _ _ x x x x x x",
					"_ _ _ x x x^x _ x^x x x _ _ _",
				},
				auto_format_pattern = "*.keymap",
				comment_preview = {
					position = "top",
					keymap_overrides = keys,
					symbols = {
						space = " ",
						horz = "─",
						vert = "│",
						tl = "╭",
						tm = "┬",
						tr = "╮",
						ml = "├",
						mm = "┼",
						mr = "┤",
						bl = "╰",
						bm = "┴",
						br = "╯",
					},
				},
			}
		end,
	},
}
