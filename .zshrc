# import oh my zsh 
# https://github.com/ohmyzsh/ohmyzsh
export ZSH="/home/Junguler/.oh-my-zsh"

# install a nerd font if you don't see symbols
# i use caskaydia cove NF
# https://github.com/ryanoasis/nerd-fonts
# https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode
PROMPT='$(if [[ $? == 0 ]]; then echo "%F{226}%K{237} %F{214}%f %D{%I:%M:%S} %F{154}%F{34}%f $(shrink_path -f) %F{45}%F{33}%f 0ms %F{177}%F{127} %f%k"; else echo "  %D{%H:%M:%S}  $(shrink_path -f)  "; fi) '

# function for showing elapsed time in PROMPT
function preexec() {
  timer=$(date +%s%3N)
}

function precmd() {
  if [ $timer ]; then
    local now=$(date +%s%3N)
    local d_ms=$(($now-$timer))
    local d_s=$((d_ms / 1000))
    local ms=$((d_ms % 1000))
    local s=$((d_s % 60))
    local m=$(((d_s / 60) % 60))
    local h=$((d_s / 3600))
    if ((h > 0)); then elapsed=${h}h${m}m
    elif ((m > 0)); then elapsed=${m}m${s}s
    elif ((s >= 10)); then elapsed=${s}.$((ms / 100))s
    elif ((s > 0)); then elapsed=${s}.$((ms / 10))s
    else elapsed=${ms}ms
    fi

	PROMPT='$(if [[ $? == 0 ]]; then echo "%F{226}%K{237} %F{214}%f %D{%I:%M:%S} %F{154}%F{34}%f $(shrink_path -f) %F{45}%F{33} %f${elapsed} %F{177}%F{127} %f%k "; else echo "  %D{%H:%M:%S}  $(shrink_path -f)  ${elapsed}   "; fi)'
    unset timer
  fi
}

# %F{11}%F{3}%F{10}%F{2}%F{14}%F{6}%F{12}%F{4}%F{13}%F{5}%F{9}%F{1}

# my aliases
alias ls='ls -a --color=auto'
alias notor='youtube-dl.exe --proxy ""'
alias gmic='/c/Games/gmic/gmic.exe'
alias mpv='/c/Games/mpv/mpv.exe'
alias mpvre='/c/Games/mpv/mpv.exe --vf=sub,lavfi="negate"'
alias ari='aria2c'
alias pari='aria2c --http-proxy="http://127.0.0.1:9080"'
alias pcurl='curl -x socks5h://localhost:9050'
alias python2='/usr/bin/python2.7.exe'
alias python3='/usr/bin/python3.8.exe'
alias lolcat='/usr/bin/lolcat'
alias waifu='/c/games/waifu2x/waifu2x.exe'
alias proxy64='/c/Games/proxychains/x64/proxychains.exe -f "C:\Games\proxychains\proxychains.conf"'

