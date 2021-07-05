local M = {}

function M.setup()
    vim.api.nvim_set_keymap('n', '<Leader>e', '<cmd>NvimTreeToggle<CR>',
                            {noremap = true, silent = true})
end

function M.config()
    vim.g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'}
    vim.g.nvim_tree_auto_open = 0 -- 0 by default, opens the tree when typing `nvim $DIR` or `nvim`
    vim.g.nvim_tree_auto_close = 0 -- 0 by default, closes the tree when it's the last window
    vim.g.nvim_tree_follow = 1 -- 0 by default, this option allows the cursor to be updated when entering a buffer
    vim.g.nvim_tree_indent_markers = 1 -- 0 by default, this option shows indent markers when folders are open
    vim.g.nvim_tree_git_hl = 1 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
    vim.g.nvim_tree_width = 30 -- 30 by default
    vim.g.nvim_tree_quit_on_open = 0 -- 0 by default, closes the tree when you open a file
    vim.g.nvim_tree_hide_dotfiles = 1 -- 0 by default, this option hides files and folders starting with a dot `.`
    vim.g.nvim_tree_tab_open = 0 -- 0 by default, will open the tree when entering a new tab and the tree was previously open
    vim.g.nvim_tree_allow_resize = 0 -- 0 by default, will not resize the tree when opening a file
    vim.g.nvim_tree_disable_keybindings = 0
    --  modify some of the key mappings
    local tree_cb = require'nvim-tree.config'.nvim_tree_callback
    vim.g.nvim_tree_bindings = {
        { key = '<CR>', cb = tree_cb('edit')},
        { key = 'o', cb = tree_cb('edit')},
        { key = '<C-v>', cb = tree_cb('vsplit')},
        { key = '<C-x>', cb = tree_cb('split')},
        { key = '<C-t>', cb = tree_cb('tabnew')},
        { key = '<S-CR>', cb = tree_cb('close_node')},
        { key = 'h', cb = tree_cb('close_node')},
        { key = '!', cb = tree_cb('toggle_ignored')},
        { key = '.', cb = tree_cb('toggle_dotfiles')},
        { key = 'R', cb = tree_cb('refresh')},
        { key = 'a', cb = tree_cb('create')},
        { key = '<BS>', cb = tree_cb('remove')},
        { key = 'r', cb = tree_cb('rename')},
        { key = '<C-r>', cb = tree_cb('full_rename')},
        { key = 'dd', cb = tree_cb('cut')},
        { key = 'yy', cb = tree_cb('copy')},
        { key = 'p', cb = tree_cb('paste')},
        { key = '[c', cb = tree_cb('prev_git_item')},
        { key = ']c', cb = tree_cb('next_git_item')},
        { key = '-', cb = tree_cb('dir_up')},
        { key = '<C-]>', cb = tree_cb('cd')},
        { key = 'q', cb = tree_cb('close')},
        { key = '?', cb = tree_cb('toggle_help')},

    }

    vim.g.nvim_tree_icons = {
        default = ' ',
        symlink = ' ',
        git = {
            unstaged = '✗',
            staged = '✓',
            unmerged = '',
            renamed = '➜',
            untracked = '+'
        },
        folder = {default = '', open = ''}
    }

    vim.cmd([[
      hi link NvimTreeIndentMarker Whitespace
    ]])
      -- hi link NvimTreeFolderIcon Text

    -- lazy-loading
    require'nvim-tree.events'.on_nvim_tree_ready(
        function()
            vim.cmd 'NvimTreeRefresh'
        end
    )
end

return M
