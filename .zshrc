# Lines configured by zsh-newuser-install
# home/rik/linuxtoolbox/zsh-autocomplete

#source ./linuxtoolbox/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ./linuxtoolbox/F-Sy-H/F-Sy-H.plugin.zsh

export PATH=/home/rik/.cargo/bin:$PATH



HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/rik/.zshrc'




alias mux=tmuxinator
alias vim=nvim
alias sys-monitor=btop





eval "$(starship init zsh)"
# End of lines added by compinstall
