SCVim 
=====

This is based of the original scvim by Alex Norman (see:
<http://www.x37v.info/scvim/>). 
It uses a different mechanism to launch sc (a ruby script). The helpfile aren't
generated with a help script put pulled directly from sc helpfiles themselves. 

It is highly recommended to use pathogen
(<https://github.com/tpope/vim-pathogen>) to keep your .vim paths clean. See the
supplied helpfile how to setup pathogen if you haven't used it before. 

A word of warning: 

So far this only really works with the combination of macvim 

Installation:
------------

Drop the whole scvim folder into your "bundle" folder, e.g.
"~/.vim/bundle/scvim" Symlink SCVim.sc somewhere, where SuperCollider can find
it. On a mac that would be 

`
ln -s ~/.vim/bundle/supercollider/sc/SCVim.sc ~/Library/Application\
Support/SuperCollider/Extensions/SCVim.sc
`

The rest should hopefully work automatically. Edit plugin/supercollider.vim to
taste. Or override corresponding function in your ~/.vimrc.

Using it:
--------
To start open a file with the right extension :e foo.sc(d)
Enter `:SClangStart` and a terminal should open with a running sclang session. 

Key commands:
------------

in normal/insert mode:

`
* F5 to execute a block of code scvim will attempt to find the outermost bracket
* F6 to execute the current line of code
* F12 to 
`
in normal mode:



Known issues / shouldas:
------------------------

* In general things should be easier to customize
* set the settings for the sc:pipe script from vim
* Things are mac-centric right now (e.g. helpfiles are opened in mvim, it
  assumes we are using the mac terminal ...)
* This uses non-standard key commands so far (make it easier to change that)
* Reworked the syntax highlighting - it is put in syntax file right now,
  so added classes won't be found
* probably a lot more

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
