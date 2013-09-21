#!/usr/bin/env ruby

# copyright 2010 sbl
# part of the supercollider textmate bundle

require 'fileutils'
require 'sc/pipe'

module SC
  class Dispatcher
    def initialize
      unless SC::Pipe.exists?
        raise "Please run a sclang session first."
      end
      @pipe = SC::Pipe.pipe_loc
    end

    def interpret(sc_code)
      open(@pipe, "w") { |io| io << sc_code << "\x0c" }
    end

    def interpret_silent(sc_code)
      open(@pipe, "w") { |io| io << sc_code << "\x1b" }
    end
  end
end
