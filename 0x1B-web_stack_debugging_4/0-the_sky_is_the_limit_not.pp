package {'nginx':
ensure => installed,
}
service {'nginx':
ensure => running,
enable => true,
subscribe => File['/etc/nginx/sites-enabled/2-app_server-nginx_config'],
}
service {'flask_app':
ensure => running,
enable => true,
subscribe => File['/path/to/your/flask/app/config/file'],
}
file { '/etc/nginx/sites-enabled/2-app_server-nginx_config':
  ensure  => file,
  require => Service['nginx'],
  notify  => Service['nginx'],
}
file { '/path/to/your/flask/app/config/file':
  ensure  => file,
  notify  => Service['flask_app'],
}
file { '/etc/nginx/nginx.conf':
  ensure  => file,
  notify  => Service['nginx'],
}
