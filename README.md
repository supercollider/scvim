SCVim (> 3.5)
==============

A vim plugin for supercollider.

This is based of the original scvim by Alex Norman (see:
<http://www.x37v.info/scvim/>).

Features

* Syntax Highlighting
* A faked REPL via the terminal
* Code Navigation (jump to definitions) via a global tags file "~/.sctags"
* Auto-Completion of known words via tag completion
* Launch the SuperCollider QT Help System


Installation:
------------

It is highly recommended to use pathogen
(<https://github.com/tpope/vim-pathogen>) to keep your .vim paths clean. See the
supplied helpfile how to setup pathogen if you haven't used it before.

Make sure the folder is named 'scvim' and drop it into your "bundle" folder, e.g.
"~/.vim/bundle/scvim".

Or just do:
`
git clone git://github.com/sbl/scvim.git ~/.vim/bundle/scvim
`

Symlink SCVim.sc somewhere, where SuperCollider can find
it. On a **mac** that would be:

`
ln -s ~/.vim/bundle/scvim/sc/SCVim.sc ~/Library/Application\
Support/SuperCollider/Extensions/SCVim.sc
`

And on a common supercollider **debian/ubuntu** installation:

`
ln -s ~/.vim/bundle/scvim/sc/SCVim.sc /usr/share/SuperCollider/Extensions/SCVim.sc`
`

Make sure you are using QT as your main GUI by adding `GUI.qt;` to you
startup.scd file.

The rest should work automatically for **mac** users.

In **Linux** and other unix systems the vim variable `g:sclangTerm` should be
set in your `.vimrc` file to let the plugin know which terminal application
should it use for launching sclang. Please, read on the next section for more
details.

Also, if Ruby is not installed on your linux system, install it with:

`sudo apt-get install ruby` or `sudo yum install ruby`

Plugin configuration:
---------------------

### ENV variables:

Path to the tags file
`export SCVIM_TAGFILE=/your/path` this defaults to "~/.sctags"

### Configurable VIM variables:

The following variables are available for configuration in your `.vimrc` file:

* `g:sclangTerm`: Command to open a terminal window. Defaults to `"open -a
Terminal.app"` on OSX, and `"x-terminal-emulator -e $SHELL -ic"` on Linux. On
some Linux systems this value may need to changed.
* `g:sclangPipeApp`: Absolute path to the plugin **start_pipe** script. Defaults
to `"~/.vim/bundle/scvim/bin/start_pipe"`. Change it if you have installed
the plugin in other location.
* `g:sclangDispatcher`: Absolute path to the plugin **sc_dispatcher** script.
Defaults to `"~/.vim/bundle/scvim/bin/sc_dispatcher"`. Change it if you
have installed the plugin in other location.

Example `.vimrc` line for gnome-terminal users:

    let g:sclangTerm = "gnome-terminal -x $SHELL -ic"

If for some reason vim can't find the path to the two launch scripts
**start_pipe** and **sc_dispatcher** you can set them manually in your .vimrc:

    let g:sclangPipeApp     = "~/.vim/bundle/scvim/bin/start_pipe"
    let g:sclangDispatcher  = "~/.vim/bundle/scvim/bin/sc_dispatcher"

Using it:
--------
To start open a file with the right extension :e foo.sc(d)
Enter `:SClangStart` and a terminal should open with a running sclang session.

See the commands reference for general usage.

_ctags support_:

run `:SCTags` from vim or  `SCVim.generateTagsFile()` from sclang

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

--------------------------------------------------------------------

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program.  If not, see <http://www.gnu.org/licenses/>.
