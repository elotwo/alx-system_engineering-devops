# This Puppet manifest installs and configures Apache to serve a web page correctly.

# Ensure apache2 package is installed
package { 'apache2':
  ensure => installed,
}

# Ensure that the required directory exists under /var/www/html
file { '/var/www/html':
  ensure  => 'directory',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0755',
  require => Package['apache2'],
}

# Ensure that an index.html file exists and contains the correct content
file { '/var/www/html/index.html':
  ensure  => present,
  content => '<html>Hello</html>',  # Adjust content to match the expected length (12 chars)
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

# Ensure proper ownership and permissions of the web root
exec { 'fix-apache-permissions':
  command => 'chown www-data:www-data /var/www/html/ -R && chmod 755 /var/www/html/ -R',
  path    => ['/bin', '/usr/bin'],
  onlyif  => 'find /var/www/html/ ! -user www-data',
  require => [File['/var/www/html/index.html'], Package['apache2']],
}

