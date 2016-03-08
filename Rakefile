require 'rbconfig'
require 'rake'
require 'fileutils'

task :default => :install

TEST_MODE = ENV['TEST_MODE'].nil? ? false : true

BLACK_LIST = [
  'completion_scripts',
  'vimfiles',
  'paths',
  'basic',
  'completions',
  'aliases',
  'Rakefile',
  'templates',
  'osx',
  'bash_prompt',
  'functions'
]

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

desc "setup Vim"
task :vim => :git_submodules do
  puts "linking vimrc..."
  system "rm -rf ~/.vim"
  system "ln -s ~/dotfiles/vimfiles/ ~/.vim"
  install_file('vimfiles/vimrc', '.vimrc')
  install_file('vimfiles/nvimrc', '.config/nvim/init.vim')
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

desc "instal YCM"
task :ycm do
  chdir "#{ENV['HOME']}/dotfiles/vimfiles/bundle/YouCompleteMe" do
    sh "aptitude install cmake python2.7-dev python-pip" if os == :linux
  ¦ sh "pip install --upgrade pip"
  ¦ sh "pip install neovim"
  ¦ sh "./install.py"
  end
end

#helper functions
$replace_all = true

def path_from_home(file)
 File.join(ENV['HOME'], file)
end

def link_file(source, file)
  puts "linking #{file}"
  system "ln -s ~/dotfiles/#{source} #{file}" unless TEST_MODE
end

def install_file(source, file)
  mkdir_p path_from_home(File.dirname(file))
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
