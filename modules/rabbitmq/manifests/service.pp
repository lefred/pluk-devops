class rabbitmq::service {
	service {
		"rabbitmq-server":
			enable     => true,
			ensure     => running,
			hasrestart => true,
			hasstatus  => true,
			require    => Class['Rabbitmq::File'],
        }
}
