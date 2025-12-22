#zshの設定
#ファイル: zshrc

# zplug
#source ~/.zplug/init.zsh
#zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# 非同期処理できるようになる
#zplug "mafredri/zsh-async"
# テーマ(ここは好みで。調べた感じpureが人気)
# zplug "sindresorhus/pure"
# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
#zplug "zsh-users/zsh-syntax-highlighting"
# コマンド入力途中で上下キー押したときの過去履歴がいい感じに出るようになる
#zplug "zsh-users/zsh-history-substring-search"
# 過去に入力したコマンドの履歴が灰色のサジェストで出る
#zplug "zsh-users/zsh-autosuggestions"
# 補完強化
#zplug "zsh-users/zsh-completions"
# 256色表示にする
#zplug "chrissicool/zsh-256color"
# コマンドライン上の文字リテラルの絵文字を emoji 化する
#zplug "mrowa44/emojify", as:command
#zplug "rupa/z", use:z.sh
# Install plugins if there are plugins that have not been installed
#if ! zplug check --verbose; then
#  printf "Install? [y/N]: "
#  if read -q; then
#    echo; zplug install
#  fi
#fi
# Then, source plugins and add commands to $PATH
#zplug load
#これがないと、[delete]キーがSpaceの挿入になってしまう
# [[ $TERM = "eterm-color" ]] && TERM=xterm-color
# export TERM="tmux-256color"

# デフォルトではキー入力ののち10msのディレイが発生する
# その遅延を無くしたいなら0に設定する
export KEYTIMEOUT=0

#
# set +o ksharrays
# set +o shwordsplit

# autoload -U compinit
# compinit 
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
	                             /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
#キーの設定
#どのようなショートカットキーが設定されているかはbindkey -Lを実行すれば一覧表示される
#Emacsライクキーバインド設定
# bindkey -e
#viライクキーバインド設定
bindkey -v
# bindkey "^?"    backward-delete-char
# bindkey "^H"    backward-delete-char
# bindkey "^[[3~" delete-char
# bindkey "^[[1~" beginning-of-line
# bindkey "^[[4~" end-of-line
# bindkey "^W" kill-region
# bindkey "^Y" yank
# bindkey "^[Y" yank-pop

# M-f/M-bの挙動をEmacsのそれに合わせる（実はM-bは元々同じだけど一応）
bindkey "^[f" emacs-forward-word
bindkey "^[b" emacs-backward-word
# M-f/M-b/M-dなどでの単語境界の基準をEmacsライクに
export WORDCHARS=""

bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
setopt no_flow_control

#プロンプトの設定
#色は%{${fg[blue]}%}と%{${reset_color}%}で指定し、
#上の二つの間に記述する。
# %d    ワークディレクトリー
# %n    ユーザー名
# %M    localhost.localhost
# %m    localhost
#autoload colors\n colorsはblueなどの名前で色を指定する時に必要
autoload -Uz colors
colors
RPROMPT="%{${fg[blue]}%}[ %d ]%{${reset_color}%}"
case ${UID} in
0)
	PROMPT="%B%{${fg[red]}%}[%{${fg[green]}%}%m@%{${fg[red]}%}%n]%%%{${reset_color}%} "
	PROMPT2="%B%{${fg[red]}%}[%{${fg[green]}%}%m@%{${fg[red]}%}%n]%%%{${reset_color}%} "
    SPROMPT="%B%{${fg[blue]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    ;;
*)
# 	PROMPT="%{${fg[blue]}%}[%{${fg[green]}%}${HOST%%.*}@%{${fg[blue]}%}%n]%%%{${reset_color}%} "
	PROMPT="%{${fg[blue]}%}[%{${fg[green]}%}%m@%{${fg[blue]}%}%n]%%%{${reset_color}%} "
	PROMPT2="%{${fg[blue]}%}[%{${fg[green]}%}${HOST%%.*}@%{${fg[blue]}%}%n]%%%{${reset_color}%} "
    SPROMPT="%{${fg[blue]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    ;;
