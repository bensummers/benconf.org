
require 'fileutils'

FileUtils.mkdir_p('published/assets/css')
FileUtils.mkdir_p('published/assets/img')
FileUtils.mkdir_p('published/site')

Dir.glob('root/**/*.{html,css,js,gif,jpeg,png}').sort.each do |file|
  next if file.include?("/.")
  dest = "published/#{file[5,file.length-1]}"
  puts "#{dest} ..."
  FileUtils.cp(file, dest)
  if dest =~ /\.(html|css|js)\Z/
    system "cd #{File.dirname(dest)} ; cat #{File.basename(dest)} | gzip -9 > #{File.basename(dest)}.gz"
  end
end
