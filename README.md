# p4.vim

## Description

This is a Vim plugin that provides [P4](https://p4.org/) file detection, syntax highlighting.

The syntax file is from [p4 tutorials](https://github.com/p4lang/tutorials). I only fix some highlighting issues and make it a stand-alone plugin.

## Installation

### [Vim8 packages][vim8pack]

```sh
git clone https://github.com/doraeric/p4.vim.git ~/.vim/pack/plugins/start/p4.vim
```

or neovim

```sh
git clone https://github.com/doraeric/p4.vim.git "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/plugins/start/p4.vim"
```

### [vim-plug][vp]

```vim
Plug 'doraeric/p4.vim'
```

### [packer.nvim][packer]

Note: packer is for neovim only

```lua
use('doraeric/p4.vim')
```

### [dein.vim][d]

```vim
call dein#add('doraeric/p4.vim')
```

[vim8pack]: http://vimhelp.appspot.com/repeat.txt.html#packages
[vp]: https://github.com/junegunn/vim-plug
[d]: https://github.com/Shougo/dein.vim
[packer]: https://github.com/wbthomason/packer.nvim
