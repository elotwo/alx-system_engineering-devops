# Ensure apache2 package is installed
package { 'apache2':
  ensure => installed,
}

# Ensure that the required directory exists under /var/www/html
file { '/var/www/html/some_directory':
  ensure  => 'directory',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0755',
  require => Package['apache2'],
}

# Ensure Apache service is running and enabled
service { 'apache2':
  ensure  => running,
  enable  => true,
  require => Package['apache2'],
}

# Ensure proper ownership and permissions of the web root
exec { 'fix-apache-permissions':
  command => 'chown www-data:www-data /var/www/html/ -R && chmod 755 /var/www/html/ -R',
  path    => ['/bin', '/usr/bin'],
  onlyif  => 'find /var/www/html/ ! -user www-data',
  require => [File['/var/www/html/some_directory'], Package['apache2']],
}

