require 'rake'
require 'fileutils'

task :default => :install

TEST_MODE = true

BLACK_LIST = [
  'completion_scripts',
  'vimfiles',
  'paths',
  'basic',
  'completions',
  'aliases',
  'Rakefile',
  'tempaltes'
]

$files_to_edit = []

task :install => [:vim, :dotfiles] do
  Rake::Task["edit_templates"].execute unless TEST_MODE
end
desc "initalize git submodules" 
task :git_submodules do
  puts "Initializing submodules..."
  sh   "git submodule init && git submodule update"
end

desc "setup Vim"
task :vim => :git_submodules do
  puts "linking vimrc..."
  install_file('vimfiles/vimrc', '.vimrc')
  puts "Installing/Updating vundles..."
  sh   "vim +BundleInstall! +BundleClean +qa" unless TEST_MODE
  puts "Done!"
end

desc "Link dotfiles" 
task :dotfiles do
  file_list = Dir["*"].to_a
  file_list = file_list.delete_if { |file| BLACK_LIST.include?(file) }.compact 
  file_list.each {|file| install_file(file, ".#{file}")}
end

desc "install local dot file templates" 
task :install_tempaltes do
  Dir['templates/**/*'].each do |file|
    puts "Installing template: #{file}"
    new_file = path_from_home(".#{File.basename(file)}")
    $files_to_edit << new_file
    cp_file(file, new_file)
  end
end

desc "Edit templates" 
task :edit_templates => [:install_tempaltes] do
  $files_to_edit.each do |file|
    sh `vim #{file}`
  end
end

#helper functions
$replace_all = false

def path_from_home(file)
 File.join(ENV['HOME'], file)
end

def link_file(source, file)
  puts "linking ~/#{file}"
  system %Q{ln -s "$PWD/#{source}" "$HOME/#{file}"} unless TEST_MODE
end

def install_file(source, file)
  if File.exist?(path_from_home(file))
    if $replace_all
      replace_file(source, file)
    else
      print "overwrite #{path_from_home(file)}? [ynaq] "
      case $stdin.gets.chomp
        when 'a'
          $replace_all = true
          replace_file(source, file)
        when 'y'
          replace_file(source, file)
        when 'q'
          exit
      else
        puts "skipping ~/#{file}"
      end
    end
  else
    link_file(source, file)
  end
end

def replace_file(source, file)
  remove_file(file)
  link_file(source, file)
end

def cp_file(from, to)
  if File.exist?(to)
    print "overwrite #{to} [yn]"
    case $stdin.gets.chomp
    when 'y'
      remove_file(to)
      puts "Copying file #{from} to #{to}"
      FileUtils.cp(from, to) unless TEST_MODE
    else
      puts "Skipping: #{to}"
    end
  else
    puts "Copy file #{from} to #{to}"
    FileUtils.cp(from, to) unless TEST_MODE
  end
end

def remove_file(file)
  puts "removing #{file}"
  FileUtils.unlink(path_from_home(file)) unless TEST_MODE
end