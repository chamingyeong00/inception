#!/bin/sh

export WP_CLI_PHP_ARGS='-d memory_limit=512M'

if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "WordPress 초기 설치를 시작합니다..."

    while ! mariadb -h mariadb -u ${DB_USER} -p${DB_PASSWORD} ${DB_NAME} &>/dev/null; do
        echo "MariaDB가 준비될 때까지 기다리는 중..."
        sleep 3
    done
    echo "MariaDB 연결 성공!"

    wp core download --allow-root --path='/var/www/html'

    wp config create \
        --allow-root \
        --dbname=${DB_NAME} \
        --dbuser=${DB_USER} \
        --dbpass=${DB_PASSWORD} \
        --dbhost=mariadb \
        --path='/var/www/html'

    wp core install \
        --allow-root \
        --url=${DOMAIN_NAME} \
        --title="Inception Project" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --skip-email \
        --path='/var/www/html'

    wp user create \
        --allow-root \
        ${WP_USER} \
        ${WP_USER_EMAIL} \
        --user_pass=${WP_USER_PASSWORD} \
        --role=author \
        --path='/var/www/html'

    echo "WordPress 초기화 완료!"
else
    echo "WordPress가 이미 설치되어 있습니다."
fi

chown -R nobody:nobody /var/www/html

exec "$@"