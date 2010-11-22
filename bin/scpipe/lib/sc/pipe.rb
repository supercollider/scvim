#!/usr/bin/ruby
# 
# SC:Pipe derived from sclang_pipe (SCVIM Package)
# Copyright 2007 Alex Norman under GPL
# 
# modified 2010 stephen lumenta 

require 'fileutils'
require 'singleton'

module SC
  
  class Pipe 
    include Singleton
    
    @@pipe_loc = "/tmp/sclang-pipe"
    # @@rundir = "/Applications/SuperCollider"
    @@rundir = "/Applications/SuperCollider/build/SuperCollider"
    @@pid_loc = "/tmp/sclangpipe_app-pid" 
    @@app = File.join(@@rundir, 'sclang')            
        
    class << self
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
          # FileUtils.rm(@@pipe_loc)
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
          IO.popen("cd #{@@rundir} && #{@@app} -d #{@@rundir.chomp}", "w") do |sclang|
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
