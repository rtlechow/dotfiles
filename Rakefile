IgnoreFiles = %w[. .. .git .gitmodules Rakefile .gitignore]

desc "Install dotfiles"
task :install do
  replace_all = false
  Dir.glob("*", File::FNM_DOTMATCH).each do |file|
    next if IgnoreFiles.include? file
    if File.exist?(File.join(ENV['HOME'], file))
      if File.identical? file, File.join(ENV['HOME'], file)
        puts "identical ~/#{file}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/#{file}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/#{file}"
        end
      end
    else
      link_file(file)
    end
  end
end

desc 'Update submodules'
task :update do
  system %Q{git submodule foreach git pull}
end

def replace_file(file)
  system %Q{rm "$HOME/#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/#{file}"}
end
