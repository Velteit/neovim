return {
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
    middle_mouse_command = nil,          -- can be a string | function, | false see "Mouse actions"
    indicator = {
      icon = '▎', -- this should be omitted if indicator style is not 'icon'
      style = 'icon',
    },
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    truncate_names = true, -- whether or not tab names should be truncated
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
        return "("..count..")"
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    offsets = {
        {
            filetype = "NvimTree",
            text = "File Explorer" ,
            text_align = "left",
            separator = true
        }
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    get_element_icon = function(element)
      -- element consists of {filetype: string, path: string, extension: string, directory: string}
      -- This can be used to change how bufferline fetches the icon
      -- for an element e.g. a buffer or a tab.
      -- e.g.
      local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(opts.filetype, { default = false })
      return icon, hl
    end,
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "slant",
    always_show_bufferline = true,
    hover = {
        enabled = false,
        delay = 200,
        reveal = {'close'}
    },
    sort_by = 'tabs'
  }
}
