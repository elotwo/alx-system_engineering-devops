# this script fix the 500 error automate it using puppet
file { '/var/www/html/some_directory':
  ensure  => 'directory',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0755',
  require => Package['apache2'],
}

service { 'apache2':
  ensure    => 'running',
  enable    => true,
  subscribe => File['/var/www/html/some_directory'],
}
