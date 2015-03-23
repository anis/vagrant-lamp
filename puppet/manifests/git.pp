# Configure information about the commiter
if $gitUser != undef {
    git::config { 'user.name':
        value => $gitUser,
        user  => 'vagrant'
    }
}

if $gitEmail != undef {
    git::config { 'user.email':
        value => $gitEmail,
        user  => 'vagrant'
    }
}

# Configure the private key used to connect to Github.com
if $githubSSHKey != undef {
    file { '/home/vagrant/.ssh/github_rsa':
        ensure => file,
        content => $githubSSHKey
    }

    file { '/home/vagrant/.ssh/config':
        ensure => file
    }
    ->
    file_line { 'github_privatekey_host':
        ensure => present,
        line   => 'Host github.com',
        path   => '/home/vagrant/.ssh/config'
    }
    ->
    file_line { 'github_privatekey_hostname':
        ensure => present,
        line   => '    Hostname github.com',
        after  => 'Host github.com',
        path   => '/home/vagrant/.ssh/config'
    }
    ->
    file_line { 'github_privatekey_keyfile':
        ensure => present,
        line   => '    IdentityFile /home/vagrant/.ssh/github_rsa',
        after  => 'Hostname github.com',
        path   => '/home/vagrant/.ssh/config'
    }
}