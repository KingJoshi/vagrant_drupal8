class drupal_dev_env {
	stage { "pre":  before  => Stage["main"] }
  include apache
  include db
  include php
  include drupal
  include misc

  class { 'update_system':
    stage => pre
  }

  class update_system {
  	exec { 'apt-get update':
  	  command => 'apt-get update',
      path    => ['/bin', '/usr/bin'],
    }
  }
}

include drupal_dev_env
