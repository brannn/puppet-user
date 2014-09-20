define user::account( $email, $uid, $groups ) {

  $username = $title

  user { $username:
    comment => $email,
    home    => "/home/$username",
    shell   => '/bin/bash',
    groups  => $groups,
    uid     => $uid
  }

  group { $username:
    gid     => $uid,
    require => User[$username]
  }

  file { "/home/$username/":
    ensure  => directory,
    owner   => $username,
    group   => $username,
    mode    => '0750',
    require => [ User[$username], Group[$username] ]
  }

  file { "/home/$username/.ssh":
    ensure  => directory,
    owner   => $username,
    group   => $username,
    mode    => '0700',
    require => File["/home/$username/"]
  }

  file { "/home/$username/.ssh/authorized_keys":
    ensure  => present,
    owner   => $username,
    group   => $username,
    mode    => '0600',
    require => File["/home/$username/"]
  }

}
