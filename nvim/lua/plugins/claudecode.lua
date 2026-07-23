-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   claudecode.lua                                     :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2026/07/23 12:00:00 by pibouill          #+#    #+#             --
--   Updated: 2026/07/23 12:00:00 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = true,
		keys = {
			{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
			{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude Code session" },
			{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer to Claude" },
			{ "<leader>ab", "<cmd>ClaudeCodeTreeAdd<cr>", desc = "Add file to Claude", ft = { "oil" } },
			{ "<leader>ae", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
			-- Diff review (when Claude proposes an edit, it opens as a diff)
			{ "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff (yes)" },
			{ "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude diff (no)" },
		},
	},
}
			-- Claude Code (native IDE integration):
			--  <leader>ac         : Toggle Claude Code terminal
			--  <leader>ar         : Resume a previous session
			--  <leader>ab         : Add current buffer (or oil file) as context
			--  <leader>ae (visual): Send selection to Claude
			--
			-- Diff review (Claude's proposed edits open as native diffs):
			--  <leader>ay         : Accept the diff
			--  <leader>an         : Deny the diff
			--  (:w in the diff buffer also accepts)
