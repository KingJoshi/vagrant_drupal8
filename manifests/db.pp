class db {
  $root_password = "root"
  $drupal_user = "drupal"
  $drupal_password = "drupal"

  class { "mysql": }
  class { "mysql::server":
    config_hash => { "root_password" => "$root_password" }
  }

  database_user { "$drupal_user@localhost":
    password_hash => mysql_password("$drupal_password")
  }

  file { "/etc/mysql/conf.d/modified_my.cnf":
    owner  => root,
    group  => root,
    mode   => 644,
    source  => "/vagrant/files/mysql/modified_my.cnf",
    require => Class["mysql::server"],
  }

  mysql::db { "drupal":
    user     => "$drupal_user",
    password => "$drupal_password",
    host     => "%",
    grant    => ["all"],
    require => File["/etc/mysql/conf.d/modified_my.cnf"],
  }

  $innodb_log_file_size = 16
  $innodb_log_file_byte_size = $innodb_log_file_size * 1024 * 1024

  # InnoDB does not handle changing log file sizes gracefully.
  # This works around that by stopping MySQL and checking if the log file size
  # matches the configured size, if not the logs are deleted.

  exec { "fix_logfiles":
    command   => "/etc/init.d/mysql stop; rm /var/lib/mysql/ib_logfile0 /var/lib/mysql/ib_logfile1",
    path      => "/usr/bin:/usr/sbin:/bin",
    subscribe => Mysql::Server::Config["innodb"],
    onlyif    => "test -e /var/lib/mysql/ib_logfile0 -a \$(du -b /var/lib/mysql/ib_logfile0 | awk '{ print \$1 }') -ne ${innodb_log_file_byte_size}",
  }

  Mysql::Server::Config["innodb"] -> Exec["fix_logfiles"] -> Exec["mysqld-restart"]

  mysql::server::config { "innodb":
    settings => {
      "mysqld" => {
        "innodb_log_file_size" => "${innodb_log_file_size}M",
      }
    }
  }
}
