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
				tools = {
					gemini = {
						cmd = { "gemini", "--model", "gemini-2.0-pro" },
					},
				},
				---@type table<string, sidekick.context.Fn>
				context = {
					file = function(ctx)
						local Loc = require("sidekick.cli.context.location")
						if not Loc.is_file(ctx.buf) then return end
						local lines = vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)
						local loc = Loc.get(ctx, { kind = "file" })[1]
						if not loc then return end
						local ret = { loc, { { "" } } }
						for _, line in ipairs(lines) do
							ret[#ret + 1] = { { line } }
						end
						return ret
					end,
					buffers = function(ctx)
						local Loc = require("sidekick.cli.context.location")
						local ret = {}
						for _, buf in ipairs(vim.api.nvim_list_bufs()) do
							if Loc.is_file(buf) then
								local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
								local loc = Loc.get({ buf = buf, cwd = ctx.cwd }, { kind = "file" })[1]
								if not loc then goto continue end
								if #ret > 0 then ret[#ret + 1] = { { "" } } end
								ret[#ret + 1] = loc
								ret[#ret + 1] = { { "" } }
								for _, line in ipairs(lines) do
									ret[#ret + 1] = { { line } }
								end
							end
							::continue::
						end
						return ret
					end,
					selection = function(ctx)
						if not ctx.range then return end
						local Loc = require("sidekick.cli.context.location")
						local from_l = tonumber(ctx.range.from[1]) ---@type integer?
						local from_c = tonumber(ctx.range.from[2]) ---@type integer?
						local to_l = tonumber(ctx.range.to[1]) ---@type integer?
						local to_c = tonumber(ctx.range.to[2]) ---@type integer?
						if not (from_l and from_c and to_l and to_c) then return end

						local sel_ctx = {
							buf = ctx.buf,
							cwd = ctx.cwd,
							range = {
								kind = ctx.range.kind,
								from = { from_l, from_c },
								to = { to_l, to_c },
							},
						}

						---@diagnostic disable-next-line: assign-type-mismatch
						local loc_sel = Loc.get(sel_ctx, { kind = "selection" })[1]
						local loc_file = Loc.get({ buf = ctx.buf, cwd = ctx.cwd }, { kind = "file" })[1]
						local loc = loc_sel or loc_file
						local lines = vim.api.nvim_buf_get_lines(ctx.buf, from_l - 1, to_l, false)
						if ctx.range.kind == "char" then
							if #lines > 0 then
								lines[#lines] = string.sub(lines[#lines], 1, to_c + 1)
								lines[1] = string.sub(lines[1], from_c + 1)
							end
						end
						local ret = {}
						if loc then
							ret[#ret + 1] = loc
							ret[#ret + 1] = { { "" } }
						end
						for _, line in ipairs(lines) do
							ret[#ret + 1] = { { line } }
						end
						return ret
					end,
				},
			},
		},
		config = function(_, opts)
			require("sidekick").setup(opts)
		end,
		keys = {
			-- Sidekick CLI Sessions:
			--  <leader>aa : Toggle CLI (Gemini, Cursor, etc.)
			--  <leader>as         : Select an installed CLI tool
			--  <leader>ad         : Detach/Close the current session
			--  <leader>ap         : Select a prompt (Explain, Optimize, etc.)
			--  <leader>ac         : Toggle Claude directly
			--
			-- Context Sending:
			--  <leader>at         : Send "This" (current cursor/function context)
			--  <leader>af         : Send current File content
			--  <leader>av (visual): Send Visual selection
			--
			-- Next Edit Suggestions (NES):
			--  <tab>              : Jump to or Apply the suggestion
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
				function()
					require("sidekick.cli").select({ filter = { installed = true } })
				end,
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
