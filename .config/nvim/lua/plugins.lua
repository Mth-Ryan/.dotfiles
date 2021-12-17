local plugins = {}

plugins.get_packer = function()
    local fn = vim.fn
    local install_path = 
        fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        packer_bootstrap = fn.system({
            'git', 'clone', '--depth', '1',
            'https://github.com/wbthomason/packer.nvim',
            install_path
        })
    end
end

plugins.setup = function()
    require('packer').startup(function() 
        -- Visual
        use 'Mth-Ryan/yat'  -- colors
        use 'norcalli/nvim-colorizer.lua'
        use { 
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate'
        }
        use 'lukas-reineke/indent-blankline.nvim'
        use {
            'glepnir/galaxyline.nvim',
            branch = 'main'
        }
        use {
            'akinsho/nvim-bufferline.lua',
            requires = {'kyazdani42/nvim-web-devicons'}
        }

        -- Utility
        use 'windwp/nvim-autopairs'
        use 'neovim/nvim-lspconfig'
        use {
            'RishabhRD/nvim-lsputils',
            requires = { 'RishabhRD/popfix' }
        }
        use 'nvim-lua/popup.nvim'
        use 'numtostr/FTerm.nvim'
        use {
            'kyazdani42/nvim-tree.lua',
            requires = {'kyazdani42/nvim-web-devicons'}
        }
        use {
            'nvim-telescope/telescope.nvim',
            requires = { 
                'nvim-lua/plenary.nvim',
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    run = 'make'
                }
            }
        }
        use { 
            'gelguy/wilder.nvim',
            run = ':UpdateRemotePlugins'
        }
        use {
            'ms-jpq/coq_nvim',
            branch = 'coq',
            run    = ':COQdeps'
        }

        -- Languages
        use 'fatih/vim-go'
        use 'rust-lang/rust.vim'
        use 'elixir-editors/vim-elixir'
        use {
            'ionide/Ionide-vim', 
            run = 'make fsautocomplete'
        }
    end)
end

return plugins
