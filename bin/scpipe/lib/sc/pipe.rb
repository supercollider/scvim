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
    if @@sclang_path.empty?
      if File.exists?("/Applications/SuperCollider.app/Contents/Resources/sclang")
        return "/Applications/SuperCollider.app/Contents/Resources/sclang"
      else
        warn "Could not find sclang executable.\nPlease make sure that SC is either installed at the default location e.g. '/Applications/SuperCollider.app' on a mac or add sclang to your shells search path."
        exit
      end
    else
      return @@sclang_path
    end
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
        run_pipe
        clean_up
      end

      def pipe_loc
        @@pipe_loc
      end

      def pid_loc
        @@pid_loc
      end

      private

      def prepare_pipe
        File.open(@@pid_loc, "w"){ |f|
          f.puts Process.pid
        }

        if File.exists?(@@pipe_loc)
          warn "there is already a sclang session running, remove it first, than retry"
          exit
        end
        #make a new pipe
        system("mkfifo", @@pipe_loc)
      end

      def run_pipe
        @@pipeproc = Proc.new {
          trap("INT") do
            Process.exit
          end
          rundir = Dir.pwd
          IO.popen("cd #{rundir} && #{SC.sclang_path.chomp} -d #{rundir.chomp} -i scvim", "w") do |sclang|
            loop {
              x = `cat #{@@pipe_loc}`
              sclang.print x if x
            }
          end
        }
        $p = Process.fork { @@pipeproc.call }
      end

      def clean_up
        #if we get a hup then we kill the pipe process and
        #restart it
        trap("HUP") do
          Process.kill("INT", $p)
          $p = Process.fork { @@pipeproc.call }
        end

        #clean up after us
        trap("INT") do
          Process.kill("INT", $p)
          remove_files
          exit
        end
        #we sleep until a signal comes
        sleep(1) until false
      end

      def remove_files
        FileUtils.rm(@@pipe_loc)
        FileUtils.rm(@@pid_loc)
      end
    end
  end
end
