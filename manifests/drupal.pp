class drupal {
  $USER = "vagrant"

  file { "/home/$USER/.vimrc":
    mode   => 644,
    source  => "/vagrant/files/vimrc",
  }

  file { "/home/$USER/drupal_files":
    owner  => www-data,
    group  => www-data,
    mode   => 777,
    ensure => "directory",
  }

  file { "/shared/www/sites/default":
    owner  => www-data,
    group  => www-data,
    mode   => 777,
    ensure => "directory",
  }

  exec { "create_settings_php":
    command => "cp /shared/www/sites/default/default.settings.php /shared/www/sites/default/settings.php",
    path    => ["/usr/bin/", "/bin/"],
    require => File["/shared/www/sites/default"],
    onlyif  => "test ! -f /shared/www/sites/default/settings.php",
  }

  file { "/shared/www/sites/default/files":
    ensure => symlink,
    owner  => www-data,
    group  => www-data,
    mode   => 777,
    target => "/home/$USER/drupal_files",
    require => [ File["/shared/www/sites/default"], File["/home/$USER/drupal_files"] ],
  }

  cron { test_drupal:
    command => "curl http://drupal8.test/cron.php",
    user    => root,
    minute  => 0,
    require => File["/shared/www/sites/default/files"],
  }
}

