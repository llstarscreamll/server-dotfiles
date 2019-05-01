#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   PHP Dev\n\n"

install_package "python-software-properties"

if ! package_is_installed "php7.0"; then

    add_ppa "ondrej/php" \
        || print_error "PHP (add PPA)"

    update &> /dev/null \
        || print_error "PHP (resync package index files)"

fi

install_package "Nginx" "nginx"
execute "sudo apt install --allow-unauthenticated -qqy php7.3 php7.3-fpm php7.3-cli php7.3-sqlite3 php7.3-common php7.3-curl php7.3-gd php7.3-json php7.3-mbstring php7.3-mysql php-pgsql php7.3-readline php7.3-xml php7.3-bcmath php7.3-gmp php7.3-intl php7.3-zip zip unzip sqlite3 libsqlite3-dev" "install php7.3"
install_package "Composer" "composer"
install_package "Supervisor" "supervisor"
