-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   markdown-preview.lua                               :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/06 09:50:01 by pibouill          #+#    #+#             --
--   Updated: 2024/12/06 09:52:43 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
}
