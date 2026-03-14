-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   sidekick.lua                                       :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2026/03/14 17:30:00 by pibouill          #+#    #+#             --
--   Updated: 2026/03/14 17:30:00 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	{
		"folke/sidekick.nvim",
		opts = {
			nes = {
				enabled = true,
				diff = {
					inline = "words",
				},
			},
			cli = {
				mux = {
					backend = "tmux",
					enabled = true,
				},
			},
		},
		config = function(_, opts)
			require("sidekick").setup(opts)
			-- Enable the copilot language server for NES (Next Edit Suggestion)
			-- Required for sidekick to provide edit suggestions.
			if vim.lsp.config then
				vim.lsp.config.copilot = {
					cmd = { "copilot-language-server", "--stdio" },
					settings = {
						["github-copilot"] = {
							suggestion = { enabled = true },
						},
					},
				}
				vim.lsp.enable("copilot")
			end
		end,
		keys = {
			{
				"<tab>",
				function()
					-- if there is a next edit, jump to it, otherwise apply it if any
					if require("sidekick").nes_jump_or_apply() then
						return "" -- consume the keypress
					end
					return "<Tab>" -- fallback to normal tab
				end,
				expr = true,
				desc = "Goto/Apply Next Edit Suggestion",
			},
			{
				"<c-.>",
				function() require("sidekick.cli").toggle() end,
				desc = "Sidekick Toggle",
				mode = { "n", "t", "i", "x" },
			},
			{
				"<leader>aa",
				function() require("sidekick.cli").toggle() end,
				desc = "Sidekick Toggle CLI",
			},
			{
				"<leader>as",
				-- function() require("sidekick.cli").select() end,
				-- Or to select only installed tools:
				require("sidekick.cli").select({ filter = { installed = true } }),
				desc = "Select CLI",
			},
			{
				"<leader>ad",
				function() require("sidekick.cli").close() end,
				desc = "Detach a CLI Session",
			},
			{
				"<leader>at",
				function() require("sidekick.cli").send({ msg = "{this}" }) end,
				mode = { "x", "n" },
				desc = "Send This",
			},
			{
				"<leader>af",
				function() require("sidekick.cli").send({ msg = "{file}" }) end,
				desc = "Send File",
			},
			{
				"<leader>av",
				function() require("sidekick.cli").send({ msg = "{selection}" }) end,
				mode = { "x" },
				desc = "Send Visual Selection",
			},
			{
				"<leader>ap",
				function() require("sidekick.cli").prompt() end,
				mode = { "n", "x" },
				desc = "Sidekick Select Prompt",
			},
			-- Example of a keybinding to open Claude directly
			{
				"<leader>ac",
				function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
				desc = "Sidekick Toggle Claude",
			},
		},
	}
}