esac 

#色
zstyle ':completion:*' list-colors ''
#ls
export LS_COLORS='di=34:ln=36:so=32:pi=33:ex=32:bd=33:cd=31:su=32:sg=32:tw=34:ow=34'
#alias ls="ls --color "

# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt EXTENDED_HISTORY
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 余分な空白は詰めて記録
setopt hist_reduce_blanks  
# 古いコマンドと同じものは無視 
setopt hist_save_no_dups
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 補完時にヒストリを自動的に展開         
setopt hist_expand
# 履歴をインクリメンタルに追加
setopt inc_append_history
#コマンド履歴ファイルを共有する設定
setopt share_history

# キーバインディング
# history search
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
# インクリメンタルからの検索
bindkey "^B" history-incremental-search-backward
bindkey "^F" history-incremental-search-forward

#メニューで候補を選択する
bindkey '^i'	expand-or-complete
bindkey '^[^i'	reverse-menu-complete
#コマンド履歴の検索機能はCtrl-PとCtrl-Nに割り当てられ、
#複数行の編集には↓↑←→を使うといった風にすみわけができる。
# autoload history-search-end
# zle -N history-beginning-search-backward-end history-search-end
# zle -N history-beginning-search-forward-end history-search-end
# bindkey '^[p' history-beginning-search-backward-end
# bindkey '^[n' history-beginning-search-forward-end
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
zle -N fzf-locate
bindkey '^l' fzf-locate

#ディレクトリ名を入力するだけでカレントディレクトリを変更できる。  
setopt auto_cd
#"cd -[タブ]"で、これまでに移動したディレクトリ一覧が表示され、
#表示されている番号を押してリターンキーで、そのディレクトリへ移動できる。 
setopt auto_pushd
# 同じディレクトリを pushd しない
setopt pushd_ignore_dups
#これはパスの最後に付くスラッシュ(/)を自動的に削除させないためのものである。
#デフォルトでは自動的に削除されるのだが、
#それではコマンドの意味が変わってしまうことがある。
#この設定は有効にしておいた方が無難だろう。
setopt noautoremoveslash

#タブキーをおせばいろいろと補完候補が表示されるわけだが、
#下を設定しておくと補完候補がつめて表示されるようになる。 
setopt list_packed

#補完
#補完候補がいっぱい出てきたときサクサク選ぶための設定。
#これで補完候補を選ぶとき ^F で前に進む、
#^Nで下の行へとかemacsっぽい操作で選べるようになる。
#zstyle ':completion:*:default' menu select=1
#zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できるようにします
setopt magic_equal_subst 
# 8ビット目を通すようになり、日本語のファイル名などを見られるようにします。
setopt print_eightbit
# 履歴追加時にスペースは削除します。
setopt hist_reduce_blanks
#補完候補表示時などにピッピとビープ音をならないように設定
setopt nolistbeep 

#先方予測
autoload predict-on
#predict-on

#リダイレクト
#zshのリダイレクトを有効にする
setopt multios

# zsh オプション設定 set -o,set +o
# kshの配列のように添字を0から始める
# set -o ksharrays
# クオートなしの変数展開時に展開された値を空白文字で分割(ワード分割)する
# これをonにしないと空白区切の文字列で配列を初期化できない。
# 例 TEST="shwordsplit ksharrays zsh";array=($TEST)
# 上の例ではzshは通常ワード分割をしないため一つの文字列ここでは"shwordsplit ksharrays zsh"
# でこれをワード分割を有効にするとshwordsplit ksharrays zshに展開され配列を変数で初期化できる。
# set -o shwordsplit

#キー入力ののディレイ
export KEYTIMEOUT=0
#rcsrc
if [ -f /etc/rc.d/rcsrc ]; then
   source  /etc/rc.d/rcsrc
fi
if [ -f /etc/rc.d/rcsrcadmin ]; then
	source /etc/rc.d/rcsrcadmin
fi

