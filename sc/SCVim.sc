// Copyright 2007 Alex Norman
// with modifications 2008 Dan Stowell
// rewritten 2010 Stephen Lumenta
// most of the code here comes from the supercollider.tmbundle by rfwatson
// https://github.com/rfwatson/supercollider-tmbundle
//
// This file is part of SCVIM.
//
// SCVIM is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// SCVIM is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with SCVIM.  If not, see <http://www.gnu.org/licenses/>.

/*

SCVim.methodReferences("replace");
SCVim.methodTemplates("replace");
*/

SCVim {
	classvar nodes, <>vimPath;

	*initClass {
		nodes = List[];    

		// TODO this has to be not so mac-centric
		Platform.case(\osx) {

			var whichVim = "which mvim".unixCmdGetStdOut;
			if(whichVim.isEmpty){
				vimPath = "/usr/local/bin/mvim";
			} {
				vimPath = whichVim;
			};
			vimPath = vimPath.replace("\n", "");
		};

		// thanks to Dionysis Athinaios
		StartUp.add { //do after startup has finished
			var classList, file, hugeString = "syn keyword scObject";
			//collect all class names as strings in a Array
			classList =
			Object.allSubclasses.collect{ arg i; var name;
				name = i.asString;
				hugeString = hugeString + name;
			};
			// TODO as all things this should be not that hardcoded
			//create a file that contains all the names
			file = File("~/.vim/bundle/supercollider/syntax/supercollider_objects.vim".standardizePath,"w");
			file.write(hugeString);
			file.close;
		};
		
	}

	// use this if you want to display the text without the html formatting
	*findHelp {|klass|
		var helpPath;
		var fname;
		var helpString;

		// we create a tmp file -> you need to do that so you can execute sc code from it
		if((helpPath=Help.findHelpFile(klass)).notNil){

			fname = "/tmp/" ++ klass ++ "_help.sc"; // create and cache the file
			
			if(File.exists(fname).not){
				helpString = File.new(helpPath, "r").readAllString.stripHTML.escapeChar('"');

				File.use(fname, "w") { |f|
					f << helpString;
				};
			};

			// read it
			(vimPath + "-R" + fname).unixCmd(postOutput: false);
		} {
			("no help found for " ++ klass).error;
		};
	}


	*openClass{ |klass|
		// TM version only
		var fname, cmd;
		var allClasses = Class.allClasses.collect(_.asString);

		klass = klass.asString;

		if(allClasses.detect{ |str| str == klass }.notNil) { // .includes doesn't work?
			fname = klass.interpret.filenameSymbol;
			cmd = "grep -nh \"^" ++ klass ++ "\" \"" ++ fname ++ "\" > /tmp/grepout.tmp";
			cmd.unixCmd(postOutput: false, action: { 
				File.use("/tmp/grepout.tmp", "r") { |f|
					var content = f.readAllString;
					var split = content.split($:);
					if("^[0-9]+$".matchRegexp(split.first.asString)) {
						/*(vimPath ++ " -R \"" ++ fname ++ "\"").unixCmd(postOutput: false);*/
						(vimPath ++ " -R  +"++ split.first + "\"" ++ fname ++ "\"").unixCmd(postOutput: false);
					} {
						(vimPath ++ " -R \"" ++ fname ++ "\"").unixCmd(postOutput: false);
					};
					f.close;
				};
			});
		}{"sorry class "++klass++" not found".postln}
	}
	
	// TODO improve this to jump to the right implementations even if they are
	// buried in a class extension
	*methodTemplates { |name, openInVIM=true|
		var out, found = 0, namestring, fname;

		name = name.asSymbol;

		out = CollStream.new;
		out << "Implementations of '" << name << "' :\n";
		Class.allClasses.do({ arg class;
			class.methods.do({ arg method;
				if (method.name == name, {

					found = found + 1;
					namestring = class.name ++ ":" ++ name;
					out << "   " << namestring << " :     ";
					if (method.argNames.isNil or: { method.argNames.size == 1 }, {
						out << "this." << name;
						if (name.isSetter, { out << "(val)"; });
					},{
						out << method.argNames.at(0);
						if (name.asString.at(0).isAlpha, {
							out << "." << name << "(";
								method.argNames.do({ arg argName, i;
									if (i > 0, {
										if (i != 1, { out << ", " });
										out << argName;
									});
								});
								out << ")";
							},{
								out << " " << name << " ";
								out << method.argNames.at(1);
							});
						});
						out.nl;
					});
				});
			});
			if(found == 0)
			{
				Post << "\nNo implementations of '" << name << "'.\n";
			}
			{
				if(openInVIM) {
					fname = "/tmp/" ++ Date.seed ++ ".sc";
					File.use(fname, "w") { |f|
						f << out.collection.asString;
						(vimPath + fname).unixCmd(postOutput: false);
					};
				}; 
			};
	}

	*methodReferences { |name, openInVIM=true|
		var out, references, fname;
		name = name.asSymbol;
		out = CollStream.new;
		references = Class.findAllReferences(name);

		if (references.notNil, {
			out << "References to '" << name << "' :\n";
			references.do({ arg ref; out << "   " << ref.asString << "\n"; });

			if(openInVIM) {
				fname = "/tmp/" ++ Date.seed ++ ".sc";
				File.use(fname, "w") { |f|
					f << out.collection.asString;
					(vimPath + "-R" + fname).unixCmd(postOutput: false);
				};
			} {
				out.collection.newTextWindow(name.asString);
			};
		},{
			Post << "\nNo references to '" << name << "'.\n";
		});
	}

	*displayMethods { |variable|
		variable.class.methods.collect(_.name).do(_.postln);	
	}
} // end class
