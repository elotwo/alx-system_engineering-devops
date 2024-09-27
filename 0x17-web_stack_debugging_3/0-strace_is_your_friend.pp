# This Puppet script fixes file permissions for Apache and ensures the Apache service is running properly.

# Ensure apache2 package is installed
package { 'apache2':
  ensure  => installed,
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
  ensure  => file,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
  content => '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Holberton - Just another WordPress site</title>
</head>
<body>
    <h1 class="site-title"><a href="http://127.0.0.1/" rel="home">Holberton</a></h1>
    <p>Yet another bug by a Holberton student</p>
</body>
</html>',
  require => File['/var/www/html'],
}

# Ensure Apache service is running and enabled
service { 'apache2':
  ensure  => running,
  enable  => true,
  require => [Package['apache2'], File['/var/www/html/index.html']],
}

# Validate Apache configuration
exec { 'validate-apache-config':
  command     => '/usr/sbin/apachectl configtest',
  path        => ['/usr/sbin', '/bin'],
  refreshonly => true,
  subscribe   => Service['apache2'],
}

# Restart Apache if the configuration is changed
exec { 'restart-apache':
  command      => '/bin/systemctl restart apache2',
  refreshonly  => true,
  subscribe    => Exec['validate-apache-config'],
}

