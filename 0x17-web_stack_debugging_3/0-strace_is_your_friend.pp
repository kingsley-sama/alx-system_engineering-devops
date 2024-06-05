class { 'apache':
  mpm_module => 'prefork',
}

class { 'apache::mod::php': }

package { 'php':
  ensure  => installed,
  require => Class['apache'],
}

package { 'php-mysql':
  ensure  => installed,
  require => Package['php'],
}

service { 'apache2':
  ensure    => running,
  enable    => true,
  subscribe => Package['php'],
}

exec { 'update_apt':
  command => '/usr/bin/apt-get update',
  path    => '/usr/bin',
  before  => Package['apache2'],
}

package { 'apache2':
  ensure  => installed,
  require => Exec['update_apt'],
}
