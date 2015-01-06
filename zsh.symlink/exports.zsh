export BUNDLE_JOBS=3
export CDPATH=:~/code
export CLICOLOR=1
export EDITOR="vim"
export GEM_OPEN_EDITOR="vim"
export GOPATH="$HOME/code/go"
export JAVA_HOME='/System/Library/Frameworks/JavaVM.framework/Home'
RUSTPATH="$HOME/.rust"
export PATH="/usr/local/bin:/usr/local/sbin:$HOME/Library/bin:$RUSTPATH/bin:$GOPATH/bin:$PATH"
export DYLD_LIBRARY_PATH="$RUSTPATH/lib:$DYLD_LIBRARY_PATH"
export PGOPTIONS='-c client_min_messages=WARNING'
export RBXOPT=-X19
export RUBY_GC_MALLOC_LIMIT=100000000
# Ruby 1.9
export RUBY_HEAP_MIN_SLOTS=40000
export RUBY_FREE_MIN=500000
# Ruby 2.1
export RUBY_GC_HEAP_INIT_SLOTS=40000
export RUBY_GC_HEAP_FREE_SLOTS=500000
#export VISUAL="mvim -f"
