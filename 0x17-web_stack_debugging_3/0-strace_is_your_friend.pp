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
  content => '<title>Holberton &#8211; Just another WordPress site</title>
<link rel="alternate" type="application/rss+xml" title="Holberton &raquo; Feed" href="http://127.0.0.1/?feed=rss2" />
<link rel="alternate" type="application/rss+xml" title="Holberton &raquo; Comments Feed" href="http://127.0.0.1/?feed=comments-rss2" />
        <div id="wp-custom-header" class="wp-custom-header"><img src="http://127.0.0.1/wp-content/themes/twentyseventeen/assets/images/header.jpg" width="2000" height="1200" alt="Holberton" /></div>  </div>
                            <h1 class="site-title"><a href="http://127.0.0.1/" rel="home">Holberton</a></h1>
        <p>Yet another bug by a Holberton student</p>',
  require => File['/var/www/html'],
}

# Ensure Apache service is running and enabled
service { 'apache2':
  ensure  => running,
  enable  => true,
  require => [Package['apache2'], File['/var/www/html/index.html']],
}

