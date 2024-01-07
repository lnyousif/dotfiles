export PATH=$PATH:~/

export PATH=$PATH:/home/vscode

curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/

# powerline fonts for zsh agnoster theme
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd .. && rm -rf fonts

eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/jandedobbeleer.omp.json)"