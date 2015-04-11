# require "pty"
require "open4"

class DashboardController < ApplicationController

  def index
  end


  def start

    # stdin.puts "cd /Users/wojtek/work/razorbear/spotzer/spotzer-ios"
    # stdin.puts "xcodebuild -project Spotzer.xcodeproj"

    # pid, stdin, stdout, stderr = Open4::popen4 "sh"
    # stdin.puts "cd /Users/wojtek/Downloads/TicTacToeCreatingAccessibleAppswithCustomUI"
    # stdin.puts "xcodebuild -alltargets clean"
    # stdin.puts "xcodebuild"
    # stdin.close
    # puts "stdout     : #{ stdout.read.strip }"
    # puts "stderr     : #{ stderr.read.strip }"


    BuildWorker.perform_async(Build.create!.id)

    redirect_to dashboard_index_path
  end
end
