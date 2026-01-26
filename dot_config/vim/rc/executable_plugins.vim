if !has('nvim')
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif

  call plug#begin($VIMDIR . '/plugged')
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'jeffkreeftmeijer/vim-numbertoggle'
    Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
    Plug 'junegunn/limelight.vim', {'on': 'Limelight'}
    Plug 'junegunn/seoul256.vim'
    Plug 'junegunn/vim-easy-align'
    " Plug 'junegunn/vim-peekaboo'
    Plug 'junegunn/rainbow_parentheses.vim'
    Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
    Plug 'tmhedberg/SimpylFold', {'for': 'python'}
    Plug 'simeji/winresizer'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-speeddating'
    "Plug 'tpope/vim-endwise'
    Plug 'mjbrownie/swapit'
    Plug 'Konfekt/FastFold'
    Plug 'svermeulen/vim-yoink'
    " Plug 'chrisbra/Colorizer'
    "Plug 'jiangmiao/auto-pairs'
    Plug 'glts/vim-magnum' "Required for next
    Plug 'glts/vim-radical'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'wellle/targets.vim'
    Plug 'rhysd/clever-f.vim'
    Plug 'Yggdroot/indentLine'
    Plug 'lambdalisue/suda.vim'
    " Plug 'ActivityWatch/aw-watcher-vim'
    " Tags
    Plug 'ludovicchabant/vim-gutentags'
    "Plug 'majutsushi/tagbar'
    Plug 'liuchengxu/vista.vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'kshenoy/vim-signature'
    Plug 'dhruvasagar/vim-table-mode'
    Plug 'romainl/vim-cool'
    Plug 'andymass/vim-matchup'
    Plug 'dstein64/vim-startuptime'
    Plug 'vitalk/vim-shebang'
    Plug 'freitass/todo.txt-vim'
    Plug 'AndrewRadev/splitjoin.vim'
    " Plug 'TaDaa/vimade'
    " Language specific
    " Plug 'euclidianAce/BetterLua.vim'
    Plug 'baskerville/vim-sxhkdrc'
    " Plug 'shmup/vim-sql-syntax'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'  }
    Plug 'lervag/vimtex'
    " Plug 'vim-python/python-syntax', {'for': 'python'}
    " Plug 'avakhov/vim-yaml', {'for': 'yaml'}
    Plug 'preservim/vim-markdown', {'for': 'markdown'}
    Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
    " Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}
    Plug 'vim-scripts/icalendar.vim'
    Plug 'jeffkreeftmeijer/vim-numbertoggle',
  call plug#end()
endif
