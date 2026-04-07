#!/bin/bash

if ! nc -zv localhost 80 > /dev/null 2>&1; then
        echo "Порт 80 недоступен"
        exit 1
fi

if [ ! -f /var/www/html/index.nginx-debian.html ]; then
        echo "Файла index.nginx-debian.html несуществует"
        exit 1
fi

exit 0