task :backup => :environment do
  if Dir.exists?("backup")
    puts "'backup' directory exists. move or delete it first"
    exit
  end
  Dir.mkdir("backup")
  Dir.mkdir("backup/scripts")
  Dir.mkdir("backup/pages")
  Page.all.each do |page|
    name = Shellwords.escape(page.name)
    content = page.content
    File.open("backup/pages/#{name}", 'w') do |file|
      file.write(content)
    end
  end
  Script.all.each do |script|
    name = Shellwords.escape(script.name)
    content = script.content
    File.open("backup/scripts/#{name}", 'w') do |file|
      file.write(content)
    end
  end  
end
