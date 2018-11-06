if hash git 2>/dev/null; then # git
  # git aliases
  alias ga='git add'
  alias gb='git branch -a'
  alias gca='git commit --amend --no-edit'
  alias gc='git commit -m'
  alias gco='git checkout'
  alias gd='git diff --color'
  alias gdt='git difftool -y'
  gl(){
    git log -n30 \
      --pretty=format:'%C(yellow)%h|%Cred%ad|%Cblue|%aN|%Cred%d %Creset%s' \
      --date=format:%d.%m | \
        awk -F'|' '{$1=gensub(/[a-f0-9]{2}$/, "", "g", $1);
          $4=gensub(/^(.)\w*\s(\w)\w*\s?(\w?)\w*$/, "\\1\\2\\3", "g", $4);
    print $1, $2, $3$4 $5}' | $PAGER
  }
  alias gpf='git push --force'
  alias gp='git pull --rebase && git submodule update --init --recursive && git push'
  alias gpu='git push -u'
  alias gr='git remote -v'
  alias gri='git rebase -i'
  alias gs='git status'
  alias gsu='git submodule update --init --recursive'
  alias gsi='git submodule init'
  alias gsa='git submodule add'

  alias curl='curl -s'

  if ! type -p __git_complete > /dev/null; then
    __git_complete(){
      complete -o default -o nospace -F $2 $1
    }
  fi
  __git_complete ga _git_add
  __git_complete gb _git_branch
  __git_complete gca _git_commit
  __git_complete gc _git_commit
  __git_complete gco _git_checkout
  __git_complete gd _git_diff
  __git_complete gpf _git_push
  __git_complete gp _git_push
  __git_complete gpu _git_push
  __git_complete gr _git_remote
  __git_complete gs _git_status

  # rebase whole git to change author
  git.author() {
    if [[ -z $1 ]]; then
      echo 'Usage: git.author <email-filter>'
      echo 'E.g: git.author "*@mail.ru|*myoldmail*"'
      return -1
    fi
    git filter-branch -f --env-filter '
    case $GIT_COMMITTER_EMAIL in
    '"$1"')
    export GIT_COMMITTER_NAME=$(git config user.name)
    export GIT_COMMITTER_EMAIL=$(git config user.email)
    export GIT_AUTHOR_NAME=$(git config user.name)
    export GIT_AUTHOR_EMAIL=$(git config user.email)
    ;;
    esac' --tag-name-filter cat -- --branches --tags
  }

  # search unmerged branches
  git.unmerged() {
    git branch -r --no-merged | grep -v HEAD | xargs -L1 git --no-pager log --pretty=tformat:'%Cgreen%d%Creset - %h by %an (%Cblue%ar%Creset)' -1
  }

  # open git project in github
  git.github() {
    o "$(git remote -v | grep origin | awk 'NR==1{print $2}' | sed -r 's|git@(.*):|https://\1/|')" >& /dev/null
  }
fi
