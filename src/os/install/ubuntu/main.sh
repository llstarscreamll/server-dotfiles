#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_ppa "universe"

update
upgrade

./build-essentials.sh
./misc_tools.sh
./git.sh
./../nvm.sh
./compression_tools.sh
./image_tools.sh
./../npm.sh
./php-dev.sh
./databases.sh
./cleanup.sh
