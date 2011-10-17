class percona::xtrabackup {

	package {
		"xtrabackup.$hardwaremodel":
			alias   => "xtrabackup",
			require => [ Class['Percona::Repo'], Package['Percona-Server-shared-compat'] ],
			ensure  => installed;
	}
}
