IO.foreach("users.txt") { |line|
  parts = line.split(',')
  parts[2].strip!
  sed= '| grep Found | sed \'s/.*"\(.*\)".*/\1/\''
  sed2 = "| grep Pass | sed -e 's/<[^>]*>//g' | sed -e 's/Hash//g' | sed -e 's/Pass//g' | sed -e 's/"+parts[2].to_s+"//g'"
  command = "wget --quiet --post-data=\"term="+parts[2].to_s+"&crackbtn=Crack\ that\ hash\ baby\!\" http://www.md5crack.com/crackmd5.php -O - "+sed
  command2 = "wget --quiet --post-data=\"hash="+parts[2].to_s+"&code=63a34aeb5ad06f69ab08f824c692ba77\" http://gdataonline.com/seekhash.php -O - "+sed2
  
  puts "Passwortcheck für Hash '#{parts[2]}' (#{parts[0]}|#{parts[1]}):"
  
  IO.popen(command, "r") do |pipe|
    result = pipe.read
    if result.empty?
      puts "md5crack kennt diesen Hash noch nicht."
    else
      puts "md5crack sagt: #{result}"
    end
  end
  IO.popen(command2, "r") do |pipe2|
    result2 = pipe2.read
    if result2.empty?
      puts "gdataonline kennt diesen Hash noch nicht"
    else
      puts "gdataonline sagt: #{result2}"
    end
  end
  
  puts "-------------"
  
}

