class apache {
  package { "apache2":
    name => "apache2-mpm-prefork",
    ensure => installed,
  }

  file { "/etc/hosts":
    owner  => root,
    group  => root,
    mode   => 644,
    source  => "/vagrant/files/hosts",
  }

  file { "/etc/apache2/conf.d/modified_apache":
    owner  => root,
    group  => root,
    mode   => 644,
    source  => "/vagrant/files/apache/modified_apache.conf",
    require => Package["apache2"],
    notify => Service["apache2"]
  }

  file { "/etc/apache2/mods-available/deflate.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source  => "/vagrant/files/apache/deflate.conf",
    require => Package["apache2"],
    notify => Service["apache2"]
  }

  file { "/etc/apache2/mods-enabled/deflate.conf":
    ensure => symlink,
    target => "/etc/apache2/mods-available/deflate.conf",
    require => Package["apache2"],
    notify => Service["apache2"]
  }

  file { "/etc/apache2/mods-enabled/expires.load":
    ensure => symlink,
    target => "/etc/apache2/mods-available/expires.load",
    require => Package["apache2"],
    notify => Service["apache2"]
  }

  file { "/etc/apache2/mods-enabled/headers.load":
    ensure => symlink,
    target => "/etc/apache2/mods-available/headers.load",
    require => Package["apache2"],
    notify => Service["apache2"]
  }

  file { "/etc/apache2/mods-enabled/rewrite.load":
    ensure => symlink,
    target => "/etc/apache2/mods-available/rewrite.load",
    require => Package["apache2"],
    notify => Service["apache2"]
  }

  file { "/etc/apache2/sites-available/default":
    owner  => root,
    group  => root,
    mode   => 644,
    source  => "/vagrant/files/apache/default.conf",
    require => Package["apache2"],
    notify => Service["apache2"]
  }

  # Ensures the Apache service is running
  service { "apache2":
    ensure  => running,
    subscribe => Package["apache2"],
  }
}
