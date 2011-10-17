class rabbitmq ( $stomp_user="mcollective", $stomp_password="marionette" ) {
	include rabbitmq::package
	include rabbitmq::file
	include rabbitmq::service

	class { 'rabbitmq::install':
			stomp_user     => $stomp_user,
			stomp_password => $stomp_password,
	}
}
