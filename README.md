SCVim (> 3.5)
==============

A vim plugin for supercollider (tested on Linux and Mac OSX).

This is based of the original [scvim by Alex Norman](http://www.x37v.info/scvim/).

Features
--------

* Syntax Highlighting
* A faked REPL via the terminal
* Code Navigation (jump to definitions) via a global tags file "~/.sctags"
* Auto-Completion of known words via tag completion
* Launch the SuperCollider QT Help System

Requirements
------------

* ruby
* supercollider >= 3.9 (for current **master** - [Linux only](https://github.com/supercollider/scvim/issues/27))

Installation
------------

### `scvim` plugin installation

It is highly recommended to use a plugin manager to install `scvim`. Most common ones are:

* [pathogen](https://github.com/tpope/vim-pathogen)
* [vundle](https://github.com/VundleVim/Vundle.vim)
* [vim-plug](https://github.com/junegunn/vim-plug)

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

* `g:sclangTerm`: Command to open a terminal window. Defaults to `"open -a
Terminal.app"` on OSX, and `"x-terminal-emulator -e $SHELL -ic"` on Linux.
On some Linux systems this value may need to changed.
* `g:sclangPipeApp`: Absolute path to the plugin **start_pipe** script. Defaults
to `"~/.vim/bundle/scvim/bin/start_pipe"`.
Change it if you have installed the plugin in other location.
* `g:sclangDispatcher`: Absolute path to the plugin **sc_dispatcher** script.
Defaults to `"~/.vim/bundle/scvim/bin/sc_dispatcher"`.
Change it if you have installed the plugin in other location.
* `g:scFlash`: Highlighting of evaluated code

Example `.vimrc` line for gnome-terminal users:

    let g:sclangTerm = "gnome-terminal -x $SHELL -ic"

To enable highlighting of evaluated code:

    let g:scFlash = 1

If for some reason vim can't find the path to the two launch scripts
**start_pipe** and **sc_dispatcher** you can set them manually in your .vimrc:

    let g:sclangPipeApp     = "~/.vim/bundle/scvim/bin/start_pipe"
    let g:sclangDispatcher  = "~/.vim/bundle/scvim/bin/sc_dispatcher"

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
