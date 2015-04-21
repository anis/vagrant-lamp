# We need a Apache, NodeJS and PHP installed
class { 'apache':
    mpm_module => "prefork"
}
apache::mod { "rewrite": }

class { 'nodejs':
    version => 'latest'
}
class { 'php': }
-> class {'::apache::mod::php': }

# Let's clone and create a vhost for each of our projects
define project($url) {
    vcsrepo { "/home/vagrant/projects/$name":
        ensure => present,
        provider => git,
        source => $url,
        user => 'vagrant',
        owner => 'vagrant',
        require => GithubConfig['vagrant']
    }
    ->
    apache::vhost { "$name.dev":
        port => 80,
        docroot => "/home/vagrant/projects/$name",
        docroot_owner => "vagrant",
        docroot_group => "vagrant",
        notify        => Class['apache::service'],
        override      => "All",
    }
}

create_resources(project, $projects)

apache::vhost { "local.dev":
    port => 80,
    docroot => "/home/vagrant/projects",
    docroot_owner => "vagrant",
    docroot_group => "vagrant",
    notify        => Class['apache::service']
}