class rabbitmq::install ( $stomp_user, $stomp_password ) {
	exec {
		"delete_guess":
			command     => "rabbitmqctl delete_user guest",
			path        => "/usr/sbin",
			refreshonly => true,
			require     => Class['Rabbitmq::Package'];
		"add_user":
			command     => "rabbitmqctl add_user $stomp_user $stomp_password",
			path        => "/usr/sbin",
			refreshonly => true,
			require     => Class['Rabbitmq::Package'];
		"add_permission":
			command     => "rabbitmqctl set_permissions $stomp_user \".*\" \".*\" \".*\"",
			path        => "/usr/sbin",
			refreshonly => true,
			require     => Exec['add_user'];
	}
}
