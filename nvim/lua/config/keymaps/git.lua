---@desc Git and version control keymaps

-- LazyGit
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
vim.keymap.set("n", "<leader>gG", "<cmd>LazyGitConfig<cr>", { desc = "LazyGit config" })
vim.keymap.set("n", "<leader>gc", "<cmd>LazyGit<cr> %:p:h", { desc = "LazyGit current file" })

-- Diffview
vim.keymap.set("n", "<leader>gdo", "<cmd>DiffviewOpen<cr>", { desc = "Diffview open" })
vim.keymap.set("n", "<leader>gdc", "<cmd>DiffviewClose<cr>", { desc = "Diffview close" })
vim.keymap.set("n", "<leader>gdh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview file history" })
vim.keymap.set("n", "<leader>gdH", "<cmd>DiffviewFileHistory<cr>", { desc = "Diffview branch history" })
vim.keymap.set("n", "<leader>gdr", "<cmd>DiffviewRefresh<cr>", { desc = "Diffview refresh" })

-- Grug-far (search and replace)
vim.keymap.set("n", "<leader>sr", "<cmd>GrugFar<cr>", { desc = "Search and replace" })
vim.keymap.set("n", "<leader>sw", function()
  require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "Search word under cursor" })
vim.keymap.set("v", "<leader>sr", function()
  require("grug-far").with_visual_selection()
end, { desc = "Search selection" })

-- Gitsigns (conditional loading)
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyLoad",
  callback = function(event)
    if event.data == "gitsigns.nvim" then
      local gs = package.loaded["gitsigns"]
      if not gs then
        return
      end

      -- Hunk navigation
      vim.keymap.set("n", "]h", function()
        if vim.wo.diff then
          return "]h"
        end
        vim.schedule(function()
          gs.nav_hunk("next")
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Next hunk" })

      vim.keymap.set("n", "[h", function()
        if vim.wo.diff then
          return "[h"
        end
        vim.schedule(function()
          gs.nav_hunk("prev")
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Prev hunk" })

      -- Hunk actions
      vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
      vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
      vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
      vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
      vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
      vim.keymap.set("n", "<leader>hp", gs.preview_hunk_inline, { desc = "Preview hunk inline" })
      vim.keymap.set("n", "<leader>hP", gs.preview_hunk, { desc = "Preview hunk" })
      vim.keymap.set("n", "<leader>hb", gs.blame_line, { desc = "Blame line" })
      vim.keymap.set("n", "<leader>hB", function()
        gs.blame_line({ full = true })
      end, { desc = "Blame line (full)" })
      vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
      vim.keymap.set("n", "<leader>hD", function()
        gs.diffthis("~")
      end, { desc = "Diff against last commit" })
      vim.keymap.set("n", "<leader>hQ", gs.setqflist, { desc = "Set quickfix" })
      vim.keymap.set("n", "<leader>hq", function()
        gssetqflist("all")
      end, { desc = "Set quickfix (all)" })

      -- Visual mode
      vim.keymap.set("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Stage hunk" })
      vim.keymap.set("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Reset hunk" })

      -- Text object
      vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Inside hunk" })
    end
  end,
})
