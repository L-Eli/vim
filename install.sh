#!/bin/bash

# Permission required
# if [[ $EUID > 0 ]]
  # then echo "Please run as root."
  # exit
# fi

echo "***********************************"
echo "*                                 *"
echo "*  Author:  Eli Lin               *"
echo "*  Version: 1.0.0                 *"
echo "*  Date:    2019/10/25            *"
echo "*                                 *"
echo "***********************************"
echo ""

# Installing homebrew
os=""
if [[ $OSTYPE == *"darwin"* ]]; then
  echo "💻 Darwin OS detected."
  os="darwin"
fi
echo ""

if [ $os == 'darwin' ]; then
  echo ""
  echo "Installing Homebrew ......"
  printf "Checkout \e[32mhttps://brew.sh/\e[m\n"
  if ! [ -f "/usr/local/bin/brew" ]; then
    # Installing homebrew
    echo "⚠️  You're not installed Homebrew already."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "🏆 Homebrew installed successfully!"
  else
    echo "👍 Homebrew already installed!"
  fi
  echo ""
  echo "--------------------------------------------------"

  packages=(
    "zsh"
    "tmux"
    "git"
    "node"
    "python3"
  )

  # Installing packages
  for i in "${packages[@]}"; do
    echo ""
    echo "Installing ${i} ......"
    if ! [ -f "/usr/local/bin/${i}" ]; then
      echo "⚠️  You're not installed ${i} already."
      brew install $i
      echo "🏆 ${i} installed successfully!"
    else
      echo "👍 ${i} already installed!"
    fi
    echo ""
    echo "--------------------------------------------------"
  done
fi

# Installing oh my zsh
echo ""
echo "Installing oh-my-zsh ......"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "⚠️  You're not installed oh-my-zsh already."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  echo "🏆 oh-my-zsh installed successfully!"
else
  echo "👍 oh-my-zsh already installed!"
fi
echo ""
echo "--------------------------------------------------"

# Installing oh my tmux
echo ""
echo "Installing oh-my-tmux ......"
if [ ! -d "$HOME/.tmux" ]; then
  echo "⚠️  You're not installed oh-my-tmux already."
  git clone https://github.com/gpakosz/.tmux.git $HOME/.tmux
  ln -s -f $HOME/.tmux/.tmux.conf
  echo "🏆 oh-my-tmux installed successfully!"
else
  echo "👍 oh-my-tmux already installed!"
fi
echo ""
echo "--------------------------------------------------"

# Installing zsh plugins
echo ""
echo "Installing zsh plugins ......"
rm -rf $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
rm -rf $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
echo "🏆 Plugins installed successfully!"
echo ""
echo "--------------------------------------------------"

# Installing pip3 neovim client
echo ""
echo "Installing Python Neovim client ......"
pip3 install neovim
echo "🏆 Python Neovim installed successfully!"
echo ""
echo "--------------------------------------------------"

# Installing node neovim package
echo ""
echo "Installing Node Neovim package ......"
npm install -g neovim
echo "🏆 Python Neovim installed successfully!"
echo ""
echo "--------------------------------------------------"

# Copy .zshrc
echo ""
echo "Copying .zshrc into home directory......"
rm $HOME/.zshrc
cp .zshrc $HOME/
echo "🏆 Copy .zshrc to home directory successfully!"
echo ""
echo "--------------------------------------------------"

# Copy .tmux.conf.local
echo ""
echo "Copying .tmux.conf.local into home directory ......"
rm $HOME/.tmux.conf.local
cp .tmux.conf.local $HOME/
echo "🏆 Copy .tmux.conf.local to home directory successfully!"
echo "Sourcing .tmux.conf ......."
tmux source $HOME/.tmux.conf
echo "🏆 Sourced .tmux.conf successfully!"
echo ""
echo "--------------------------------------------------"

# Copy neovim config
echo ""
echo "Copying init.vim into ~/.config/nvim/init.vim"
rm $HOME/.config/nvim/init.vim
cp .config/nvim/init.vim $HOME/.config/nvim/init.vim
echo "🏆 Copy init.vim to ~/.config/nvim/init.vim successfully!"
echo ""
echo "--------------------------------------------------"

# Change default sh to zsh
echo "Changing default shell to zsh ......"
sudo chsh -s /usr/local/bin/zsh
echo "🏆 Default shell change to zsh successfully!"
echo ""

# Neovim plug install
echo "Installing Neovim's plugins ......"
nvim -c "PlugInstall"
echo "🏆 Neovim's plugins installed successfully!"
echo ""

# Switch to zsh
echo ""
/usr/local/bin/zsh

echo "🍺 Congratulations! Installed successfully!"
exit 0
