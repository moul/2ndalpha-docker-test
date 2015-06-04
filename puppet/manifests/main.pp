group { 'puppet': ensure => present }
Exec { path => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ] }
File { owner => 0, group => 0, mode => 0644 }

exec { "apt-update":
    command => "/usr/bin/apt-get update"
}
Exec["apt-update"] -> Package <| |>

class {'apt':
  always_apt_update => true,
}

package { [
    'build-essential',
    'curl',
    'htop',
    'gettext'
  ]:
  ensure  => 'installed'
}


include java

import "nginx"