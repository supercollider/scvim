SCVim (3.5 QT)
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
* SnipMate integration

**UPGRADE NOTICE**

If you have been using this plugin before check the keycommand deprecation
notice and get used to the new commands which are more in line with vim
standards.

**A word of warning**: 

It has been tested on a mac with MacVIM and vim via Terminal.app. If you
refrain from using the deprecated (see below) commands this should work on a
linux machine with minor modifications as well.

Installation:
------------

It is highly recommended to use pathogen
(<https://github.com/tpope/vim-pathogen>) to keep your .vim paths clean. See the
supplied helpfile how to setup pathogen if you haven't used it before. 

Rename the whole scvim folder to "supercollider" and drop it into your "bundle" folder, e.g.
"~/.vim/bundle/supercollider". 

Or just do:
`
git clone git://github.com/sbl/scvim.git ~/.vim/bundle/supercollider
`

Symlink SCVim.sc somewhere, where SuperCollider can find
it. On a mac that would be 

`
ln -s ~/.vim/bundle/supercollider/sc/SCVim.sc ~/Library/Application\
Support/SuperCollider/Extensions/SCVim.sc
`

The rest should hopefully work automatically (that is if you have SuperCollider
installed in the default directory `/Applications/SuperCollider.app`).  Edit
plugin/supercollider.vim to taste. Or override corresponding function in your
~/.vimrc.

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

Commands:
--------

* `:SClangStart` launch sclang
* `:SClangRecompile` recompile
* `:SClangKill` what it says

Key commands:
------------

in insert mode

* `<C-Tab>` shows the method args for the current method (if found)

in normal mode:

* `<leader>sk` recompiles the sc library
* `K` on a word opens the corresponding helpfile inside the supercollider help
* `^]` jumps to a tagfile (this works for classes only so far but will be
  extended)

in normal/insert mode:

* `F5` to execute a block of code scvim will attempt to find the outermost bracket
* `F6` to execute the current line of code
* `F12` is a hard stop

The following are _DEPRECATED_ (they only work with macvim anyways) and will
be removed with the next revision. Use the tags file for a general workflow.

* `<leader>sj` on a word opens the class file
* `<leader>si` on a word opens the implementations of ...
* `<leader>sr` on a word opens the references to ...
* `<leader>sd` on a word opens the corresponding helpfile inside the
  supercollider help

Variables:
----------

ENV variables:

Path to the tags file
`export SCVIM_TAGFILE=/your/path` this defaults to "~/.sctags"

If for some reason vim can't find the path to the two launch scripts
`start_pipe` and `sc_dispatcher` you can set them manually in your .vimrc

e.g.:

`let g:sclangPipeApp     = "~/.vim/bundle/supercollider/bin/start_pipe"`
`let g:sclangDispatcher  = "~/.vim/bundle/supercollider/bin/sc_dispatcher"`

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