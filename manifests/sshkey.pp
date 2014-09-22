define user::sshkey( $key, $type ) {

  $username = $title

  ssh_authorized_key{ $key:
    ensure  => present,
    key     => $key,
    type    => $type,
    user    => $username,
    require => File["/home/$username/.ssh/authorized_keys"]
  }
}
