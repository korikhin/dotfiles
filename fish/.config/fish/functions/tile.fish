function tile -d 'Add spacer to the Dock'
    set -l type small-spacer-tile
    contains -- "$argv[1]" -w --wide; and set type spacer-tile
    defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="'$type'";}'
    osascript -e 'tell application "Dock" to quit'
end

complete -c tile -l wide -s w -d 'Add wide spacer to the Dock'
