# Clone git repository

  git clone http://github.com/username/dotvim.git ~/.vim

# create symbol links

  ln -s ~/.vim/vimrc ~/.vimrc
  ln -s ~/.vim/irbrc ~/.irbrc

# Install plugins

  cd ~/.vim
  git submodule init
  git submodule update
