# Apache Web Server Configuration

package { 'apache2':
  ensure => installed,
}

service { 'apache2':
  ensure  => running,
  enable  => true,
  require => Package['apache2'],
}

file { '/var/www/html':
  ensure  => 'directory',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0755',
  require => Package['apache2'],
}

file { '/var/www/html/index.html':
  ensure  => present,
  content => '<html>Hello World!</html>',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
  require => File['/var/www/html'],
}

exec { 'fix-apache-permissions':
  command     => 'chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html',
  path        => ['/bin', '/usr/bin'],
  onlyif      => 'find /var/www/html/ ! -user www-data',
  require     => File['/var/www/html/index.html'],
}

