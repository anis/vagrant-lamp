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
define githubConfig($path = $name) {
    file { "$path/config":
        ensure => file
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
        mode => '0600'
    }

    githubConfig { 'vagrant': 
        path => '/home/vagrant/.ssh',
        require => File['/home/vagrant/.ssh/github_rsa']
    }
    githubConfig { 'root':
        path => '/root/.ssh',
        require => File['/home/vagrant/.ssh/github_rsa']
    }
}
