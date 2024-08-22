package {'nginx':
ensure => installed,
}
service {'nginx':
ensure => running,
enable => true,
require => Package['nginx'],
}
file{'/etc/nginx/sites-available/default':
ensure => file,
content => template('/etc/nginx/default.conf.erb'),
require => Package['nginx'],
}
nginx::resource::site{'default':
ensure =>present,
require => File['/etc/nginx/sites-available/default'],
}
exec {'reload-nginx':
command => '/usr/sbin/nginx -s reload',
require => Nginx::Resource::Site['default'],
}
