#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Databases Engines\n\n"

RELEASE=$(lsb_release -cs)
PASSWORD=$(openssl rand -base64 30)
DATABASE=$(date +%s | sha256sum | base64 | head -c 10 ; echo)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Mysql
install_package "Mysql Server" "mysql-server"
execute "sudo mysql -u root -e \"CREATE USER '$USER'@'localhost' IDENTIFIED BY '$PASSWORD';\"" "create $USER user"
execute "sudo mysql -u root -e \"GRANT ALL PRIVILEGES ON *.* TO '$USER'@'localhost' WITH GRANT OPTION;\"" "grant permissions to $USER"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Postgresql
if ! package_is_installed "postgresql-11"; then

	execute "wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -" "add postgresql repo"
	execute "echo \"deb http://apt.postgresql.org/pub/repos/apt/ $RELEASE\"-pgdg main | sudo tee  /etc/apt/sources.list.d/pgdg.list" "add postgresql repo"

	update &> /dev/null \
        || print_error "Postgresql (resync package index files)"

fi

install_package "Postgresql" "postgresql-11"
# execute "psql -c \"alter user postgres with password '$PASSWORD'\"" "set $PASSWORD password for default postgres user $PASSWORD"
# execute "psql -c \"alter user $USER with password '$PASSWORD'\"" "set $PASSWORD password to $USER postgres user $PASSWORD"
execute "sudo -u postgres createuser $USER" "creating $USER postgres user"
execute "sudo -u postgres createdb $DATABASE -O $USER" "create $DATABASE database"
