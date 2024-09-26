# Ensure Nginx is installed
package { 'nginx':
  ensure => installed,
}

# Manage the Nginx service
service { 'nginx':
  ensure => running,
  enable => true,
}

# Nginx configuration file
file { '/etc/nginx/nginx.conf':
  ensure  => file,
  content => template('nginx/nginx.conf.erb'),
  notify  => Service['nginx'], # Restart Nginx if the config changes
}

# Create Nginx configuration template
file { '/etc/nginx/nginx.conf':
  ensure => present,
  mode   => '0644',
  content => @("END"),
worker_processes auto;

events {
    worker_connections 1024;  # Increase the number of connections per worker
    multi_accept on;          # Accept as many connections as possible per event loop
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    # Buffers and Timeouts
    client_body_buffer_size 16K;
    client_max_body_size 8M;
    client_header_buffer_size 1k;
    large_client_header_buffers 4 8k;

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;

    keepalive_timeout 65;
    keepalive_requests 100;
    reset_timedout_connection on;
    server_tokens off;

    # Gzip Compression
    gzip on;
    gzip_disable "msie6";
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

    server {
        listen       80;
        server_name  localhost;

        location / {
            root   /var/www/html;  # Set the document root
            index  index.html index.htm;
        }
    }
}
END
}

# Ensure the default site configuration is in place
file { '/etc/nginx/sites-available/default':
  ensure => link,
  target => '/etc/nginx/nginx.conf',
}

