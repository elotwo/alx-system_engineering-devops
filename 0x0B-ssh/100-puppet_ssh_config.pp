#!/usr/bin/env bash
#
file { '/home/emmanuel/.ssh/config':
  ensure  => file,
  owner   => 'emmanuel',
  group   => 'emmanuel',
  mode    => '0600',
  content => template('ssh/config.erb'),
}

Host *
  IdentityFile ~/.ssh/school
  PasswordAuthentication no

