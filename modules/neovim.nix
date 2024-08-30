{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorschemes.gruvbox.enable = true;
    extraPlugins = [ pkgs.vimPlugins.todo-txt-vim ];
    plugins = {
      oil.enable = true;
      neogit.enable = true;
      lsp = {
        enable = true;
        servers = {
          tsserver.enable = true; # TS/JS
          pyright.enable = true; # Python
          biome.enable = true; # TS/JS
          ruff.enable = true;
        };
        keymaps.lspBuf = {
          gd = { action = "definition"; desc = "Goto Definition"; };
          gr = { action = "references"; desc = "Goto References"; };
          gD = { action = "declaration"; desc = "Goto Declaration"; };
          gI = { action = "implementation"; desc = "Goto Implementation"; };
          gT = { action = "type_definition"; desc = "Type Definition"; };
          K = { action = "hover"; desc = "Hover"; };
          "<leader>rn" = { action = "rename"; desc = "Rename"; };
        };
        keymaps.extra = [
          { action.__raw = "vim.lsp.buf.code_action"; key = "<leader>la"; }
          { action.__raw = "function() vim.lsp.buf.format { async = true } end"; key = "<leader>lf"; }
        ];
        keymaps.diagnostic = {
          "<leader>cd" = {
            action = "open_float";
            desc = "Line Diagnostics";
          };
          "[d" = {
            action = "goto_next";
            desc = "Next Diagnostic";
          };
          "]d" = {
            action = "goto_prev";
            desc = "Previous Diagnostic";
          };
        };
      };
      trouble.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "nvim_lua"; }
            { name = "emoji"; }
            { name = "emoji"; }
            { name = "buffer"; option.get_bufnrs.__raw = "vim.api.nvim_list_bufs"; keywordLength = 3; }
            { name = "path"; keywordLength = 3; }
            { name = "luasnip"; keywordLength = 3; }
          ];
          window = {
            # completion = { border = "solid"; };
            # documentation = { border = "solid"; };
          };
          mapping = {
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-e>" = "cmp.mapping.abort()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
          };
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lua.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;
      cmp-cmdline.enable = true;
      nvim-tree = {
        enable = true;
        view.side = "right";
        updateFocusedFile.enable = true;
      };

      luasnip.enable = true;

      bufferline.enable = true;

      treesitter = {
        enable = true;
        folding = true;
        settings = {
          ensure_installed = "all";
          highlight.enable = true;
          indent.enable = true;
        };
      };
      treesitter-context.enable = true;
      treesitter-textobjects.enable = true;
      ts-autotag.enable = true;

      which-key.enable = true;
      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
        settings = {
          defaults = {
            mappings = {
              i = { "<C-t>".__raw = "require('trouble.sources.telescope').open"; };
              n = { "<C-t>".__raw = "require('trouble.sources.telescope').open"; };
            };
          };
        };
      };


      project-nvim = {
        enable = true;
        enableTelescope = true;
      };

    };
    opts = {
      number = true;
      relativenumber = true;
      signcolumn = "yes";
      updatetime = 250;
      undofile = true;
      ignorecase = true;
      smartcase = true;
      swapfile = false;
      foldlevel = 9;
      smartindent = true;
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 0;
      expandtab = true;
      smarttab = true;
      scrolloff = 5;
      termguicolors = true;
    };
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    keymaps = [
      { action = ":"; key = ";"; mode = [ "n" ]; }
      { action = "gj"; key = "j"; mode = [ "n" ]; }
      { action = "gk"; key = "k"; mode = [ "n" ]; }
      { action = "<Esc>"; key = "jk"; mode = [ "i" ]; }

      { action = "<cmd>Telescope find_files<CR>"; key = "<leader><leader>"; options.desc = "Find Files"; }
      { action = "<cmd>Telescope live_grep<CR>"; key = "<leader>fg"; options.desc = "Grep";}
      { action = "<cmd>Telescope buffers<CR>"; key = "<leader>fb"; options.desc = "Find Buffers";}
      { action = "<cmd>Telescope projects<CR>"; key = "<leader>pp"; options.desc = "Switch Projects";}

      { action = "<cmd>Trouble diagnostics toggle<CR>"; key = "<leader>tr"; }
      { action = "<cmd>Neogit<CR>"; key = "<leader>gg"; options.desc = "Open Git"; }
      { action = "<cmd>NvimTreeToggle<CR>"; key = "<leader>tt"; options.desc = "Tree View";}
    ];
  };
}
