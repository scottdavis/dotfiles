# OS
function is_osx
  if uname -s | string match -q 'Darwin'
    return 0
  end

  return 1
end

function is_ubuntu
  if test -f /etc/os-release
    if grep -q "Ubuntu" /etc/os-release
      return 0
    end
  end
  return 1
end

function is_windows
  # Check for Unix-like environments on Windows
  if uname -s | string match -q 'MINGW*' || uname -s | string match -q 'MSYS*' || uname -s | string match -q 'CYGWIN*'
    return 0
  end
  
  # Check for Windows environment variables
  if test -n "$OS" && string match -q '*Windows*' "$OS"
    return 0
  end
  
  # Check for PowerShell environment
  if test -n "$PSModulePath" || test -n "$POWERSHELL_DISTRIBUTION_CHANNEL"
    return 0
  end
  
  return 1
end

# General

function reload
    source ~/.config/fish/config.fish
end

function ls --description 'List contents of directory'
  command ls -lhFG $argv
end

function df --description 'Displays disk free space'
  command df -H $argv
end

function grep --description 'Colorful grep that ignores binary file and outputs line number'
  command grep --color=always -I $argv
end

function create_thumbnails
    for i in $argv
        echo "Processing image $i ..."
        convert -thumbnail 200 $i thumb.$i
    end
end

# Git
function gg --description 'git grep with color'
  command git grep -n --color $argv
end

function git-replace --description "replace all in repo"
  set replace $argv[1]
  set to_replace $argv[2]
  if is_osx
    command git grep -l $replace | xargs sed -i '' -e "s/$replace/$to_replace/g"
  else
    command git grep -l $replace | xargs sed -i '' "s/$replace/$to_replace/g"
  end
end

function gf --description 'Do a git fetch'
  command git fetch
end

function gs --description 'Do a git status'
  command git status
end

function gdeletemergedcurrent --description 'Delete all local branches that is already merged to current branch (exludes master)'
  command git branch --merged | grep -v "\*" | grep -v "master" | xargs -n 1 git branch -d
  command git remote prune origin
end

# SSH
function push_ssh_cert
    if not test -f ~/.ssh/id_dsa.pub
        ssh-keygen -t dsa
    end
    for _host in $argv
        echo $_host
        ssh $_host 'mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys && cat >> ~/.ssh/authorized_keys' < ~/.ssh/id_dsa.pub
    end
end


# Docker

function docker-prune
    docker system prune 
end

function docker-prune-all
    docker system prune -a
end

function docker-prune-volumes
    docker system prune -a --volumes
end

function docker-prune-images
    docker rmi -f (docker images -q)
end

function docker-prune-containers
    docker rm -f (docker ps -a -q)
end

function docker-prune-networks
    docker network rm (docker network ls -q)
end

function docker-run-once
    docker run -it --rm $argv
end

function docker-kill-name
    docker kill (docker ps -q --filter "name=$argv")
end

function docker-rm-name
    docker rm (docker ps -q --filter "name=$argv")
end


if is_ubuntu
    function update
        sudo apt-get update
        sudo apt-get upgrade -y
    end

    function install_deps
        sudo apt-get update
        sudo apt-get install -y build-essential
    end

    function install_docker
        sudo apt-get install ca-certificates curl
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc
        sudo apt-get update
        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        sudo usermod -aG docker $USER
    end
end


