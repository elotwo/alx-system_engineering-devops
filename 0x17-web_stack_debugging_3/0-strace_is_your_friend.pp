# Ensure Apache, MySQL, and PHP are installed
package { ['apache2', 'mysql-server', 'php', 'php-mysql', 'libapache2-mod-php']:
  ensure => installed,
}

# Create the WordPress directory
file { '/var/www/html':
  ensure  => 'directory',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0755',
  require => Package['apache2'],
}

# Download and extract WordPress
exec { 'download_wordpress':
  command => 'wget -P /tmp https://wordpress.org/latest.tar.gz && tar -xzf /tmp/latest.tar.gz -C /tmp && mv /tmp/wordpress/* /var/www/html/',
  path    => '/bin:/usr/bin',
  unless  => 'test -d /var/www/html/wp-content',
  require => File['/var/www/html'],
}

# Ensure proper ownership and permissions of the WordPress directory
exec { 'fix-wordpress-permissions':
  command => 'chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html',
  path    => ['/bin', '/usr/bin'],
  require => Exec['download_wordpress'],
}

# Create MySQL database and user for WordPress
exec { 'setup_database':
  command => 'mysql -u root -e "CREATE DATABASE wordpress; CREATE USER \'wpuser\'@\'localhost\' IDENTIFIED BY \'password\'; GRANT ALL PRIVILEGES ON wordpress.* TO \'wpuser\'@\'localhost\'; FLUSH PRIVILEGES;"',
  path    => '/bin:/usr/bin',
  unless  => 'mysql -u root -e "SHOW DATABASES;" | grep wordpress',
  require => Package['mysql-server'],
}

# Configure wp-config.php for WordPress
file { '/var/www/html/wp-config.php':
  ensure  => 'file',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
  content => template('0x17-web_stack_debugging_3/templates/wp-config.php.erb'),  # Use a template file for dynamic content
  require => Exec['fix-wordpress-permissions'],
}

# Ensure Apache is running and enabled
service { 'apache2':
  ensure => running,
  enable => true,
  require => Package['apache2'],
}

