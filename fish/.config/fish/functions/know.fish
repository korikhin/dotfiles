function know -d 'Show help for the fish shell or a command'
    help $argv &>/dev/null; and return
    { $argv -h; or $argv --help } 2>/dev/null | bat -pl help
    return $pipestatus[1]
end
