# installs Flask version 2.1.0
class { 'python::pip': }
package { 'flask':
  ensure   => 'installed',
  provider => 'pip3',
  require  => Class['python::pip'],
}
