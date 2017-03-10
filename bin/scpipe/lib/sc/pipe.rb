#!/usr/bin/env ruby
#
# SC:Pipe derived from sclang_pipe (SCVIM Package)
# Copyright 2007 Alex Norman under GPL
#
# modified 2010 stephen lumenta
# modified 2012 José Fernández Ramos

require 'fileutils'
require 'singleton'
require 'tmpdir'

module SC

  @@sclang_path = `which sclang`

  def self.sclang_path
    return @@sclang_path unless @@sclang_path.empty?
    # sclang path changed with sc-3.7.2 (https://github.com/supercollider/scvim/pull/11)
    @paths = [
      "/Applications/SuperCollider/SuperCollider.app/Contents/MacOS/sclang",
      "/Applications/SuperCollider.app/Contents/MacOS/sclang",
      "/Applications/SuperCollider/SuperCollider.app/Contents/Resources/sclang",
      "/Applications/SuperCollider.app/Contents/Resources/sclang"
    ]
    @paths.each do |path|
      return path if File.exists?(path)
    end
    warn "Could not find sclang executable.\nPlease make sure that SC is either installed at the default location e.g. '/Applications/SuperCollider.app' on a mac or add sclang to your shells search path."
    exit
  end

  class Pipe
    include Singleton

    @@pipe_loc = File.join(Dir::tmpdir, "sclang-pipe")
    @@pid_loc = File.join(Dir::tmpdir, "sclangpipe_app-pid")

    class << self

      def exists?
        return File.exists?(@@pipe_loc && @@pid_loc)
      end

      def serve
        prepare_pipe
        clean_up
        run_pipe
      end

      def pipe_loc
        @@pipe_loc
      end

      def pid_loc
        @@pid_loc
      end

      private

      def prepare_pipe
        if File.exists?(@@pipe_loc)
          warn "there is already a sclang session running, remove it first, than retry"
          exit
        end
        File.open(@@pid_loc, "w"){ |f|
          f.puts Process.pid
        }
        system("mkfifo", @@pipe_loc)
      end

      def run_pipe
        rundir = Dir.pwd
        loop do
          begin
            IO.popen("#{SC.sclang_path.chomp} -d #{rundir.chomp} -i scvim", "w") do |sclang|
              loop do
                File.open(@@pipe_loc, "r") do |f|
                  x = f.read
                  sclang.print x if x
                end
              end
            end
          rescue SignalException => e
            # Exit on all signals except usr1, which restarts
            unless e.signo == Signal.list["USR1"]
              break
            end
          end
        end
      end

      def clean_up
        at_exit do
          remove_files
        end
      end

      def remove_files
        FileUtils.rm(@@pipe_loc)
        FileUtils.rm(@@pid_loc)
      end
    end
  end
end
