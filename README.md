Clone git repository
--------------------

    git clone git@github.com:MrTime/dotfiles.git ~/.vim

create symbol links
-------------------

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/irbrc ~/.irbrc

Install plugins
---------------

    cd ~/.vim
    git submodule init
    git submodule update
