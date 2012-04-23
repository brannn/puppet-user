define user::account( $email, $uid ) {

  $username = $title

  user { $username:
    comment => $email,
    home    => "/home/$username",
    shell   => '/bin/bash',
    groups  => ['deploy', 'build'],
    uid     => $uid
  }

  group { $username:
    gid     => $uid,
    require => user[$username]
  }

  file { "/home/$username/":
    ensure  => directory,
    owner   => $username,
    group   => $username,
    mode    => '0750',
    require => [ user[$username], group[$username] ]
  }

  file { "/home/$username/.ssh":
    ensure  => directory,
    owner   => $username,
    group   => $username,
    mode    => '0700',
    require => file["/home/$username/"]
  }

  file { "/home/$username/.ssh/authorized_keys":
    ensure  => present,
    owner   => $username,
    group   => $username,
    mode    => '0600',
    require => file["/home/$username/"]
  }

}
