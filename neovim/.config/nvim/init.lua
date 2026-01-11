vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.o.number = true
-- vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = true
vim.schedule(function()
        vim.o.clipboard = "unnamedplus"
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = false
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.o.winborder = "rounded"

vim.api.nvim_create_autocmd("TextYankPost", {
        desc = "Highlight when yanking (copying) text",
        group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
        callback = function()
                vim.hl.on_yank()
        end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
                error("Error cloning lazy.nvim:\n" .. out)
        end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
        "NMAC427/guess-indent.nvim",
        {
                "lewis6991/gitsigns.nvim",
                event = { "BufReadPre", "BufNewFile" },
                opts = {
                        -- Sol taraftaki renkli çubuklar (önceki konuşmamızdan)
                        signs = {
                                add = { text = "│" },
                                change = { text = "│" },
                                delete = { text = "_" },
                                topdelete = { text = "‾" },
                                changedelete = { text = "~" },
                        },
                        -- Blame ayarları
                        current_line_blame = false, -- Varsayılan kapalı olsun (dikkat dağıtmaması için)
                        current_line_blame_opts = {
                                virt_text = true,
                                virt_text_pos = "eol", -- Satır sonuna koy (End of Line)
                                delay = 300, -- 300ms bekleyince göstersin
                        },
                },
                keys = {
                        -- Grup ismi
                        { "<leader>g", group = "Git" },

                        -- 1. YÖNTEM: Satır sonuna hayalet metin aç/kapat (Toggle)
                        { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle Blame (Ghost Text)" },

                        -- 2. YÖNTEM: Detaylı pencere aç (Popup)
                        { "<leader>gB", "<cmd>Gitsigns blame_line<CR>", desc = "Blame Line (Full Popup)" },

                        -- Diğer faydalı Git komutları
                        { "<leader>gd", "<cmd>Gitsigns diffthis<CR>", desc = "Diff File" },
                        { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview Change" },
                },
        },
        {
                "folke/which-key.nvim",
                event = "VimEnter",
                opts = {
                        delay = 0,
                        win = {
                                border = "rounded",
                        },
                        icons = {
                                mappings = vim.g.have_nerd_font,
                                keys = vim.g.have_nerd_font and {} or {
                                        Up = "<Up> ",
                                        Down = "<Down> ",
                                        Left = "<Left> ",
                                        Right = "<Right> ",
                                        C = "<C-…> ",
                                        M = "<M-…> ",
                                        D = "<D-…> ",
                                        S = "<S-…> ",
                                        CR = "<CR> ",
                                        Esc = "<Esc> ",
                                        ScrollWheelDown = "<ScrollWheelDown> ",
                                        ScrollWheelUp = "<ScrollWheelUp> ",
                                        NL = "<NL> ",
                                        BS = "<BS> ",
                                        Space = "<Space> ",
                                        Tab = "<Tab> ",
                                        F1 = "<F1>",
                                        F2 = "<F2>",
                                        F3 = "<F3>",
                                        F4 = "<F4>",
                                        F5 = "<F5>",
                                        F6 = "<F6>",
                                        F7 = "<F7>",
                                        F8 = "<F8>",
                                        F9 = "<F9>",
                                        F10 = "<F10>",
                                        F11 = "<F11>",
                                        F12 = "<F12>",
                                },
                        },
                        spec = {
                                { "<leader>s", group = "[S]earch" },
                                { "<leader>t", group = "[T]oggle" },
                                { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
                        },
                },
        },

        {
                "nvim-telescope/telescope.nvim",
                event = "VimEnter",
                dependencies = {
                        "nvim-lua/plenary.nvim",
                        {
                                "nvim-telescope/telescope-fzf-native.nvim",
                                build = "make",
                                cond = function()
                                        return vim.fn.executable("make") == 1
                                end,
                        },
                        { "nvim-telescope/telescope-ui-select.nvim" },
                        { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
                },
                config = function()
                        require("telescope").setup({
                                extensions = {
                                        ["ui-select"] = {
                                                require("telescope.themes").get_dropdown(),
                                        },
                                },
                        })
                        pcall(require("telescope").load_extension, "fzf")
                        pcall(require("telescope").load_extension, "ui-select")

                        local builtin = require("telescope.builtin")
                        vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
                        vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
                        vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
                        vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
                        vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
                        vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
                        vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
                        vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
                        vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
                        vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

                        vim.keymap.set("n", "<leader>/", function()
                                builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                                        winblend = 10,
                                        previewer = false,
                                }))
                        end, { desc = "[/] Fuzzily search in current buffer" })

                        vim.keymap.set("n", "<leader>s/", function()
                                builtin.live_grep({
                                        grep_open_files = true,
                                        prompt_title = "Live Grep in Open Files",
                                })
                        end, { desc = "[S]earch [/] in Open Files" })

                        vim.keymap.set("n", "<leader>sn", function()
                                builtin.find_files({ cwd = vim.fn.stdpath("config") })
                        end, { desc = "[S]earch [N]eovim files" })
                end,
        },

        {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                        library = {
                                -- Load luvit types when the `vim.uv` word is found
                                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                        },
                },
        },
        {
                "neovim/nvim-lspconfig",
                dependencies = {
                        { "mason-org/mason.nvim", opts = {} },
                        "mason-org/mason-lspconfig.nvim",
                        "WhoIsSethDaniel/mason-tool-installer.nvim",
                        { "j-hui/fidget.nvim", opts = {} },
                        "saghen/blink.cmp",
                },
                config = function()
                        vim.api.nvim_create_autocmd("LspAttach", {
                                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                                callback = function(event)
                                        local map = function(keys, func, desc, mode)
                                                mode = mode or "n"
                                                vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                                        end
                                        map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
                                        map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
                                        map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                                        map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                                        map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                                        map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                                        map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
                                        map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
                                        map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
                                        local function client_supports_method(client, method, bufnr)
                                                if vim.fn.has("nvim-0.11") == 1 then
                                                        return client:supports_method(method, bufnr)
                                                else
                                                        return client.supports_method(method, { bufnr = bufnr })
                                                end
                                        end
                                        local client = vim.lsp.get_client_by_id(event.data.client_id)
                                        if
                                                client
                                                and client_supports_method(
                                                        client,
                                                        vim.lsp.protocol.Methods.textDocument_documentHighlight,
                                                        event.buf
                                                )
                                        then
                                                local highlight_augroup =
                                                        vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                                                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                                                        buffer = event.buf,
                                                        group = highlight_augroup,
                                                        callback = vim.lsp.buf.document_highlight,
                                                })

                                                vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                                                        buffer = event.buf,
                                                        group = highlight_augroup,
                                                        callback = vim.lsp.buf.clear_references,
                                                })

                                                vim.api.nvim_create_autocmd("LspDetach", {
                                                        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                                                        callback = function(event2)
                                                                vim.lsp.buf.clear_references()
                                                                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                                                        end,
                                                })
                                        end

                                        if
                                                client
                                                and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
                                        then
                                                map("<leader>th", function()
                                                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                                                end, "[T]oggle Inlay [H]ints")
                                        end
                                end,
                        })

                        vim.diagnostic.config({
                                severity_sort = true,
                                float = { border = "rounded", source = "if_many" },
                                underline = { severity = vim.diagnostic.severity.ERROR },
                                signs = {
                                        text = {
                                                [vim.diagnostic.severity.ERROR] = "󰅚 ",
                                                [vim.diagnostic.severity.WARN] = "󰀪 ",
                                                [vim.diagnostic.severity.INFO] = "󰋽 ",
                                                [vim.diagnostic.severity.HINT] = "󰌶 ",
                                        },
                                },

                                virtual_text = false,
                        })

                        vim.api.nvim_create_autocmd("CursorHold", {
                                buffer = bufnr,
                                callback = function()
                                        local opts = {
                                                focusable = false,
                                                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                                                border = "rounded",
                                                source = "always",
                                                prefix = " ",
                                                scope = "cursor",
                                        }
                                        vim.diagnostic.open_float(nil, opts)
                                end,
                        })

                        local capabilities = require("blink.cmp").get_lsp_capabilities()

                        local servers = {
                                clangd = {},
                                lua_ls = {
                                        settings = {
                                                Lua = {
                                                        completion = {
                                                                callSnippet = "Replace",
                                                        },
                                                },
                                        },
                                },
                        }

                        local ensure_installed = vim.tbl_keys(servers or {})
                        vim.list_extend(ensure_installed, {
                                "stylua", -- Used to format Lua code
                        })
                        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

                        require("mason-lspconfig").setup({
                                ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
                                automatic_installation = false,
                                handlers = {
                                        function(server_name)
                                                local server = servers[server_name] or {}
                                                server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                                                require("lspconfig")[server_name].setup(server)
                                        end,
                                },
                        })
                end,
        },

        {
                "stevearc/conform.nvim",
                event = { "BufWritePre" },
                cmd = { "ConformInfo" },
                keys = {
                        {
                                "<leader>f",
                                function()
                                        require("conform").format({ async = true, lsp_format = "fallback" })
                                end,
                                mode = "",
                                desc = "[F]ormat buffer",
                        },
                },
                opts = {
                        notify_on_error = true,
                        format_on_save = function(bufnr)
                                local disable_filetypes = { c = true, cpp = true }
                                if disable_filetypes[vim.bo[bufnr].filetype] then
                                        return nil
                                else
                                        return {
                                                timeout_ms = 500,
                                                lsp_format = "fallback",
                                        }
                                end
                        end,

                        formatters_by_ft = {
                                lua = { "stylua" },
                                c = { "clang_format" },
                                cpp = { "clang_format" },
                        },

                        formatters = {
                                clang_format = {
                                        prepend_args = function(self, ctx)
                                                local found = vim.fs.find({ ".clang-format", "_clang-format" }, {
                                                        upward = true,
                                                        path = ctx.dirname,
                                                        stop = vim.uv.os_homedir(),
                                                })

                                                if #found > 0 then
                                                        return { "--style=file" }
                                                end

                                                return {
                                                        "--style={BasedOnStyle: LLVM, IndentWidth: 8, TabWidth: 8, UseTab: Always, ContinuationIndentWidth: 8, BreakBeforeBraces: Linux, AllowShortFunctionsOnASingleLine: None, KeepEmptyLinesAtTheStartOfBlocks: false, PointerAlignment: Right, IndentCaseLabels: false, SortIncludes: false, ColumnLimit: 80}",
                                                }
                                        end,
                                },
                        },
                },
        },

        {
                "saghen/blink.cmp",
                event = "VimEnter",
                version = "1.*",
                dependencies = {
                        -- Snippet Engine
                        {
                                "L3MON4D3/LuaSnip",
                                version = "2.*",
                                build = (function()
                                        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                                                return
                                        end
                                        return "make install_jsregexp"
                                end)(),
                                dependencies = {},
                                opts = {},
                        },
                        "folke/lazydev.nvim",
                },
                opts = {
                        keymap = {
                                preset = "enter",
                        },

                        appearance = {
                                nerd_font_variant = "mono",
                        },

                        completion = {
                                menu = {
                                        border = "rounded", -- Köşeli çerçeve çiz
                                        draw = {
                                                columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
                                        },
                                },

                                documentation = {
                                        auto_show = true,
                                        auto_show_delay_ms = 500,
                                        window = {
                                                border = "rounded", -- Çerçeve çiz
                                        },
                                },
                        },

                        signature = {
                                enabled = true,
                                window = { border = "rounded" },
                        },

                        sources = {
                                default = { "lsp", "path", "snippets", "lazydev" },
                                providers = {
                                        lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
                                },
                        },

                        snippets = { preset = "luasnip" },
                        fuzzy = { implementation = "lua" },
                        signature = { enabled = true },
                },
        },
        {
                "folke/todo-comments.nvim",
                event = "VimEnter",
                dependencies = { "nvim-lua/plenary.nvim" },
                opts = { signs = false },
        },

        {
                "echasnovski/mini.nvim",
                config = function()
                        require("mini.ai").setup({ n_lines = 500 })
                        require("mini.surround").setup()
                        local statusline = require("mini.statusline")
                        statusline.setup({ use_icons = vim.g.have_nerd_font })
                        statusline.section_location = function()
                                return "%2l:%-2v"
                        end
                end,
        },
        {
                "nvim-treesitter/nvim-treesitter",
                build = ":TSUpdate",
                opts = {
                        ensure_installed = {
                                "c",
                        },
                        auto_install = true,
                        highlight = {
                                enable = true,
                                additional_vim_regex_highlighting = { "ruby" },
                        },
                        indent = { enable = true, disable = { "ruby" } },
                },
        },
        {
                "mfussenegger/nvim-dap",
                dependencies = {
                        "rcarriga/nvim-dap-ui",
                        "nvim-neotest/nvim-nio",
                        "williamboman/mason.nvim",
                        "jay-babu/mason-nvim-dap.nvim",
                },
                config = function()
                        local dap = require("dap")
                        local dapui = require("dapui")

                        require("mason-nvim-dap").setup({
                                ensure_installed = { "codelldb" },
                                automatic_installation = true,
                                handlers = {},
                        })

                        dapui.setup()
                        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
                        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
                        dap.listeners.before.event_exited["dapui_config"] = dapui.close

                        dap.configurations.c = {
                                {
                                        name = "Start Debugging",
                                        type = "codelldb",
                                        request = "launch",
                                        program = function()
                                                return vim.fn.input("Exectuable path (exp: ./a.out): ", vim.fn.getcwd() .. "/", "file")
                                        end,
                                        cwd = "${workspaceFolder}",
                                        stopOnEntry = false,
                                },
                        }
                        dap.configurations.cpp = dap.configurations.c

                        -- --- GÜVENLİ ASSEMBLY AYARLARI ---

                        -- 1. Assembly Adımlama (Instruction Step Into)
                        vim.keymap.set("n", "<leader>si", function()
                                require("dap").step_into({ steppingGranularity = "instruction" })
                        end, { desc = "Step [I]nstruction (ASM)" })

                        -- 2. Assembly Göster (Debug Assembly)
                        -- Bu komut REPL penceresini açar ve otomatik olarak disassemble komutunu yazar.
                        vim.keymap.set("n", "<leader>da", function()
                                local dap = require("dap")
                                dap.repl.open() -- REPL penceresini garantili aç
                                -- C++ (lldb/gdb) için assembly dökme komutu:
                                dap.repl.execute("disassemble")
                        end, { desc = "[D]ebug [A]ssembly View" })

                        -- --- AYARLAR SONU ---

                        vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start / Continue" })
                        vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
                        vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
                        vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
                        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Add / Remove Breakpoint" })
                        vim.keymap.set("n", "<leader>B", function()
                                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
                        end, { desc = "Debug: Add / Remove Conditional Breakpoint" })
                end,
        },

        {
                "ellisonleao/gruvbox.nvim",
                enabled  = false,
                priority = 1000, -- Temanin diger her seyden once yuklenmesi icin
                config = function()
                        -- Renk paleti ayari (hard, medium, soft secenekleri var)
                        vim.o.background = "dark"
                        require("gruvbox").setup()
                        vim.cmd("colorscheme gruvbox")
                        -- Kolonlardaki (SignColumn, FoldColumn, NumberColumn) arka planı temizle
                        local transparent_columns = {
                                "SignColumn",
                                "FoldColumn",
                                "LineNr",
                                "CursorLineNr",
                        }

                        for _, group in ipairs(transparent_columns) do
                                vim.api.nvim_set_hl(0, group, { bg = "NONE" })
                        end

                        -- nvim-ufo'nun kullandığı katlama kolonu işaretlerini de şeffaflaştıralım
                        vim.api.nvim_set_hl(0, "UfoFoldCursorLine", { bg = "NONE" })
                end,
        },

        {
                "habamax_theme",
                -- enabled = false,
                dir = vim.fn.stdpath("config"),
                priority = 1000,
                config = function()
                        -- Temayı yükle
                        vim.cmd.colorscheme("habamax")
                        vim.opt.showcmd = false
                        vim.opt.ruler = false
                        vim.opt.cursorline = true

                        vim.opt.fillchars = {
                                vert = "│",
                                horiz = "─",
                                eob = " ",
                                fold = " ",
                                diff = "╱",
                        }
                        vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#555555", bg = "NONE" })

                        local transparent_groups = {
                                "Normal",
                                "NormalFloat",
                                -- 'FloatBorder',
                                "SignColumn",
                                "EndOfBuffer",
                                "NormalNC",
                                "Pmenu",
                                "PmenuBorder",
                                "CursorLine",
                        }
                        for _, group in ipairs(transparent_groups) do
                                vim.api.nvim_set_hl(0, group, { bg = "NONE" })
                        end

                        vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ffffff", bg = "NONE" })

                        vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", { bg = "NONE", fg = "#7e8294" })
                        vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { bg = "NONE", fg = "#7e8294" })

                        local kinds = {
                                "Class",
                                "Color",
                                "Constant",
                                "Constructor",
                                "Enum",
                                "EnumMember",
                                "Event",
                                "Field",
                                "File",
                                "Folder",
                                "Function",
                                "Interface",
                                "Keyword",
                                "Method",
                                "Module",
                                "Operator",
                                "Property",
                                "Reference",
                                "Snippet",
                                "Struct",
                                "Text",
                                "TypeParameter",
                                "Unit",
                                "Value",
                                "Variable",
                        }
                        for _, kind in ipairs(kinds) do
                                vim.api.nvim_set_hl(0, "BlinkCmpKind" .. kind, { bg = "NONE", fg = "#87afaf" })
                        end

                        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

                        vim.lsp.handlers["textDocument/signatureHelp"] =
                                vim.lsp.with(vim.lsp.handlers.signatureHelp, { border = "rounded" })

                        vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermfg = 196, fg = "#e06c75" })
                        vim.api.nvim_set_hl(0, "DapStopped", { ctermfg = 46, fg = "#98c379" })
                        vim.api.nvim_set_hl(0, "DapStoppedLine", { ctermbg = 236, bg = "#31353f" })

                        local sign = vim.fn.sign_define

                        sign("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })

                        sign("DapBreakpointCondition", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })

                        sign("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })

                        sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })
                end,
        },

        {
                "kevinhwang91/nvim-ufo",
                dependencies = "kevinhwang91/promise-async",
                config = function()
                        vim.o.foldcolumn = "3"
                        vim.o.foldlevel = 99
                        vim.o.foldlevelstart = 99
                        vim.o.foldenable = true
                        vim.opt.fillchars = {
                                eob = " ",
                                fold = " ",
                                foldopen = "󰁅",
                                foldsep = "│",
                                foldclose = "",
                        }
                        require("ufo").setup({
                                provider_selector = function(bufnr, filetype, buftype)
                                        return { "treesitter", "indent" }
                                end,
                        })
                end,
        },

        {
                "luukvbaal/statuscol.nvim",
                config = function()
                        local builtin = require("statuscol.builtin")
                        require("statuscol").setup({
                                relculright = true,
                                segments = {
                                        { text = { "%s" }, click = "v:lua.ScSa" },
                                        {
                                                text = { builtin.lnumfunc, " " },
                                                click = "v:lua.ScLa",
                                        },
                                        {
                                                text = { builtin.foldfunc, " " },
                                                click = "v:lua.ScFa",
                                        },
                                },
                        })
                        vim.opt.signcolumn = "yes"
                end,
        },
        {
                "p00f/clangd_extensions.nvim",
                config = function()
                        require("clangd_extensions").setup({
                                inlay_hints = {
                                        inline = false, -- Satır sonuna mı yoksa kodun içine mi koysun?
                                },
                        })
                        -- Clangd yeteneği: Header/Source arası geçiş (Örn: main.c <-> main.h)
                        vim.keymap.set("n", "gs", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Header/Source Geçişi" })
                end,
        },

        {
                "nvim-treesitter/nvim-treesitter-context",
                config = function()
                        require("treesitter-context").setup({
                                enable = true,
                                max_lines = 3, -- En fazla 3 satır yapışsın
                        })
                end,
        },
        {
                "hedyhli/outline.nvim",
                config = function()
                        require("outline").setup({})
                end,
                keys = {
                        { "<leader>o", "<cmd>Outline<CR>", desc = "Sembol Haritasını Aç" },
                },
        },
        {
                "danymat/neogen",
                config = true,
                -- Şu versiyonlar daha kararlı çalışıyor
                version = "*",
                keys = {
                        { "<leader>nf", "<cmd>Neogen func<CR>", desc = "Fonksiyon Dokümantasyonu Oluştur" },
                },
        },
        {
                "folke/trouble.nvim",
                dependencies = { "nvim-tree/nvim-web-devicons" },
                opts = {}, -- Varsayılan ayarlar yeterli
                cmd = "Trouble",
                keys = {
                        {
                                "<leader>xx",
                                "<cmd>Trouble diagnostics toggle<cr>",
                                desc = "Hataları (Diagnostics) Aç/Kapat",
                        },
                },
        },

        {
                "Civitasv/cmake-tools.nvim",
                opts = {
                        cmake_build_directory = "build",
                        -- Clangd gibi LSP'lerin projeyi tanıması için bu seçenek zorunludur
                        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
                },
                keys = {
                        -- Group Name for WhichKey (Leader + c basınca bu grubun adı görünür)
                        { "<leader>c", group = "CMake / C++" },

                        -- Project Management
                        { "<leader>cg", "<cmd>CMakeGenerate<CR>", desc = "Generate Project" },
                        { "<leader>cb", "<cmd>CMakeBuild<CR>", desc = "Build Project" },
                        { "<leader>cr", "<cmd>CMakeRun<CR>", desc = "Run Target" },
                        { "<leader>cd", "<cmd>CMakeDebug<CR>", desc = "Debug Target" },

                        -- Target & Settings Selection
                        { "<leader>ct", "<cmd>CMakeSelectLaunchTarget<CR>", desc = "Select Launch Target" },
                        { "<leader>cT", "<cmd>CMakeSelectBuildType<CR>", desc = "Select Build Type (Debug/Release)" },
                        { "<leader>ck", "<cmd>CMakeSelectKit<CR>", desc = "Select Kit (Compiler)" },

                        -- UI Control
                        { "<leader>cq", "<cmd>CMakeClose<CR>", desc = "Close CMake Panel" },

                        -- Quick Utility (Opsiyonel: Hızlı temizleme)
                        { "<leader>cc", "<cmd>CMakeClean<CR>", desc = "Clean Build Directory" },
                },
        },

        {
                "ThePrimeagen/harpoon",
                branch = "harpoon2",
                dependencies = {
                        "nvim-lua/plenary.nvim",
                        "nvim-telescope/telescope.nvim", -- Telescope bağımlılığı eklendi
                },
                config = function()
                        require("harpoon").setup()
                end,
                keys = {
                        -- Harpoon Ana Menü Grubu
                        { "<leader>h", group = "Harpoon" },

                        -- 1. Dosyayı Listeye Ekle
                        {
                                "<leader>ha",
                                function()
                                        require("harpoon"):list():add()
                                end,
                                desc = "Add File to Harpoon",
                        },

                        -- 2. Standart Harpoon Menüsü (Küçük Pencere)
                        {
                                "<leader>hl",
                                function()
                                        require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
                                end,
                                desc = "List / Edit Harpoon Menu",
                        },

                        -- 3. TELESCOPE ENTEGRASYONU (İstediğin Özellik)
                        -- <leader>ht tuşuna basınca Harpoon listesi Telescope içinde açılır.
                        {
                                "<leader>ht",
                                function()
                                        local harpoon = require("harpoon")
                                        local conf = require("telescope.config").values

                                        -- Harpoon listesindeki dosyaları çekip Telescope formatına çeviriyoruz
                                        local file_paths = {}
                                        for _, item in ipairs(harpoon:list().items) do
                                                table.insert(file_paths, item.value)
                                        end

                                        require("telescope.pickers")
                                                .new({}, {
                                                        prompt_title = "Harpoon Files",
                                                        finder = require("telescope.finders").new_table({
                                                                results = file_paths,
                                                        }),
                                                        previewer = conf.file_previewer({}),
                                                        sorter = conf.generic_sorter({}),
                                                })
                                                :find()
                                end,
                                desc = "Search Harpoon List (Telescope)",
                        },

                        -- 4. Hızlı Geçişler (1, 2, 3, 4)
                        {
                                "<leader>1",
                                function()
                                        require("harpoon"):list():select(1)
                                end,
                                desc = "Harpoon: File 1",
                        },
                        {
                                "<leader>2",
                                function()
                                        require("harpoon"):list():select(2)
                                end,
                                desc = "Harpoon: File 2",
                        },
                        {
                                "<leader>3",
                                function()
                                        require("harpoon"):list():select(3)
                                end,
                                desc = "Harpoon: File 3",
                        },
                        {
                                "<leader>4",
                                function()
                                        require("harpoon"):list():select(4)
                                end,
                                desc = "Harpoon: File 4",
                        },
                },
        },
        {
                "windwp/nvim-autopairs",
                event = "InsertEnter",
                -- Bu ayar opsiyoneldir ama <CR> (Enter) entegrasyonu için faydalıdır
                opts = {
                        check_ts = true, -- Treesitter kullanarak daha akıllı davranır
                },
        },

        {
                "akinsho/toggleterm.nvim",
                version = "*",
                opts = {
                        size = 20,
                        open_mapping = [[<c-\>]], -- CTRL + \ tuşu terminali açar/kapatır
                        direction = "float", -- Yüzen pencere (float), yatay (horizontal) veya dikey (vertical) olabilir
                        float_opts = {
                                border = "curved", -- Şık yuvarlak kenarlar
                        },
                },
        },

        {
                "folke/persistence.nvim",
                event = "BufReadPre", -- Sadece dosya açıldığında yüklenir
                opts = {},
                keys = {
                        {
                                "<leader>qs",
                                function()
                                        require("persistence").load()
                                end,
                                desc = "Oturumu Geri Yükle",
                        },
                        {
                                "<leader>ql",
                                function()
                                        require("persistence").load({ last = true })
                                end,
                                desc = "Son Oturumu Yükle",
                        },
                        {
                                "<leader>qd",
                                function()
                                        require("persistence").stop()
                                end,
                                desc = "Oturum Kaydını Durdur",
                        },
                },
        },

        {
                "nvim-neo-tree/neo-tree.nvim",
                branch = "v3.x",
                dependencies = {
                        "nvim-lua/plenary.nvim",
                        "nvim-tree/nvim-web-devicons",
                        "MunifTanjim/nui.nvim",
                },
                keys = {
                        { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Dosya Gezginini Aç/Kapat" },
                },
                opts = {
                        filesystem = {
                                filtered_items = {
                                        visible = true, -- Gizli dosyaları göster
                                        hide_dotfiles = false,
                                        hide_gitignored = false,
                                },
                                follow_current_file = {
                                        enabled = true, -- Açık olan dosyaya otomatik odaklan
                                },
                        },
                },
        },
        {
                "sindrets/diffview.nvim",
                keys = {
                        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff View Aç" },
                        { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Diff View Kapat" },
                        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Bu dosyanın geçmişini gör" },
                },
        },

        {
                "mbbill/undotree",
                config = function()
                        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undo Ağacını Aç" })
                end,
        },

        {
                "folke/flash.nvim",
                event = "VeryLazy",
                opts = {},
                keys = {
                        {
                                "s",
                                mode = { "n", "x", "o" },
                                function()
                                        require("flash").jump()
                                end,
                                desc = "Flash Jump",
                        },
                },
        },

        {
                "lukas-reineke/indent-blankline.nvim",
                main = "ibl",
                opts = {
                        indent = {
                                char = "", -- HİÇBİR ŞEY KOYMA (Temiz görünüm)
                        },
                        scope = {
                                enabled = true,
                                show_start = false,
                                show_end = false,
                                highlight = "IblScope", -- Özel renk grubu
                        },
                },
                config = function(_, opts)
                        -- Arka plan rengini hafifçe açan bir grup tanımlıyoruz
                        -- Bu renk Habamax temasıyla uyumlu hafif bir ton
                        vim.api.nvim_set_hl(0, "IblScope", { bg = "#262626" })

                        require("ibl").setup(opts)
                end,
        },
}, {
        ui = {
                icons = vim.g.have_nerd_font and {} or {
                        cmd = "⌘",
                        config = "🛠",
                        event = "📅",
                        ft = "📂",
                        init = "⚙",
                        keys = "🗝",
                        plugin = "🔌",
                        runtime = "💻",
                        require = "🌙",
                        source = "📄",
                        start = "🚀",
                        task = "📌",
                        lazy = "💤 ",
                },
        },
})
