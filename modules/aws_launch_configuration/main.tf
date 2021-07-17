# Get secret for workshop
data "vault_generic_secret" "ha_web" {
  path = "aws/ha_web"
}

resource "aws_launch_configuration" "main" {
  name            = "wp-launch-conf"
  image_id        = "ami-09c18af55c950e78f"
  instance_type   = "t2.small"
  security_groups = [var.wp_sg_id, var.db_client_sg_id, var.fs_client_sg_id, var.cache_client_sg_id]
  user_data       = <<EOFMAIN
  #!/bin/bash -xe

EFS_MOUNT="${var.efs_dns_name}"

DB_NAME="wordpress"
DB_HOSTNAME="${var.write_instance_dns}"
DB_USERNAME="wpadmin"
DB_PASSWORD="${data.vault_generic_secret.ha_web.data["master_password"]}"

WP_ADMIN="wpadmin"
WP_PASSWORD="${data.vault_generic_secret.ha_web.data["wpadmin_password"]}"

LB_HOSTNAME="${var.lb_dns_name}"

yum update -y
yum install -y awslogs httpd24 mysql56 php55 php55-devel php55-pear php55-mysqlnd gcc-c++ php55-opcache

mkdir -p /var/www/wordpress
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 $EFS_MOUNT:/ /var/www/wordpress

## create site config
cat <<EOF >/etc/httpd/conf.d/wordpress.conf
ServerName 127.0.0.1:80
DocumentRoot /var/www/wordpress/wordpress
<Directory /var/www/wordpress/wordpress>
  Options Indexes FollowSymLinks
  AllowOverride All
  Require all granted
</Directory>
EOF

## install cache client
pecl install igbinary-2.0.8
wget -P /tmp/ https://s3.amazonaws.com/aws-refarch/wordpress/latest/bits/AmazonElastiCacheClusterClient-1.0.1-PHP55-64bit.tgz
tar -xf '/tmp/AmazonElastiCacheClusterClient-1.0.1-PHP55-64bit.tgz'
cp 'AmazonElastiCacheClusterClient-1.0.0/amazon-elasticache-cluster-client.so' /usr/lib64/php/5.5/modules/
if [ ! -f /etc/php-5.5.d/50-memcached.ini ]; then
    touch /etc/php-5.5.d/50-memcached.ini
fi
echo 'extension=igbinary.so;' >> /etc/php-5.5.d/50-memcached.ini
echo 'extension=/usr/lib64/php/5.5/modules/amazon-elasticache-cluster-client.so;' >> /etc/php-5.5.d/50-memcached.ini

## install wordpress
if [ ! -f /bin/wp/wp-cli.phar ]; then
   curl -o /bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
   chmod +x /bin/wp
fi
# make site directory
if [ ! -d /var/www/wordpress/wordpress ]; then
   mkdir -p /var/www/wordpress/wordpress
   cd /var/www/wordpress/wordpress
   # install wordpress if not installed
   # use public alb host name if wp domain name was empty
   if ! $(wp core is-installed --allow-root); then
       wp core download --version='4.9' --locale='en_GB' --allow-root
       wp core config --dbname="$DB_NAME" --dbuser="$DB_USERNAME" --dbpass="$DB_PASSWORD" --dbhost="$DB_HOSTNAME" --dbprefix=wp_ --allow-root
       wp core install --url="http://$LB_HOSTNAME" --title='Wordpress on AWS' --admin_user="$WP_ADMIN" --admin_password="$WP_PASSWORD" --admin_email='admin@example.com' --allow-root
       wp plugin install w3-total-cache --allow-root
       # sed -i \"/$table_prefix = 'wp_';/ a \\define('WP_HOME', 'http://' . \\$_SERVER['HTTP_HOST']); \" /var/www/wordpress/wordpress/wp-config.php
       # sed -i \"/$table_prefix = 'wp_';/ a \\define('WP_SITEURL', 'http://' . \\$_SERVER['HTTP_HOST']); \" /var/www/wordpress/wordpress/wp-config.php
       # enable HTTPS in wp-config.php if ACM Public SSL Certificate parameter was not empty
       # sed -i \"/$table_prefix = 'wp_';/ a \\# No ACM Public SSL Certificate \" /var/www/wordpress/wordpress/wp-config.php
       # set permissions of wordpress site directories
       chown -R apache:apache /var/www/wordpress/wordpress
       chmod u+wrx /var/www/wordpress/wordpress/wp-content/*
       if [ ! -f /var/www/wordpress/wordpress/opcache-instanceid.php ]; then
         wget -P /var/www/wordpress/wordpress/ https://s3.amazonaws.com/aws-refarch/wordpress/latest/bits/opcache-instanceid.php
       fi
   fi
   RESULT=$?
   if [ $RESULT -eq 0 ]; then
       touch /var/www/wordpress/wordpress/wordpress.initialized
   else
       touch /var/www/wordpress/wordpress/wordpress.failed
   fi
fi

## install opcache
if [ ! -d /var/www/.opcache ]; then
    mkdir -p /var/www/.opcache
fi
# enable opcache in /etc/php-5.5.d/opcache.ini
sed -i 's/;opcache.file_cache=.*/opcache.file_cache=\/var\/www\/.opcache/' /etc/php-5.5.d/opcache.ini
sed -i 's/opcache.memory_consumption=.*/opcache.memory_consumption=512/' /etc/php-5.5.d/opcache.ini
# download opcache-instance.php to verify opcache status
if [ ! -f /var/www/wordpress/wordpress/opcache-instanceid.php ]; then
    wget -P /var/www/wordpress/wordpress/ https://s3.amazonaws.com/aws-refarch/wordpress/latest/bits/opcache-instanceid.php
fi

chkconfig httpd on
service httpd start
EOFMAIN
}