class mysql::server::config {

	if $mysql::server::password {
		$password = $mysql::server::password
	} else {
		$password = generate("/usr/bin/pwgen", 20, 1)
	}

	file { '/root/.my.cnf':
		ensure  => 'present',
		path    => '/root/.my.cnf',
		mode    => '0400',
		owner   => 'root',
		group   => 'root',
		content => template('mysql/server/my.cnf.pass.erb'),
		# replace => 'false',
		# require => Exec['mysql_root_password'],
	}

	file { '/root/.my.cnf.backup':
		ensure  => 'present',
		path    => '/root/.my.cnf.backup',
		mode    => '0400',
		owner   => 'root',
		group   => 'root',
		replace => 'false',
		before  => [ Exec['mysql_root_password'] , Exec['mysql_backup_root_my_cnf'] ],
	}

	exec { 'mysql_backup_root_my_cnf':
		require     => Service['mysql'],
		unless      => '/usr/bin/diff /root/.my.cnf /root/.my.cnf.backup',
		command     => '/bin/cp /root/.my.cnf /root/.my.cnf.backup ; true',
		before      => File['/root/.my.cnf'],
	}

	exec { 'mysql_root_password':
		subscribe   => File['/root/.my.cnf'],
		require     => Class['mysql::server::service'],
		refreshonly => true,
		command     => "/usr/bin/mysqladmin --defaults-file=/root/.my.cnf.backup -uroot password '${password}'",
	}

}
