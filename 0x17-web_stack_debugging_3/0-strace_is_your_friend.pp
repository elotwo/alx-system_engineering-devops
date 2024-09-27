# This Puppet script fixes file permissions for Apache and ensures the Apache service is running properly.

# Ensure apache2 package is installed
package { 'apache2':
  ensure => installed,
}

# Ensure the web root directory exists with correct permissions
file { '/var/www/html':
  ensure  => directory,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0755',
  require => Package['apache2'],
}

# Ensure the index.html file exists and has the correct permissions
file { '/var/www/html/index.html':
  ensure  => present,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
  content => '<html><head><title>Holberton</title></head><body>Yet another bug by a Holberton student</body></html>',
  require => File['/var/www/html'],
}

# Ensure Apache service is running and enabled
service { 'apache2':
  ensure  => running,
  enable  => true,
  require => [Package['apache2'], File['/var/www/html/index.html']],
}

