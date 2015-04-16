# We need a Apache, NodeJS and PHP installed
class { 'apache': }
class { 'nodejs':
    version => 'latest'
}
class { 'php': }

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
        notify        => Class['apache::service']
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