complete -c starp -a "(for f in ~/.config/starship/*.toml; test -f $f; and basename $f .toml; end)" \
    -d "Starship profile"

