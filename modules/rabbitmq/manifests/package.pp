class rabbitmq::package {
	package { 
		"rabbitmq-server":
			provider => rpm,
			ensure   => installed,
			source   => "puppet:///modules/rabbitmq/rabbitmq-server-2.6.1-1.noarch.rpm",
	}
}
