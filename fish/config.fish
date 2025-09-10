starship init fish | source
set fish_greeting
if status is-interactive
pyenv init - fish | source

end

function starp
    if test (count $argv) -eq 0
        echo "Usage: starp <profile_name> | starp -l"
        return 1
    end

    if test (count $argv) -eq 1; and test "$argv[1]" = "-l"
        for f in ~/.config/starship/*.toml
            if test -f $f
                set name (basename $f .toml)
                echo "$name"
            end
        end
        return 0
    end

    set profile $argv[1]
    set config_path ~/.config/starship/$profile.toml
    set target_path ~/.config/starship.toml

    if test -f $config_path
        ln -sf $config_path $target_path
        echo "Starship profile switched to '$profile'"
        exec fish
    else
        echo "Profile '$profile' does not exist!"
        return 1
    end
end

