return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  opts = {
    options = {
      mode = 'buffers', -- 'tabs' shows tabpages, 'buffers' shows all buffers
      numbers = 'both', -- how to show numbers: 'none' | 'ordinal' | 'buffer_id' | 'both' | function
      close_command = 'bdelete! %d', -- command to run when closing a buffer from the line
      right_mouse_command = 'bdelete! %d', -- right click action
      left_mouse_command = 'buffer %d', -- left click action
      middle_mouse_command = nil, -- middle click action (nil = do nothing)
      indicator = {
        style = 'icon', -- 'icon' | 'underline' | 'none'
        icon = '▎',
      },
      max_name_length = 18, -- truncate long names
      max_prefix_length = 15, -- prefix (e.g. path) before filename
      tab_size = 18, -- minimum width of each tab
      diagnostics = false, -- show diagnostics: false | 'nvim_lsp' | 'coc' | function
      show_buffer_icons = true, -- filetype icons
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true, -- little indicators when more tabs exist
      persist_buffer_sort = true, -- save manual sorting
      separator_style = 'slant', -- 'slant' | 'padded_slant' | 'thick' | 'thin' | { 'left', 'right' }
      enforce_regular_tabs = false, -- force equal widths
      always_show_bufferline = true, -- show even with one buffer
      sort_by = 'relative_directory', -- 'id' | 'extension' | 'relative_directory' | 'directory' | function
    },
  },
  config = function(_, opts)
    require('bufferline').setup(opts)
  end,
}
