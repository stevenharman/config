# My aliases
alias b='cd -'
alias cls='clear'
alias q='exit' 
alias postgres_start='pg_ctl -D ~/.pgdata -l ~/.pgdata/psql.log start'
alias postgres_stop='pg_ctl -D ~/.pgdata stop'
alias restart='touch tmp/restart.txt'
alias ajaxrdoc="rdoc --fmt ajax --exclude '.*generator.*' --exclude '.*test.*' --exclude '.*spec.*'"
alias devlog='tail -200 -f log/development.log'
alias testlog='tail -200 -f log/test.log'
alias gvim='mvim -p'
alias extip='curl icanhazip.com'

function gitdays {
  git log --author=Steven --reverse --since="$@ days ago" --pretty="format:%n%Cgreen%cd%n%n%s%n%b%n---------------------------------------------" 
}

# accepts a css file and compacts the delcarations to one line
function css_compact {
  cat $@ | css2sass | sass -t compact > $@
}

# hamlizes whatever is on the clipboard
function pbhaml {
  pbpaste | html2haml | pbcopy
}

function md {
  markdown.pl $@ > /tmp/generated_by_markdown.html; open /tmp/generated_by_markdown.html
}
