# Update apt package list
exec { 'update_apt':
  command => '/usr/bin/apt-get update',
  path    => '/usr/bin',
}

# Install Apache2 package
package { 'apache2':
  ensure  => installed,
  require => Exec['update_apt'],
}

# Install PHP and related modules
package { 'php':
  ensure  => installed,
  require => Exec['update_apt'],
}

package { 'libapache2-mod-php':
  ensure  => installed,
  require => Package['php'],
}

package { 'php-mysql':
  ensure  => installed,
  require => Package['php'],
}

# Ensure Apache2 service is running and enabled
service { 'apache2':
  ensure    => running,
  enable    => true,
  subscribe => Package['php'],
}

# Restart Apache2 service to apply changes
exec { 'restart_apache2':
  command     => '/usr/sbin/service apache2 restart',
  refreshonly => true,
  subscribe   => Package['libapache2-mod-php'],
}
