# Ensure apache2 package is installed
package { 'apache2':
  ensure => installed,
}

# Ensure the /var/www/html directory has the correct ownership and permissions
file { '/var/www/html':
  ensure  => 'directory',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0755',
  require => Package['apache2'],
}

# Ensure that an index.html file exists with correct content and permissions
file { '/var/www/html/index.html':
  ensure  => present,
  content => '<html><h1>Holberton</h1></html>',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
  require => File['/var/www/html'],
}

# Ensure Apache service is running and enabled
service { 'apache2':
  ensure  => running,
  enable  => true,
  require => Package['apache2'],
}

# Ensure correct permissions of the web root
exec { 'fix-apache-permissions':
  command => 'chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html',
  path    => ['/bin', '/usr/bin'],
  onlyif  => 'find /var/www/html/ ! -user www-data',
  require => File['/var/www/html/index.html'],
}

