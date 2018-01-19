#!/usr/bin/env bash
rm -f ./code/app/etc/config.php
rm -f ./code/app/etc/env.php
rm -f ./code/var/.maintenance.flag
rm -rfd ./code/var/cache/
rm -rfd ./code/var/composer_home/
rm -rfd ./code/var/di/
rm -rfd ./code/var/generation/
rm -rfd ./code/var/log/
rm -rfd ./code/var/page_cache/
rm -rfd ./code/var/view_preprocessed/


php code/bin/magento setup:install --admin-user=admin --admin-password=a123456 --admin-email=admin@example.com --admin-firstname=Admin --admin-lastname=Admin --backend-frontname=manager --db-name=magento --db-user=magento --db-password=magento --base-url=http://magento.test --language=en_US --timezone=Europe/Moscow --currency=USD --use-rewrites=1 --cleanup-database -vvv

# При установке режим по умолчанию default, переключаем в девелоперский режим
php code/bin/magento deploy:mode:set developer
php code/bin/magento indexer:reindex -vvv
