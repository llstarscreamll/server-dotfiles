#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

execute "sudo usermod -a -G www-data $USER" "add $USER user to www-data group"

./nginx.sh
./misc.sh
