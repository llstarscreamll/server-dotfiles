#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Misc\n\n"

if ! grep -q "max_user_watches=524288" /etc/sysctl.conf; then
    execute "echo \"fs.inotify.max_user_watches=524288\" | sudo tee -a /etc/sysctl.conf" "set max files watches=524288"
    execute "sudo sysctl -p"
fi
