SCVim (> 3.5)
==============

A vim plugin for supercollider (tested on Linux and Mac OSX).

This is based of the original [scvim by Alex Norman](https://www.x37v.info/projects/scvim/).

Features
--------

* Syntax Highlighting
* A faked REPL via the terminal
* Code Navigation (jump to definitions) via a global tags file "~/.sctags"
* Auto-Completion of known words via tag completion
* Launch the SuperCollider QT Help System
* `tmux` and `screen` support

Requirements
------------

* ruby
* supercollider

Installation
------------

### `go-sclang` installation

Follow [go-sclang installation instructions](https://github.com/WnP/go-sclang#install).

Remember that `go-sclang` **and** `go-sclang-client` are required.

### `scvim` plugin installation

It is highly recommended to use either Vim 8+'s native `packages` or a plugin
manager to install `scvim`.

The most common package manager addons are:

* [pathogen](https://github.com/tpope/vim-pathogen)
* [vundle](https://github.com/VundleVim/Vundle.vim)
* [vim-plug](https://github.com/junegunn/vim-plug)
* [vim-addon-manager](https://github.com/MarcWeber/vim-addon-manager)

To find help about vim's native `packages`, in vim, type `:help packages`

The plugin folder is expected to be found in `~/.vim/pack/*/*/scvim`
or somewhere below `~/.vim`, at a maximum depth of two folders and with the
word `scvim` in it (which should in theory cover all use-cases for the above
plugin managers).

#### Using Vim's native package management

To automatically enable scvim when you use vim.
Assuming that your vim `pack` package directory is called *my*

Execute:
```
mkdir -p ~/.vim/pack/my/start/
git clone https://github.com/supercollider/scvim.git ~/.vim/pack/my/start/scvim
```

If you would like to only enable scvim when you first start editing a
SuperCollider file.
Assuming that your vim `pack` package directory is called *my*

Execute:
```
mkdir -p ~/.vim/pack/my/opt/
git clone https://github.com/supercollider/scvim.git ~/.vim/pack/my/opt/scvim
```

Then, add the following to your `~/.vimrc`

```
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd set filetype=supercollider
au Filetype supercollider packadd scvim
```

### `SCVim.sc`

If your SuperCollider version was not build with vim support (i.e. the class
`SCVim` does not exist yet), you'll need to either symlink `sc/SCVim.sc`
somewhere where SuperCollider can find it (typically that would be in
`Platform.userExtensionDir` from within SuperCollider), or add (the absolute
path to) `scvim/sc` to `includePaths:` in your `sclang_conf.yaml`.

Configuration
-------------

### ENV variables:

Path to the tags file
`export SCVIM_TAGFILE=/your/path` this defaults to `~/.sctags`

### Configurable VIM variables:

The following variables are available for configuration in your `.vimrc` file:

| Variable                  | Description                                                      | Default                                                                                |
| --------                  | -----------                                                      | -------                                                                                |
| `g:sclangTerm`            | Command to open a terminal window                                | `"open -a Terminal.app"` on macOS,<br />`"x-terminal-emulator -e $SHELL -ic"` on Linux |
| `g:sclangServer`          | Absolute path to **go-sclang** binary                            | `"go-sclang"` - should be in your $PATH                                                |
| `g:goSclangServerOptions` | Options for to **go-sclang** binary                              | `""`                                                                                   |
| `g:sclangClient`          | Absolute path to **go-sclang-client** binary                     | `"go-sclang-client"` - should bin in your $PATH                                        |
| `g:scFlash`               | Highlighting of evaluated code                                   | `0`                                                                                    |
| `g:scSplitDirection`      | Default window orientation when using a terminal multiplexer     | `"h"`                                                                                  |
| `g:scSplitSize`           | Post window size (% of screen) when using a terminal multiplexer | `50`                                                                                   |
| `g:scTerminalBuffer`      | If set to `"on"` use vim's `:term` to launch `g:sclangTerm`      | `"off"`                                                                                |
| `g:scPrintToMiniBuffer`   | Print sclang returned value to vim mini buffer                   | `1`                                                                                    |

Example `.vimrc` line for gnome-terminal users:

    let g:sclangTerm = "gnome-terminal -x $SHELL -ic"

To enable highlighting of evaluated code:

    let g:scFlash = 1

Usage
-----
To start open a file with the right extension :e foo.sc(d)
Enter `:SClangStart` and a terminal should open with a running sclang session.

See the commands reference for general usage.

_ctags support_:

run `:SCtags` from vim or `SCVim.generateTagsFile()` from sclang

This gives you a couple of things:

* You can jump to any known class or method
* You get tags completion with ctrl-x ctrl-] (use the vim supertab plugin if this is too
  bothersome to type)

### Commands:

* `:SClangStart` launch sclang
* `:SClangRecompile` recompile
* `:SClangKill` what it says

### Key commands:

in normal mode:

* `<leader>sk` recompiles the sc library
* `K` on a word opens the corresponding helpfile inside the supercollider help
* `^]` jumps to a tagfile (this works for classes only so far but will be
  extended)

in normal/insert mode:

* `F5` to execute a block of code scvim will attempt to find the outermost bracket
* `F6` to execute the current line of code
* `F12` is a hard stop

Terminal Multiplexer Options
----------------------------

Supported Terminal Multiplexers are `tmux` and `screen`. To use with scvim, open
the multiplexer before opening vim.
For example:

`$> tmux new -s sc`
`$> vim mySCfile.scd`

Default settings for window orienation and window size can be set in your `.vimrc`.

Window orientation options are `"h"` for horizontal and `"v"` for vertical (double
quotes are required).

The window size option for tmux is the percentage of the screen you want the post
window to take up. For example, to have your main window taking up 70% of the left
of the screen and your post window the remaining 30% at the right:

    let g:scSplitDirection = "h"
    let g:scSplitSize = 30`

### Changing Multiplexor Options on SClangStart:

Options for the multiplexer of your choice can be set on the fly when you use the
SClangStart command:

`:call SClangStart("h", 30)`
