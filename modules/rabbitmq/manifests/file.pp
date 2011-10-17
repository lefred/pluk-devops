class rabbitmq::file {
	file {
		"/usr/lib/rabbitmq/lib/rabbitmq_server-2.6.1/plugins/amqp_client-2.6.1.ez":
			owner   => "root",
			group   => "root",
			source  => "puppet:///modules/rabbitmq/amqp_client-2.6.1.ez",
			require => Class['Rabbitmq::Package'];
		"/usr/lib/rabbitmq/lib/rabbitmq_server-2.6.1/plugins/rabbitmq_stomp-2.6.1.ez":
			owner   => "root",
			group   => "root",
			source  => "puppet:///modules/rabbitmq/rabbitmq_stomp-2.6.1.ez",
			require => Class['Rabbitmq::Package'];
		"/etc/rabbitmq/rabbitmq.config":
			owner   => "root",
			group   => "root",
			source  => "puppet:///modules/rabbitmq/rabbitmq.config",
			notify  => Class['Rabbitmq::Service'],
			require => Class['Rabbitmq::Package'];
	}
}
