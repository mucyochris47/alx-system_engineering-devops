# Puppet manifest to configure the SSH client

file { '/home/ubuntu/.ssh/config':
  ensure  => 'file',
  owner   => 'ubuntu',
  group   => 'ubuntu',
  mode    => '0600',
  content => "
    # SSH Client Configuration for connecting to the server using the school private key

    Host *
        IdentityFile ~/.ssh/school
        PasswordAuthentication no
  ",
}

# Ensure that SSH client uses the correct private key
file_line { 'Declare identity file':
  ensure => 'present',
  path   => '/home/ubuntu/.ssh/config',
  line   => 'IdentityFile ~/.ssh/school',
  match  => '^#?IdentityFile',
}

# Ensure password authentication is disabled
file_line { 'Turn off passwd auth':
  ensure => 'present',
  path   => '/home/ubuntu/.ssh/config',
  line   => 'PasswordAuthentication no',
  match  => '^#?PasswordAuthentication',
}

