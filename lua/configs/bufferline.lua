local colors = require("tokyonight.colors").setup() -- pass in any of the config options as explained above
local util = require("tokyonight.util")

local bg = colors.bg_dark;
local fg = util.lighten(colors.bg_dark, 0.95);
local selected = colors.fg_dark;
local visible = util.lighten(colors.bg_dark, 0.5);

return {
  highlights = {
    fill = {
      fg = bg,
      bg = fg,
    },
    tab = {
      fg = visible,
      bg = bg,
    },
    tab_selected = {
      fg = selected,
      bg = bg,
      bold = true,
      italic = false,
    },
    background = {
      fg = fg,
      bg = bg,
    },
    buffer_visible = {
      fg = visible,
      bg = bg,
    },
    buffer_selected = {
      fg = selected,
      bg = bg,
      bold = true,
      italic = false,
    },
    close_button = {
      fg = selected,
      bg = bg,
    },
    close_button_visible = {
      fg = visible,
      bg = bg,
    },
    close_button_selected = {
      fg = selected,
      bg = bg,
    },
    indicator_visible = {
      fg = fg,
      bg = bg,
    },
    indicator_selected = {
      fg = fg,
      bg = bg,
    },
    modified = {
      fg = fg,
      bg = bg,
    },
    modified_visible = {
      fg = fg,
      bg = bg,
    },
    modified_selected = {
      fg = fg,
      bg = bg,
    },
    numbers = {
      fg = fg,
      bg = bg,
    },
    numbers_visible = {
      fg = fg,
      bg = bg,
    },
    numbers_selected = {
      fg = selected,
      bg = bg,
      bold = false,
      italic = false,
    },
    offset_separator = {
      fg = fg,
      bg = bg,
    },
    separator_selected = {
      fg = fg,
      bg = bg,
    },
    separator_visible = {
      fg = fg,
      bg = bg,
    },
    separator = {
      fg = fg,
      bg = bg,
    },
  },
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    -- mode = "tabs", -- set to "tabs" to only show tabpages instead
    themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
    middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
    indicator = {
      icon = "▎", -- this should be omitted if indicator style is not 'icon'
      style = "icon",
    },
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    truncate_names = true,  -- whether or not tab names should be truncated
    tab_size = 20,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      -- return "(" .. count .. ")"
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "left",
        separator = true,
      },
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    get_element_icon = function(element)
      -- element consists of {filetype: string, path: string, extension: string, directory: string}
      -- This can be used to change how bufferline fetches the icon
      -- for an element e.g. a buffer or a tab.
      -- e.g.
      local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
      return icon, hl
    end,
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
    persist_buffer_sort = true,   -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "slope",
    -- separator_style = "padded_slope",
    always_show_bufferline = true,
    hover = {
      enabled = false,
      delay = 200,
      reveal = { "close" },
    },
    sort_by = "tabs",
  },
}
