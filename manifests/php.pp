class php {
  # Installs PHP and restarts Apache to load the module
  package { ["php5", "php5-cli", "libapache2-mod-php5", "php-apc", "php5-mysql", "php5-curl", "memcached"]:
    ensure  => installed,
    notify  => Service["apache2"],
    require => [Package["mysql-server"], Package["apache2"]],
  }

  file { "/etc/php5/conf.d/modified_php.ini":
    owner  => root,
    group  => root,
    mode   => 644,
    source  => "/vagrant/files/php/modified_php.ini",
    require => Package["php5"],
    notify => Service["apache2"]
  }

  file { "/etc/php5/conf.d/apc.ini":
    owner  => root,
    group  => root,
    mode   => 644,
    source  => "/vagrant/files/php/apc.ini",
    require => Package["php-apc"],
    notify => Service["apache2"]
  }
}
