# Puppet manifest to kill a process named killmenow
exec { 'kill_killmenow_process':
  command     => '/usr/bin/pkill -f killmenow',
  refreshonly => true,
}
