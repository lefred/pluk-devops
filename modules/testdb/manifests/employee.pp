class testdb::employee {
	mysql::database{"employees":
                ensure   => present,
                require => [ Service['mysql'] ],
        }

        mysql::rights{"Set rights for employees database":
                ensure   => present,
                database => "employees",
                user     => "jenkins",
                password => "jenkins",
                require  => Mysql::Database['employees'],
        }

        exec { "create_employee_db":
                command => "/usr/bin/mysql -u root employees < /tmp/employees_db/employees.sql",
		cwd => "/tmp/employees_db",
		path => ["/usr/bin", "/usr/sbin", "/bin/"],
                subscribe => Mysql::Database['employees'],
		require => Exec["prepare_employee_db"],
                refreshonly => true,
        }

        exec { "prepare_employee_db":
                command => "/bin/tar jxvf /vagrant/files/employees_db-code*.tar.bz2; /bin/tar jxvf /vagrant/files/employees_db-dump*.tar.bz2",
		cwd => "/tmp",
		path => ["/usr/bin", "/usr/sbin", "/bin/"],
                subscribe => Mysql::Database['employees'],
                refreshonly => true,
                require  => Mysql::Database['employees'],
        }
	
	file { "/var/lib/mysql/schema_changes.sql":
                owner => "mysql",
                require => Mysql::Database['employees'],
		source => "puppet:///modules/testdb/schema_changes.sql";
        }

	exec { "change_schema":
		command => "mysql -u root employees < /var/lib/mysql/schema_changes.sql",
		subscribe => File["/var/lib/mysql/schema_changes.sql"],
		path => ["/usr/bin", "/usr/sbin", "/bin/"],
                require => [ Service['mysql'] ],
		refreshonly => true,
	}

}
