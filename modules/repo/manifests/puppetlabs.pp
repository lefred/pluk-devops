class repo::puppetlabs {
	yumrepo {
		"puppetlabs":
            		descr       => "Puppetlabs",
            		baseurl     => "http://yum.puppetlabs.com/el/6/products/$hardwaremodel",
            		enabled     => 1,
            		gpgcheck    => 0;
	}
}

