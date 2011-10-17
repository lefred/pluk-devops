node percona1 {
        include percona
	#include percona::repository
        #include percona::packages
        #include pacemaker
	include repo::epel
	include repo::puppetlabs
	include myhosts
	include mcollective
	include rabbitmq
	#include foreman
	#include cacti

	#Class['percona::packages'] -> Class['cacti']
	network::if {
		"eth3":
			ip_add		=> "192.168.70.2",
			ip_netmask	=> "255.255.255.0",
			ip_network	=> "192.168.70.0",
			broadcast	=> "192.168.70.255",
			proto		=> "static",
	}
}

node percona2 {
	include percona::repository
        include percona::packages
        #include pacemaker
	include cacti
	include cacti::jmx
	include myhosts
	include testdb::employee
	include percona::toolkit
	include percona::xtrabackup

	Class['percona::packages'] -> Class['cacti'] -> Class['testdb::employee']

	network::if {
		"eth3":
			ip_add		=> "192.168.70.3",
			ip_netmask	=> "255.255.255.0",
			ip_network	=> "192.168.70.0",
			broadcast	=> "192.168.70.255",
			proto		=> "static",
	}
}

node percona3 {
	include percona::repository
        include percona::packages
        #include pacemaker
	include myhosts
	include testdb::employee
	include percona::toolkit
	network::if {
		"eth3":
			ip_add		=> "192.168.70.4",
			ip_netmask	=> "255.255.255.0",
			ip_network	=> "192.168.70.0",
			broadcast	=> "192.168.70.255",
			proto		=> "static",
	}
}

node percona4 {
	include percona::repository
        include percona::packages
        include pacemaker
	include myhosts
	network::if {
		"eth3":
			ip_add		=> "192.168.70.5",
			ip_netmask	=> "255.255.255.0",
			ip_network	=> "192.168.70.0",
			broadcast	=> "192.168.70.255",
			proto		=> "static",
	}
}
