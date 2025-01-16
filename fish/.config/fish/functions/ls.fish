function ls --wraps 'eza --group-directories-first --icons always' -d 'alias ls eza --group-directories-first --icons always'
    eza --group-directories-first --icons always $argv
end
