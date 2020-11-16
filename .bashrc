# my bash prompt
# install a nerd font if you don't see symbols
# i use caskaydia cove NF
# https://github.com/ryanoasis/nerd-fonts
# https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode

PS1='$(if [[ $? == 0 ]]; then echo "\[\e[33m\]\[\e[m\] \T \[\e[32m\]\[\e[m\]\[\e[36m\]\[\e[m\] \W \[\e[34m\]\[\e[m\]\[\e[35m\]\[\e[m\] [$(seconds2days $SECONDS)] \[\e[31m\]\[\e[m\]"; else echo " \T  \W  [$(seconds2days $SECONDS)] "; fi)\[\e[0m\] '

seconds2days() { # convert integer seconds to Ddays,HH:MM:SS
    printf "%ddays,%02d:%02d:%02d" $(((($1/60)/60)/24)) \
    $(((($1/60)/60)%24)) $((($1/60)%60)) $(($1%60)) |
    sed 's/^1days/1day/;s/^0days,\(00:\)*//;s/^0//' ; }
trap 'SECONDS=0' DEBUG
