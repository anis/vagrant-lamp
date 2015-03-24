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
define githubConfig($path = $name, $owner, $ownerGroup) {
    file { "$path/config":
        ensure => file,
        owner => "$owner",
        group => "$ownerGroup"
    }
    ->
    file_line { "$path/config_github_host":
        ensure => present,
        line   => 'Host github.com',
        path   => "$path/config"
    }
    ->
    file_line { "$path/config_github_hostname":
        ensure => present,
        line   => '    Hostname github.com',
        after  => 'Host github.com',
        path   => "$path/config"
    }
    ->
    file_line { "$path/config_github_keyfile":
        ensure => present,
        line   => '    IdentityFile /home/vagrant/.ssh/github_rsa',
        after  => 'Hostname github.com',
        path   => "$path/config"
    }
}

if $githubSSHKey != undef {
    file { '/home/vagrant/.ssh/github_rsa':
        ensure => file,
        content => $githubSSHKey,
        mode => '0600',
        owner => 'vagrant',
        group => 'vagrant'
    }

    githubConfig { 'vagrant': 
        path => '/home/vagrant/.ssh',
        owner => 'vagrant',
        ownerGroup => 'vagrant',
        require => File['/home/vagrant/.ssh/github_rsa']
    }
}
