require("general")

require("plugins").init_packer(function(use)
	-- Appearance
	use({
		"lunarvim/Onedarker.nvim",
		config = function()
			-- vim.cmd('colorscheme onedarker')
		end,
	})
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
			})

			vim.cmd("colorscheme catppuccin")
		end,
	})

	-- Navigation
	use({
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					buffer_close_icon = "",
					modified_icon = "●",
					close_icon = "",
					left_trunc_marker = "",
					right_trunc_marker = "",
					offsets = {
						{
							filetype = "NvimTree",
							text = "Explorer",
							text_align = "left",
							separator = true,
						},
					},
					color_icons = true,
				},
			})
		end,
	})
	use({
		"ThePrimeagen/harpoon",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon").setup()

			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "\\h", ui.toggle_quick_menu, {})
			vim.keymap.set("n", "<Leader>a", mark.add_file, {})

			vim.keymap.set("n", "<M-n>", ui.nav_next, {})
			vim.keymap.set("n", "<M-p>", ui.nav_prev, {})

			for i = 1, 9 do
				vim.keymap.set("n", string.format("<Leader>%d", i), function()
					ui.nav_file(i)
				end, {})
			end
		end,
	})

	-- NvimTree
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				filters = {
					git_ignored = false,
					dotfiles = false,
					git_clean = false,
					no_buffer = false,
				},
				on_attach = function(bf)
					local api = require("nvim-tree.api")
					local search = require("search")
					local opts = { buffer = bf, noremap = true, silent = false, nowait = true }

					-- default mappings
					api.config.mappings.default_on_attach(bf)

					local get_current_directory = function()
						local node = api.tree.get_node_under_cursor()

						return node.type == "directory" and node.absolute_path or node.parent.absolute_path
					end

					local grep_in_directory = function()
						search.grep_in_folder(get_current_directory())
					end

					local find_file_in_directory = function()
						search.find_file_in_folder(get_current_directory())
					end

					vim.keymap.set("n", "\\f", grep_in_directory, opts)
					vim.keymap.set("n", "<Leader>t", find_file_in_directory, opts)
				end,
			})

			vim.api.nvim_set_keymap("", "<Leader>n", ":NvimTreeToggle<CR>", {})
			vim.api.nvim_set_keymap("", "<Leader><Space>n", ":NvimTreeFindFileToggle<CR>", {})

			-- Close NvimTree on quit
			vim.api.nvim_create_autocmd({ "QuitPre" }, {
				callback = function()
					vim.cmd("NvimTreeClose")
				end,
			})
		end,
	})
	-- Line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup({
				options = { theme = "nightfly" },
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	})

	-- Telescope
	require("search").init(use)

	-- LSP
	require("lsp").init(use)

	-- GIT
	require("git").init(use)

	-- Tresitter
	require("treesitter").init(use)

	-- Identation
	use("tpope/vim-sleuth")

	-- Comment
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- Buffers helper
	use("vim-scripts/BufOnly.vim")

	-- Surround
	use({
		"tpope/vim-surround",
	})

	-- Better text objects
	use({
		"echasnovski/mini.ai",
		config = function()
			require("mini.ai").setup({
				search_method = "cover",
				n_lines = 5000,
			})
		end,
	})

	use({
		"echasnovski/mini.move",
		config = function()
			require("mini.move").setup({
				mappings = {
					left = "H",
					down = "J",
					up = "K",
					right = "L",
				},
			})
		end,
	})

	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	use({
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = function()
			require("bqf").setup({
				auto_resize_height = false,
				preview = {
					auto_preview = false,
				},
			})
		end,
	})
end)
