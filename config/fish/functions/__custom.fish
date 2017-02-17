function push_ssh_cert
    if not test -f ~/.ssh/id_dsa.pub
        ssh-keygen -t dsa
    end
    for _host in $argv
        echo $_host
        ssh $_host 'mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys && cat >> ~/.ssh/authorized_keys' < ~/.ssh/id_dsa.pub
    end
end


function replace_all_in_repo
    git greo -l $argv[0] | xargs perl -p -i -e "s/$argv[0]/$argv[1]/g"
end
