class mysql::server::service {

  service { 'mysql':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['mysql::server::package'],
    # subscribe  => File['/etc/postfix/main.cf']
  }
}
