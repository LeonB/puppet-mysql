class mysql::server::package {

  file { '/var/cache/debconf/mysql-server.preseed':
    ensure  => $mysql::server::ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    content => template('mysql/server/mysql-server.preseed.erb'),
  }

  package  { $mysql::server::package_name:
    ensure       => present,
    responsefile => '/var/cache/debconf/mysql-server.preseed',
    require      => File['/var/cache/debconf/mysql-server.preseed'],
  }

  # make sure password doesn't linger on server
  # exec { '/bin/rm /var/cache/debconf/mysql-server.preseed':
  #   onlyif  => '/usr/bin/test -f /var/cache/debconf/mysql-server.preseed',
  #   require => Package[$mysql::server::package_name],
  # }

}
