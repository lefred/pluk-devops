class percona::packages {

	package {
		"Percona-Server-server-55.$hardwaremodel":
            		alias => "MySQL-server",
            		require => Class['Percona::Repo'],
			ensure => "installed";
		"Percona-Server-client-55.$hardwaremodel":
            		alias => "MySQL-client",
            		require => Class['Percona::Repo'],
			ensure => "installed";		
		"mysql-libs":
			ensure => "absent";		
		"Percona-Server-shared-compat":
			require => [ Class['Percona::Repo'], Package['mysql-libs'], Package['MySQL-client'] ],
			ensure => "installed";
	}
}

