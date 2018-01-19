[{{ server_user }}]

listen = /var/run/php-{{ server_user }}.sock
listen.mode = 0666
user = {{ server_user }}
group = {{ server_user }}
chdir = {{ server.home }}

access.log = {{ server.home }}/logs/fpm.access.log
php_admin_value[error_log] = {{ server.home }}/logs/fpm.error.log
php_admin_flag[log_errors] = on
php_admin_value[memory_limit] = -1
php_admin_value[upload_tmp_dir] = {{ server.home }}/tmp
php_admin_value[soap.wsdl_cache_dir] = {{ server.home }}/tmp
php_admin_value[upload_max_filesize] = 100M
php_admin_value[post_max_size] = 100M
php_admin_value[open_basedir] = {{ server.home }}/data/:/tmp/:{{ server.home }}/tmp/
;php_admin_value[disable_functions] = exec,passthru,shell_exec,system,proc_open,popen,curl_multi_exec,parse_ini_file,show_source,highlight_file,com_load_typelib
php_admin_value[cgi.fix_pathinfo] = 0
php_admin_value[date.timezone] = {{ server.timezone }}
php_admin_value[apc.cache_by_default] = 0

;From magento conf
php_admin_value[memory_limit] = 256M
php_admin_value[max_execution_time] = 18000
php_admin_flag[zlib.output_compression] = on
php_admin_flag[suhosin.session.cryptua] = off
php_admin_flag[session.auto_start] = off

pm = dynamic
pm.max_children = 10
pm.start_servers = 2
pm.min_spare_servers = 2
pm.max_spare_servers = 4
