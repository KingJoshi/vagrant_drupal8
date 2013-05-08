class misc {
  package { "git":
    ensure => present,
  }

  package { "phpmyadmin":
    ensure  => installed,
    notify  => Service['apache2'],
    require => [Package['php5'], Package['mysql-client'], Package['apache2']],
  }

  package { "htop":
    ensure => present,
  }

  package { "lynx":
    ensure => present,
  }
}

