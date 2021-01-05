export PATH=/usr/local/bin:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH=/usr/local/opt/openssl/include:/Users/KenTasaki/.rbenv/shims:/Users/KenTasaki/.rbenv/bin:/Users/KenTasaki/.rbenv/shims:/Users/KenTasaki/.rbenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin

# export PATH=$PATH:$HOME/.nodebrew/current/bin
export PATH="$HOME/.yarn/bin:$PATH"

if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

if [ -f `brew --prefix`/etc/bash_completion ]; then
      . `brew --prefix`/etc/bash_completion
fi


alias relogin='exec $SHELL -l'
alias redis-start='redis-server /usr/local/etc/redis.conf'

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/mysql@5.6/lib"
export CPPFLAGS="-I/usr/local/opt/mysql@5.6/include"

eval "$(pyenv init -)"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export PATH="$PATH:$HOME/flutter_wksp/flutter/bin"
export LC_ALL=en_US.UTF-8

export PATH="$HOME/.nodenv/bin:$PATH"
export PATH=/usr/local/Cellar/openssl@1.1/1.1.1d/bin:$PATH
