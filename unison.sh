#!/usr/bin/env bash

# ssh-конфиг
ssh_config=$(cd "$PWD/provision" && vagrant ssh-config)

# Пользователь
User=$(echo "$ssh_config" | grep "User " | xargs)
User=${User#"User "}

# Файл ключа
IdentityFile=$(echo "$ssh_config" | grep IdentityFile | xargs)
IdentityFile=${IdentityFile#"IdentityFile "}

# ssh-опции
UserKnownHostsFile=$(echo "$ssh_config" | grep UserKnownHostsFile | xargs | tr ' ' '=')
StrictHostKeyChecking=$(echo "$ssh_config" | grep StrictHostKeyChecking | xargs | tr ' ' '=')
PasswordAuthentication=$(echo "$ssh_config" | grep PasswordAuthentication | xargs | tr ' ' '=')
IdentitiesOnly=$(echo "$ssh_config" | grep IdentitiesOnly | xargs | tr ' ' '=')
LogLevel=$(echo "$ssh_config" | grep LogLevel | xargs | tr ' ' '=')
ForwardAgent=$(echo "$ssh_config" | grep ForwardAgent | xargs | tr ' ' '=')

sshargs="-l ${User} -i ${IdentityFile} -o ${UserKnownHostsFile} -o ${StrictHostKeyChecking} -o ${PasswordAuthentication} -o ${IdentitiesOnly} -o ${LogLevel} -o ${ForwardAgent}"

# Unison-синхронизация

unison . ssh://magento.test//var/www/vagrant/data \
    -auto -batch -repeat 1 -silent -log=false -prefer=newer \
    -sshargs "$sshargs" \
    -ignore "Path .idea" \
    -ignore "Path .git" \
    -ignore "Path backups" \
    -ignore "Path provision" \
    -ignore "Path sample" \
    -ignore "Path code/var" \
    -ignore "Path code/pub/static"
