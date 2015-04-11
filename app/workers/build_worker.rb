require "pty"

class BuildWorker
  include Sidekiq::Worker
  def perform(build_id)
    build = Build.find(build_id)
    build.in_progress!

    # result =  %x(ls -la)
    result = ''
    cmd_ = 'xcodebuild'
    # begin
    #   PTY.spawn( cmd_ ) do |r, w, pid|
    #     begin
    #       r.each { |line| print  line; result = line}
    #     rescue Errno::EIO
    #     end
    #   end
    # rescue PTY::ChildExited => e
    #   puts "The child process exited!"
    # end


    # PTY.open {|master, slave|
    #   p master      #=> #<IO:masterpty:/dev/pts/1>
    #   p slave      #=> #<File:/dev/pts/1>
    #   p slave.path #=> "/dev/pts/1"
    # }






    # master, slave = PTY.open
    # read, write = IO.pipe
    # pid = spawn("ls -la", :in=>read, :out=>slave)
    # read.close     # we dont need the read
    # slave.close    # or the slave

    # # pipe "42" to the factor command
    # write.puts "echo 42"

    # # output the response from factor
    # p master.gets #=> "42: 2 3 7\n"

    # # pipe "144" to factor and print out the response
    # write.puts "144"
    # p master.gets #=> "144: 2 2 2 2 3 3\n"
    # write.close # close the pipe


 # security unlock-keychain -p ***** ~/Library/Keychains/login.keychain


#CODE SIGN AND PROVISIONING
"
 security add-certificate ~/Downloads/ios_development\ \(2\).cer
 cp ~/Downloads/StagingDev_AdHoc_Dist.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/
security find-identity -v -p codesigning

@Budowanie
 xcodebuild -project Spotzer.xcodeproj -scheme Neue\ Galerie -archivePath ./export/Neue4.xcarchive archive  CODE_SIGN_IDENTITY='iPhone Distribution: Spotzer Inc'


xcodebuild -exportArchive -exportFormat ipa -archivePath ./export/Neue4.xcarchive -exportPath ./export/Neue4.ipa -exportProvisioningProfile 'NeueGalerie AdHoc Dist'

"

    pid, stdin, stdout, stderr = Open4::popen4 "sh"
    stdin.puts "cd /Users/wojtek/work/razorbear/spotzer/spotzer-ios"
    stdin.puts "xcodebuild -project Spotzer.xcodeproj"

    # stdin.puts "cd /Users/wojtek/Downloads/TicTacToeCreatingAccessibleAppswithCustomUI"
    # stdin.puts "xcodebuild -alltargets clean"
    # stdin.puts "xcodebuild"
    stdin.close

    r_out = stdout.read.strip
    r_err = stderr.read.strip
    puts "stdout     : #{ r_out }"
    puts "stderr     : #{ r_err }"








    build.log = r_out + r_err
    build.save!

    puts result
    build.success!

  rescue => e
    build.log = e.message
    build.save!
    build.fail!
  end
end
