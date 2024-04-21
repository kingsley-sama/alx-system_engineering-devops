# Removes ssh password and sets up ssh authentication
file { '/tmp/school.sh':
  ensure  => file,
  mode    => '0777',
  owner   => 'ubuntu',
  content => @(END),
    #!/usr/bin/env bash
    # Generates an new key tha
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/school
    END
}
# Puppet script to create ssh config file
file_line { 'Turn off passwd auth':
  ensure => 'present',
  path   => '/etc/ssh/ssh_config',
  line   => '    PasswordAuthentication no',
}
exec { 'generate_rsa_key':
  command => '/bin/bash /tmp/school.sh',
  path    => '/usr/bin:/bin',
  user    => 'ubuntu',
}

