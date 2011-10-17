class percona::service {

	service {
                "mysql":
                        enable  => true,
                        ensure  => running,
                        require => Class['percona::packages']
	}
}
