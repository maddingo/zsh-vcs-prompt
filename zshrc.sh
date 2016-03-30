### Shows state of the Versioning Control System (e.g. Git, Subversion, Mercurial
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●%f'
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git svn hg cvs
precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats '%F{cyan}[%b%c%u%f%F{cyan}]%f'
    } else {
        zstyle ':vcs_info:*' formats '%F{cyan}[%b%c%u%f%F{red}●%f%F{cyan}]%f'
    }

    vcs_info
}

### Detects the VCS and shows the appropriate sign
function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    svn info >/dev/null 2>/dev/null && echo '⚡' && return
    [[ -d CVS ]] && echo '¤' && return
    echo '%#'
}

### Needed for a pretty prompt
setopt prompt_subst # Enables additional prompt extentions
autoload -U colors && colors    # Enables colours

### My default prompt
PROMPT='%(!.%B%U%F{blue}%n%f%u%b.%F{blue}%n)@%m%f %F{yellow}%~%f$prompt_newline %(!.%F{red}$(prompt_char)%f.$(prompt_char)) %{$reset_color%}'
### My default prompt's right side
#RPROMPT='%F{magenta}%D{%e.%b.%y %H.%M}%f%{$reset_color%}'
RPROMPT='%F{magenta}${vcs_info_msg_0_}%{$reset_color%}'

### My prompt for loops
PROMPT2='{%_}  '

### My prompt for selections
PROMPT3='{ … }  '

### So far I don't use "setopt xtrace", so I don't need this prompt
#PROMPT4=''
