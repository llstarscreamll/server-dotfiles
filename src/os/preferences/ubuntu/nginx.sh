#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Nginx\n\n"

dir="nginx-vhosts"

# backup default server file
if [ ! \( -e "/etc/nginx/sites-available/default.backup" \) ];then
    execute "sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup" "backup default nginx server file"
fi

for filePath in "$dir"/*;
do
    if [ -f "$filePath" ];then
        fileName="$(sed -e "s/^${dir}\///" <<< $filePath)"
        targetPath="/etc/nginx/sites-available/$fileName"
        targetLink="/etc/nginx/sites-enabled/$fileName"
        
        execute "sudo cp $PWD/$filePath $targetPath" "copy $PWD/$fileName to sites-available"
        execute "sudo ln -fs $targetPath $targetLink" "symb-link $targetPath to $targetLink"
    fi
done

execute "sudo service nginx restart" "restart nginx"