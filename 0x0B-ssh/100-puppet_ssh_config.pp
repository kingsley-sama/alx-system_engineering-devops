file { '/home/ubuntu/.ssh/config':
  ensure  => file,
  mode    => '0600',               # Set file permissions to 0600
  owner   => 'ubuntu',
  content => @(END),
    Host your_server_ip
      IdentityFile ~/.ssh/school
      PasswordAuthentication no
  END
}

exec { 'generate_rsa_key':
  command     => '/usr/bin/ssh-keygen -t rsa -b 4096 -f /home/ubuntu/.ssh/school',
  creates     => '/home/ubuntu/.ssh/school', # Only run if the key doesn't exist
  path        => '/usr/bin',                 # Set the PATH to ensure ssh-keygen is found
  user        => 'ubuntu',
  refreshonly => true,                       # Only execute when needed
}