#my functions
primit () { for i in *.jpg; do echo $i; primitive -i $i -o p-$i."$1" -n "$2" -m "$3"; done; }
# 0=combo , 1=triangle , 2=rect , 3=ellipse , 4=circle , 5=rotatedrect , 6=beziers , 7=rotatedellipse , 8=polygon
# primitive -i input.png -o output.png -n 100 -m 1
# -s outputsize
gmic+ () { for i in *.jpg; do echo $i; gmic $i "$@" -o g-$i; done; }
ffseq () { ffmpeg -y -i "$@" -c:v mjpeg -q:v 2 -pix_fmt yuvj444p -sn -an -threads 0 image-%06d.jpg; }
ffvid () { cat *.jpg | ffmpeg -framerate "$1" -f image2pipe -i - -codec copy "$2"; }
ffvil () { cat *.jpg | ffmpeg -framerate "$1" -f image2pipe -i - "$2"; }
ffpri () { cat p-*.jpg | ffmpeg -framerate "$1" -f image2pipe -i - "$2"; }
ffgmi () { cat g-*.jpg | ffmpeg -framerate "$1" -f image2pipe -i - "$2"; }
audi () { youtube-dl.exe "$@" -f 140; while [ $? -ne 0 ]; do torip ; youtube-dl.exe "$@" -f 140; done; }
vide () { youtube-dl.exe "$@" -f 135+140; while [ $? -ne 0 ]; do torip ; youtube-dl.exe "$@" -f 135+140; done; }
vihd () { youtube-dl.exe "$@" -f bestvideo[ext=mp4]+140; while [ $? -ne 0 ]; do torip ; youtube-dl.exe "$@" -f bestvideo[ext=mp4]+140; done; }
mama () { youtube-dl.exe "$@" -f 160+140 -k; while [ $? -ne 0 ]; do torip ; youtube-dl.exe "$@" -f 160+140 -k; done; }
stream () { streamlink --player-passthrough hls "$@";}
streamp () { streamlink --https-proxy "socks5h://127.0.0.1:9050" "$@"; while [ $? -ne 0 ] ; do torip ; streamlink --https-proxy "socks5h://127.0.0.1:9050" "$@"; done ;}
streamr () { streamlink -o "output.ts" --https-proxy "socks5h://127.0.0.1:9050" "$@"; while [ $? -ne 0 ] ; do torip ; streamlink -o "output.ts" --https-proxy "socks5h://127.0.0.1:9050" "$@"; done ;}
streamr2 () { streamlink --https-proxy "socks5h://127.0.0.1:9050" -O "$0" | tee recording.ts | mpv - ;}
vimpv () { http_proxy=http://127.0.0.1:9080 mpv "$@"; while [ $? -ne 0 ] ; do torip ; http_proxy=http://127.0.0.1:9080 mpv "$@"; done ;}
aumpv () { http_proxy=http://127.0.0.1:9080 mpv --no-video "$@"; while [ $? -ne 0 ] ; do torip ; http_proxy=http://127.0.0.1:9080 mpv --no-video "$@"; done ;}
fflis () { for f in ./*."$1"; do echo "file '$f'" >> mylist.txt; done; }
ffmer () { ffmpeg -f concat -safe 0 -i mylist.txt -c copy output."$1"; rm mylist.txt; }
#pcurl () { curl -x socks5h://localhost:9050 "$@" ; while [ $? -ne 0 ] ; do torip ; curl -x socks5h://localhost:9050 "$@" ; done ;}
toon () { curl \
	-F 'image=@'$@''\
	-H 'api-key:83046935-b6e8-4a27-94fe-f639162ea4df'\
	https://api.deepai.org/api/toonify ; }
# api-key:quickstart-QUdJIGlzIGNvbWluZy4uLi4K'
toow () { curl \
	-F 'image='$@''\
	-H 'api-key:83046935-b6e8-4a27-94fe-f639162ea4df'\
	https://api.deepai.org/api/toonify ; }

#ohmyfish plugins
plugins=(
	zsh-autosuggestions
	fast-syntax-highlighting
	zsh-completions
	shrink-path
	z
)

# load autocompletions
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# disable window switching and other annoyences when using tab complete
setopt NO_BEEP AUTO_LIST HIST_IGNORE_ALL_DUPS globdots #MENU_COMPLETE

#source ~/.bashrc
bindkey -e
# control+u to remove the whole line behind cursor
bindkey \^U backward-kill-line
# control+o to remove a word before behind cursor
bindkey \^O backward-kill-word
# control+p to remove a word after behind cursor
bindkey \^P kill-word

# fzf config (using fd)
# https://github.com/junegunn/fzf
# https://github.com/sharkdp/fd
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden --color=always"
export FZF_DEFAULT_OPTS="--ansi --height 100%"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d --hidden"

# remove underline on web links
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# use go language in cygwin
#alias primitive='/c/Games/cygwin64/home/Junguler/code/gowork/bin/primitive.exe'
export GOROOT="C:/Games/cygwin64/home/Junguler/go"
export PATH=$PATH:$HOME/go/bin
export GOPATH="C:/Games/cygwin64/home/Junguler/code/gowork"

# history size and directory
#HISTFILE=~/.zsh_history
#HISTSIZE=999999999
#SAVEHIST=$HISTSIZE

# start the terminal with a bling
# install figlet from cygwin repo
# compile lolcat-c from https://github.com/jaseg/lolcat
#figlet -c -t -f slant j u n g u l e r | lolcat-c -v 1 -h 1

# echo the date and time when opening the terminal
#echo $(date +"%y / %m / %d  -  %I : %M : %S") | figlet -c -t -f slant | lolcat-c -v 1 -h 1
