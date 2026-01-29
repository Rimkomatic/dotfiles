return {
    'brianhuster/live-preview.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require('live-preview').setup({
            address = '0.0.0.0',
            port = 5500,
        })
    end,
}

