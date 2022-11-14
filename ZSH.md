## Install ZSH
`apt install zsh`

## Set Zsh as default shell
`chsh -s /bin/zsh`

## Install OhMyZsh
`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

## Install Powerlevel10k Font
https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k

## Clone Powerlevel10k Zsh theme
`git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`

## Set ZSH_THEME="powerlevel10k/powerlevel10k" in ~/.zshrc.

`sed -i 's/ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc`

## Set the proper terminal

`echo 'export TERM=xterm-256color' >> ~/.zshrc`
