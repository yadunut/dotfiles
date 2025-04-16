{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  home.packages = [
    pkgs.nodejs_23
  ];
  programs.nixvim = {
    nixpkgs.pkgs = pkgs;
    performance.combinePlugins.enable = false;

    performance.byteCompileLua.enable = false;
    performance.byteCompileLua.nvimRuntime = true;
    performance.byteCompileLua.plugins = true;

    enable = true;
    defaultEditor = true;
    colorschemes.gruvbox.enable = true;
    extraPlugins = [pkgs.vimPlugins.todo-txt-vim];
    plugins = {
      flash.enable = true;
      oil.enable = true;
      neogit.enable = true;
      hardtime.enable = false;
      image = {
        enable = true;
        settings = {
          backend = "kitty";
        };
      };

      none-ls = {
        enable = true;
        sources.formatting.ocamlformat.enable = true;
      };
      lsp = {
        # package = pkgs.vimUtils.buildVimPlugin {
        #   name = "lsp";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "neovim";
        #     repo = "nvim-lspconfig";
        #     rev = "541f3a2781de481bb84883889e4d9f0904250a56";
        #     hash = "sha256-f9CqwKBWZgC2ystm+g7FmsHR0fLcM6Wj+GkSwoUIanw=";
        #   };
        # };
        enable = true;
        servers = {
          gleam.enable = true;
          ts_ls.enable = true; # TS/JS
          biome.enable = true; # TS/JS

          pyright.enable = true; # Python
          ruff.enable = true; # python

          nil_ls.enable = true; # nix
          rust_analyzer.enable = true;
          rust_analyzer.installCargo = false;
          rust_analyzer.installRustc = false;

          cssls.enable = true;
          jsonls.enable = true;
          html.enable = true;
          denols.enable = true;
          denols.autostart = false;
          gopls.enable = true;

          ziggy = {
            enable = false;
            package = inputs.ziggy.outputs.packages.aarch64-darwin.ziggy;
          };
          ziggy_schema = {
            enable = false;
            package = inputs.ziggy.outputs.packages.aarch64-darwin.ziggy;
          };
          zls= {
            package = null;
            enable = true;
          };

          superhtml = {
            enable = true;
            package = inputs.superhtml.outputs.packages.aarch64-darwin.superhtml;
          };
          ocamllsp = {
            enable = true;
            package = null;
          };

        };
        keymaps.lspBuf = {
          gd = {
            action = "definition";
            desc = "Goto Definition";
          };
          gr = {
            action = "references";
            desc = "Goto References";
          };
          gD = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          gI = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          gT = {
            action = "type_definition";
            desc = "Type Definition";
          };
          K = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>rn" = {
            action = "rename";
            desc = "Rename";
          };
        };
        keymaps.extra = [
          {
            action.__raw = "vim.lsp.buf.code_action";
            key = "<leader>la";
          }
          {
            action.__raw = "function() vim.lsp.buf.format { async = true } end";
            key = "<leader>lf";
          }
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
            {name = "nvim_lsp";}
            {name = "nvim_lua";}
            # {name = "emoji";}
            {
              name = "buffer";
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              keywordLength = 3;
            }
            {
              name = "path";
              keywordLength = 3;
            }
            {
              name = "luasnip";
              keywordLength = 3;
            }
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

      friendly-snippets.enable = true;

      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
        };
        fromVscode = [
          {
            lazyLoad = true;
            paths = "${pkgs.vimPlugins.friendly-snippets}";
          }
        ];
      };

      bufferline.enable = true;

      treesitter = {
        enable = true;
        folding = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          json
          lua
          make
          markdown
          nix
          regex
          toml
          vim
          vimdoc
          xml
          yaml
          javascript
          go
          typescript
        ];
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
      treesitter-context.enable = true;
      treesitter-textobjects = {
        enable = true;
        move = {
          enable = true;
          gotoNextStart = {
            "]m" = {query = "@function.outer";};
            "]]" = {
              query = "@class.outer";
              desc = "Next class start";
            };
            "]o" = {query = "@loop.*";};
            "]s" = {
              query = "@scope";
              queryGroup = "locals";
              desc = "Next scope";
            };
            "]z" = {
              query = "@fold";
              queryGroup = "folds";
              desc = "Next fold";
            };
          };
          gotoNextEnd = {
            "]M" = {query = "@function.outer";};
            "][" = {query = "@class.outer";};
          };
          gotoPreviousStart = {
            "[m" = {query = "@function.outer";};
            "[[" = {query = "@class.outer";};
          };
          gotoPreviousEnd = {
            "[M" = {query = "@function.outer";};
            "[]" = {query = "@class.outer";};
          };
          gotoNext = {
            "]d" = {query = "@conditional.outer";};
          };
          gotoPrevious = {
            "[d" = {query = "@conditional.outer";};
          };
        };
      };
      ts-autotag.enable = true;

      which-key.enable = true;
      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
        settings = {
          defaults = {
            mappings = {
              i = {"<C-t>".__raw = "require('trouble.sources.telescope').open";};
              n = {"<C-t>".__raw = "require('trouble.sources.telescope').open";};
            };
          };
        };
      };

      project-nvim = {
        enable = true;
        enableTelescope = true;
      };
      web-devicons.enable = true;

      lean = {
        enable = true;
      };
      copilot-vim.enable = true;
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
      foldmethod = lib.mkForce "expr";
      foldexpr = lib.mkForce "v:lua.vim.treesitter.foldexpr()";
    };
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    keymaps = [
      {
        action = ":";
        key = ";";
        mode = ["n"];
      }
      # { action = "gj"; key = "j"; mode = [ "n" ]; }
      # { action = "gk"; key = "k"; mode = [ "n" ]; }
      {
        action = "<Esc>";
        key = "jk";
        mode = ["i"];
      }

      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader><leader>";
        options.desc = "Find Files";
      }
      {
        action.__raw = "function() require('telescope.builtin').lsp_document_symbols({symbols='method'}) end";
        key = "<leader>fm";
        options.desc = "Find Methods";
      }
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>fg";
        options.desc = "Grep";
      }
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader>fb";
        options.desc = "Find Buffers";
      }
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader>fb";
        options.desc = "Find Buffers";
      }
      {
        action = "<cmd>Telescope projects<CR>";
        key = "<leader>pp";
        options.desc = "Switch Projects";
      }

      {
        action = "<cmd>Trouble diagnostics toggle<CR>";
        key = "<leader>tr";
      }
      {
        action = "<cmd>Neogit<CR>";
        key = "<leader>gg";
        options.desc = "Open Git";
      }
      {
        action = "<cmd>NvimTreeToggle<CR>";
        key = "<leader>tt";
        options.desc = "Tree View";
      }

      {
        action.__raw = "function() require('flash').jump() end";
        key = "s";
        mode = ["n" "x" "o"];
        options.desc = "Flash";
      }
      {
        action.__raw = "function() require('flash').treesitter() end";
        key = "S";
        mode = ["n" "x" "o"];
        options.desc = "Flash Treesitter";
      }
      {
        action.__raw = "function() require('flash').remote() end";
        key = "r";
        mode = ["o"];
        options.desc = "Remote Flash";
      }
      {
        action.__raw = "function() require('flash').treesitter_search() end";
        key = "R";
        mode = ["o"];
        options.desc = "Treesitter Search";
      }
      {
        action.__raw = "function() require('flash').toggle() end";
        key = "<c-s>";
        mode = ["c"];
        options.desc = "Toggle Flash";
      }
    ];

    extraConfigLua = ''
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('ziggy', {}),
        pattern = 'ziggy',
        callback = function()
          vim.lsp.start {
            name = 'Ziggy LSP',
            cmd = { 'ziggy', 'lsp' },
            root_dir = vim.loop.cwd(),
            flags = { exit_timeout = 1000 },
          }
        end,
      })

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('ziggy_schema', {}),
        pattern = 'ziggy_schema',
        callback = function()
          vim.lsp.start {
            name = 'Ziggy LSP',
            cmd = { 'ziggy', 'lsp', '--schema' },
            root_dir = vim.loop.cwd(),
            flags = { exit_timeout = 1000 },
          }
        end,
      })

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('superhtml', {}),
        pattern = 'superhtml',
        callback = function()
          vim.lsp.start {
            name = 'SuperHTML LSP',
            cmd = { 'superhtml', 'lsp' },
            root_dir = vim.loop.cwd(),
            flags = { exit_timeout = 1000 },
          }
        end,
      })
      local parser_config = require(
        'nvim-treesitter.parsers'
      ).get_parser_configs()
      parser_config.ziggy = {
        install_info = {
          url = 'https://github.com/kristoff-it/ziggy',
          includes = { 'tree-sitter-ziggy/src' },
          files = { 'tree-sitter-ziggy/src/parser.c' },
          branch = 'main',
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = 'ziggy',
      }

      parser_config.ziggy_schema = {
        install_info = {
          url = 'https://github.com/kristoff-it/ziggy',
          files = { 'tree-sitter-ziggy-schema/src/parser.c' },
          branch = 'main',
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = 'ziggy-schema',
      }

      parser_config.supermd = {
        install_info = {
          url = 'https://github.com/kristoff-it/supermd',
          includes = { 'tree-sitter/supermd/src' },
          files = {
            'tree-sitter/supermd/src/parser.c',
            'tree-sitter/supermd/src/scanner.c'
          },
          branch = 'main',
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = 'supermd',
      }

      parser_config.supermd_inline = {
        install_info = {
          url = 'https://github.com/kristoff-it/supermd',
          includes = { 'tree-sitter/supermd-inline/src' },
          files = {
            'tree-sitter/supermd-inline/src/parser.c',
            'tree-sitter/supermd-inline/src/scanner.c'
          },
          branch = 'main',
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = 'supermd_inline',
      }

      parser_config.superhtml = {
        install_info = {
          url = 'https://github.com/kristoff-it/superhtml',
          includes = { 'tree-sitter-superhtml/src' },
          files = {
            'tree-sitter-superhtml/src/parser.c',
            'tree-sitter-superhtml/src/scanner.c'
          },
          branch = 'main',
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = 'superhtml',
      }

      vim.filetype.add {
        extension = {
          smd = 'supermd',
          shtml = 'superhtml',
          ziggy = 'ziggy',
          ['ziggy-schema'] = 'ziggy_schema',
        },
      }
    '';
  };
}
