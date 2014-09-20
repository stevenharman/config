# My aliases
alias b='cd -'
alias cls='clear'
alias sr='screen -r'
alias restart='touch tmp/restart.txt'
alias ajaxrdoc="rdoc --fmt ajax --exclude '.*generator.*' --exclude '.*test.*' --exclude '.*spec.*'"
alias be='bundle exec'
alias devlog='tail -200 -f log/development.log'
alias testlog='tail -200 -f log/test.log'
alias gvim='mvim -p'
alias mysql_start='mysql.server start'
alias mysql_stop='mysql.server stop'
alias pg_start='pg_ctl -D ~/.pgdata -l ~/.pgdata/psql.log start'
alias pg_stop='pg_ctl -D ~/.pgdata stop -s -m fast'
alias redis_start='redis-server /usr/local/etc/redis.conf'

function gitdays {
  git log --author=Steven --reverse --since="$@ days ago" --pretty="format:%n%Cgreen%cd%n%n%s%n%b%n---------------------------------------------"
}

# Open a file in Marked.app. Usage: $ marked path/to/file.markdown
function marked {
  open -a Marked.app $@
}

