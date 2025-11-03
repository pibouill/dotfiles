-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   cop_chat.lua                                       :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2025/01/22 13:22:23 by pibouill          #+#    #+#             --
--   Updated: 2025/01/22 13:22:44 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "main",
	cmd = "CopilotChat",
	opts = function()
		local user = (vim.env.USER or "User"):gsub("^%l", string.upper)
		user = user:sub(1, 1):upper() .. user:sub(2)
		return {
			auto_insert_mode = true,
			question_header = "  " .. user .. " ",
			answer_header = "  Copilot ",
			window = {
				width = 0.4,
			},
			-- model = 'gpt-4o',
			-- model = 'claude-haiku-4.5',
			-- model = 'claude-3.7-sonnet',
			-- model = 'gemini-2.0-flash-001',
			-- model = 'claude-3.7-sonnet-thought'
			model = 'grok-code-fast-1',
			-- agent = 'anthropic',
		}
	end,
	keys = {
		{ "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
		{ "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
		{
			"<leader>aa",
			function()
				return require("CopilotChat").toggle()
			end,
			desc = "Toggle (CopilotChat)",
			mode = { "n", "v" },
		},
		{
			"<leader>ax",
			function()
				return require("CopilotChat").reset()
			end,
			desc = "Clear (CopilotChat)",
			mode = { "n", "v" },
		},
		{
			"<leader>aq",
			function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input)
				end
			end,
			desc = "Quick Chat (CopilotChat)",
			mode = { "n", "v" },
		},
		{
			"<leader>ap",
			function()
				require("CopilotChat").select_prompt()
			end,
			desc = "Prompt Actions (CopilotChat)",
			mode = { "n", "v" },
		},
		-- ppxity
		{
			"<leader>ccs",
			function()
				local input = vim.fn.input("Perplexity: ")
				if input ~= "" then
					require("CopilotChat").ask(input, { agent = "perplexityai", selection = false })
				end
			end, { desc = "Perplexity (CopilotChat)" , mode = { "n", "v" }}
		}
	},
	config = function(_, opts)
		local chat = require("CopilotChat")

		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "copilot-chat",
			callback = function()
				vim.opt_local.relativenumber = false
				vim.opt_local.number = false
			end,
		})

		chat.setup(opts)
	end,
}
