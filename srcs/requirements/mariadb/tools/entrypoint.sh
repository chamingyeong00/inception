#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "데이터베이스 초기화를 시작합니다..."
    
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal > /dev/null

    cat << EOF > /tmp/init.sql
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    mariadbd --user=mysql --bootstrap < /tmp/init.sql
    
    rm -f /tmp/init.sql
    
    echo "MariaDB 초기화가 완료되었습니다."
else
    echo "데이터베이스가 이미 존재합니다. 초기화를 건너뜁니다."
fi

exec "$@"