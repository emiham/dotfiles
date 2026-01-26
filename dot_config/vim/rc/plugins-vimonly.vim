call plug#begin($VIMDIR . '/plugged')
  " NOTE There is no guarantee that this is up to date with nvim
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug "junegunn/goyo.vim", {"on": "Goyo"},
  Plug "junegunn/vim-peekaboo",
  Plug "junegunn/limelight.vim", {"on": "Limelight"},
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-commentary'
  Plug 'ludovicchabant/vim-gutentags',
  Plug 'majutsushi/tagbar',
  Plug 'liuchengxu/vista.vim',
  Plug 'junegunn/rainbow_parentheses.vim',
  Plug "Konfekt/FastFold",
  Plug "tpope/vim-surround",
  Plug "tpope/vim-sleuth",
  Plug "tmhedberg/SimpylFold", {"for": "python"},
  Plug "chrisbra/Colorizer",
  Plug "mjbrownie/swapit",
  Plug "tpope/vim-speeddating",
  Plug "michaeljsmith/vim-indent-object",
  " Breaks ciw in vimrc
  Plug "wellle/targets.vim",
  Plug "vitalk/vim-shebang",
  Plug "AndrewRadev/splitjoin.vim",
  Plug "euclidianAce/BetterLua.vim",
  Plug "Vimjas/vim-python-pep8-indent",
  "Plug "fatih/vim-go", { "do": ":GoUpdateBinaries"  },
  "Plug "vim-python/python-syntax", {"for": "python"},
  "Plug "avakhov/vim-yaml", {"for": "yaml"},
  "Plug "preservim/vim-markdown", {"for": "markdown"},
  "Plug "neovimhaskell/haskell-vim", {"for": "haskell"},
call plug#end()
