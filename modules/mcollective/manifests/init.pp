class mcollective ( $user="mcollective", $password="marionette", $host="mcollective" ) {

  $psk            = "unset"
  $stomp_port     = "6163"
  $factsource     = "facter"
  $stomp_user     = $user
  $stomp_password = $password
  $stomp_host     = $host

  include mcollective::plugins
  include mcollective::client
  include mcollective::service
}
