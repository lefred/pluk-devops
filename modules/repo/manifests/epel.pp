class repo::epel {
        "epel":
          descr    => "EPEL repository",
          baseurl  => "http://mirror.eurid.eu/epel/6/$hardwaremodel/",
          gpgcheck => "0",
          enabled  => "1";
}

