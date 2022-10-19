require('nvim-autopairs').setup()

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local nvmcmp = require('cmp')
nvmcmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)
