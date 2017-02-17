require 'rbconfig'
require 'rake'
require 'fileutils'

task :default => :install

TEST_MODE = ENV['TEST_MODE'].nil? ? false : true

$files_to_edit = []

def os
@os ||= (
  host_os = RbConfig::CONFIG['host_os']
  case host_os
  when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
    :windows
  when /darwin|mac os/
    :macosx
  when /linux/
    :linux
  when /solaris|bsd/
    :unix
  else
    raise Error::WebDriverError, "unknown os: #{host_os.inspect}"
  end
)
end

task :install => [:vim, :dotfiles]

desc "initalize git submodules" 
task :git_submodules do
  puts "Initializing submodules..."
  submodule_command =  "git submodule init && git submodule update"
  sh submodule_command
  Dir.chdir('vimfiles') do
    puts "Loading vimfiles submodules"
    sh submodule_command
  end
end

task :install_config do
    mkdir_p "~/.config"
    Dir["config/**/*"].each do |file|
        to = file.gsub(%r{config/}, ".config/")
        if File.directory?(file)
            mkdir_p "~/#{to}"
            next
        end
        install_file(file, to)
    end
end

desc "setup Vim"
task :vim do
  rm_rf "~/.vim"
  puts "Installing/Updating vundles..."
  sh   "nvim +BundleInstall! +BundleClean +qa" unless TEST_MODE
  puts "Done!"
end

desc "Link dotfiles" 
task :dotfiles do
  file_list = Dir["dot_configs/*"].to_a
  file_list = file_list.delete_if {|file| File.directory?(File.expand_path(file)) || File.basename(file) == '.' }
  file_list.each {|file| install_file(file, ".#{File.basename(file)}")}
end

#helper functions
$replace_all = true

def path_from_home(file)
  File.join(ENV['HOME'], file)
end

def link_file(source, file)
  puts "linking #{file} to #{source}"
  system "ln -sf ~/dotfiles/#{source} #{file}" unless TEST_MODE
end

def install_file(source, file)
  mkdir_p path_from_home(File.dirname(file)) unless File.dirname(file) == '.'
  file = path_from_home(file)
  if exists?(file)
    if $replace_all
      replace_file(source, file)
    else
      print "overwrite #{file}? [ynaq] "
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


def exists?(file)
  File.exist?(file) || File.symlink?(file)
end

def replace_file(source, file)
  remove_file(file)
  link_file(source, file)
end

def cp_file(from, to)
  if exists?(to)
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
  sh "rm #{path_from_home(file)}" unless TEST_MODE
end
