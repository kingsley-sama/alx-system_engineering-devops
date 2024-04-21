# Removes ssh password and sets up ssh authentication
file { '/tmp/school.sh':
  ensure  => file,
  mode    => '0777',
  owner   => 'ubuntu',
  content => @(END),
    #!/usr/bin/env bash
    # Generates an new key that uses rsa encoding and is stored in scool
    sudo sed -i 's/^.*PasswordAuthentication.*$/PasswordAuthentication no/' /etc/ssh/ssh_config
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/school
    END
}
exec { 'generate_rsa_key':
  command => '/bin/bash /tmp/school.sh',
  path    => '/usr/bin:/bin',
  user    => 'ubuntu',
}

