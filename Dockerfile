FROM		debian:buster

ENV			AUTOINDEX on

RUN			apt update
RUN			apt upgrade -y
RUN			apt install mariadb-server -y
RUN			apt install wget -y
RUN			apt install -y nginx php php-mbstring php-zip php-gd php-mysql php-fpm php-xml

RUN			echo "daemon off;" >> /etc/nginx/nginx.conf && \
			rm var/www/html/index.nginx-debian.html
COPY		srcs/*.conf /tmp/
RUN			rm -rf /etc/nginx/sites-available/default

RUN			wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.tar.gz && \
			tar -xzvf phpMyAdmin-5.1.0-all-languages.tar.gz && \
			mv phpMyAdmin-5.1.0-all-languages/ /var/www/html/phpmyadmin && \
			rm -rf mv phpMyAdmin-5.1.0-all-languages.tar.gz
COPY		srcs/config.inc.php /var/www/html/phpmyadmin

RUN			wget https://wordpress.org/latest.tar.gz && \
			tar -xzvf latest.tar.gz && \
			mv wordpress /var/www/html/ && \
			rm -rf latest.tar.gz

COPY		srcs/wp-config.php /var/www/html/wordpress
COPY		srcs/.htaccess /var/www/html/wordpress

RUN			chown -R www-data:www-data /var/www/html/*

COPY		srcs/*.sh ./

EXPOSE		80 443

CMD			bash start.sh
